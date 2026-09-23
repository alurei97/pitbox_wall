import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../core/error/either.dart';
import '../../../core/network/dio_factory.dart';
import '../../results/domain/entities/qualifying_result.dart';
import '../../results/domain/entities/race_result.dart';
import '../../results/domain/repositories/results_repository.dart';
import '../../schedule/domain/entities/race.dart';
import '../../schedule/domain/repositories/schedule_repository.dart';
import '../../standings/domain/repositories/standings_repository.dart';
import '../domain/ai_assistant_service.dart';

/// Groq AI assistant service - fast inference with generous free tier.
class GroqAiAssistantService implements AiAssistantService {
  GroqAiAssistantService({
    required this.scheduleRepository,
    required this.standingsRepository,
    required this.resultsRepository,
    String? apiKey,
    Dio? dio,
  }) : _apiKey = (apiKey ?? '').trim(),
       _dio = dio ?? DioFactory().groq();

  // Current production models from console.groq.com/docs/models
  static const _modelNames = [
    'openai/gpt-oss-120b',
  ];

  final ScheduleRepository scheduleRepository;
  final StandingsRepository standingsRepository;
  final ResultsRepository resultsRepository;
  final String _apiKey;
  final Dio _dio;

  @override
  Stream<String> streamAnswer({
    required String question,
    required List<AiChatTurn> history,
  }) async* {
    if (_apiKey.isEmpty) {
      throw const AiAssistantException(
        'Add your GROQ_API_KEY to the .env file and restart the app to enable Pitbox AI.\n'
        'Get a free key at https://console.groq.com/keys',
      );
    }

    // First, try to answer from local data (instant, no API call)
    final localAnswer = await tryAnswerLocally(question);
    if (localAnswer != null) {
      debugPrint('[GroqAiAssistant] Answered from local data');
      yield localAnswer;
      return;
    }

    debugPrint('[GroqAiAssistant] Building season context…');
    final context = await buildSeasonContext();
    debugPrint('[GroqAiAssistant] Context ready (${context.length} chars), calling Groq…');

    final systemPrompt = _systemPrompt(context);
    final messages = <Map<String, dynamic>>[
      {'role': 'system', 'content': systemPrompt},
      ...history.map(
        (turn) => {
          'role': turn.isUser ? 'user' : 'assistant',
          'content': turn.text,
        },
      ),
      {'role': 'user', 'content': question},
    ];

    const maxAttemptsPerModel = 2;
    for (final modelName in _modelNames) {
      for (var attempt = 1; attempt <= maxAttemptsPerModel; attempt++) {
        var chunkCount = 0;
        try {
          final response = await _dio
              .post<ResponseBody>(
                '/chat/completions',
                data: {
                  'model': modelName,
                  'messages': messages,
                  'stream': true,
                  'temperature': 0.3,
                  'max_tokens': 1024,
                },
                options: Options(
                  headers: {
                    'Authorization': 'Bearer $_apiKey',
                    'Content-Type': 'application/json',
                  },
                  responseType: ResponseType.stream,
                  sendTimeout: const Duration(seconds: 10),
                  receiveTimeout: const Duration(seconds: 30),
                ),
              )
              .timeout(const Duration(seconds: 30));

          var pending = '';
          final byteStream = response.data!.stream.timeout(const Duration(seconds: 30));
          await for (final bytes in byteStream) {
            pending += utf8.decode(bytes, allowMalformed: true);
            final lines = pending.split('\n');
            // Keep the last (possibly incomplete) line for the next chunk.
            pending = lines.removeLast();

            for (final line in lines) {
              if (!line.startsWith('data: ')) continue;
              final data = line.substring(6).trim();
              if (data == '[DONE]') continue;
              if (data.isEmpty) continue;

              try {
                final json = jsonDecode(data) as Map<String, dynamic>;
                final choices = json['choices'] as List<dynamic>?;
                if (choices == null || choices.isEmpty) continue;

                final delta = choices.first['delta'] as Map<String, dynamic>?;
                final content = delta?['content'] as String?;
                if (content != null && content.isNotEmpty) {
                  chunkCount++;
                  yield content;
                }
              } catch (_) {
                // Ignore parse errors on partial chunks
              }
            }
          }

          debugPrint('[GroqAiAssistant] $modelName stream complete ($chunkCount chunks)');
          if (chunkCount == 0) {
            debugPrint('[GroqAiAssistant] $modelName returned empty response, trying next model…');
            throw AiAssistantException('Empty response from $modelName');
          }
          return;
        } on DioException catch (e) {
          debugPrint('[GroqAiAssistant] $modelName attempt $attempt error: ${e.message}');
          if (e.response != null) {
            debugPrint('[GroqAiAssistant] Response status: ${e.response?.statusCode}');
            // Read the error response body if it's a stream
            if (e.response?.data is ResponseBody) {
              final body = e.response!.data as ResponseBody;
              final chunks = <int>[];
              await for (final chunk in body.stream) {
                chunks.addAll(chunk);
              }
              final errorText = utf8.decode(chunks, allowMalformed: true);
              debugPrint('[GroqAiAssistant] Response error: $errorText');
            } else {
              debugPrint('[GroqAiAssistant] Response data: ${e.response?.data}');
            }
          }

          if (e.response?.statusCode == 401) {
            throw const AiAssistantException(
              'Your GROQ_API_KEY looks invalid. Check the .env file.',
            );
          }

          if (e.response?.statusCode == 429) {
            debugPrint('[GroqAiAssistant] Rate limited, waiting before retry…');
            await Future<void>.delayed(Duration(seconds: attempt * 3));
            continue;
          }

          if (chunkCount > 0) {
            throw AiAssistantException('Groq error: ${e.message}');
          }
        } on TimeoutException {
          debugPrint('[GroqAiAssistant] $modelName attempt $attempt timed out');
          if (chunkCount > 0) {
            throw const AiAssistantException('Pitbox AI took too long to respond. Try again.');
          }
        } catch (e) {
          debugPrint('[GroqAiAssistant] $modelName attempt $attempt unexpected error: $e');
          if (chunkCount > 0) throw AiAssistantException('AI error: $e');
        }
        await Future<void>.delayed(Duration(seconds: attempt * 2));
      }
      debugPrint('[GroqAiAssistant] $modelName exhausted, trying next model…');
    }

    throw const AiAssistantException(
      'Pitbox AI is busy across all models right now. Try again shortly.',
    );
  }

  @override
  Future<String> buildSeasonContext() async {
    debugPrint('[GroqAiAssistant] Fetching schedule…');
    final schedule = switch (await scheduleRepository.getSeasonSchedule()) {
      Left(value: final failure) => throw AiAssistantException(failure.message),
      Right(value: final value) => value,
    };

    debugPrint('[GroqAiAssistant] Fetching standings…');
    final standings = switch (await standingsRepository.getCurrentStandings()) {
      Left(value: final failure) => throw AiAssistantException(failure.message),
      Right(value: final value) => value,
    };

    final now = DateTime.now();
    final races = schedule.races;
    final completedRaces = races.where((race) => race.statusAt(now) == RaceStatus.past).toList();
    final nextRace = races.where((race) => race.statusAt(now) != RaceStatus.past).firstOrNull;

    // Full season of results (season API + Drift cache — cheap after round 1, no extra
    // network cost since every round is already cached from the Results tab).
    final lastCompletedRound = completedRaces.isEmpty
        ? 0
        : completedRaces.map((race) => race.round).reduce((a, b) => a > b ? a : b);

    debugPrint('[GroqAiAssistant] Fetching season results through round $lastCompletedRound…');
    final seasonResult = lastCompletedRound == 0
        ? null
        : switch (await resultsRepository.getSeasonResults(
            season: _seasonYear(races),
            lastCompletedRound: lastCompletedRound,
          )) {
            Left(value: final failure) => throw AiAssistantException(failure.message),
            Right(value: final value) => value,
          };

    final raceResults =
        seasonResult?.raceResults.where((result) => result.sessionType == 'race').toList() ??
        <RaceResult>[];
    final qualifyingResults = seasonResult?.qualifyingResults ?? <QualifyingResult>[];
    debugPrint(
      '[GroqAiAssistant] Got ${raceResults.length} race results, '
      '${qualifyingResults.length} qualifying results',
    );

    final buffer = StringBuffer()
      ..writeln('CURRENT F1 SEASON (${_seasonYear(races)})')
      ..writeln('Completed rounds: ${completedRaces.length} of ${races.length}')
      ..writeln();

    if (nextRace != null) {
      buffer
        ..writeln('NEXT RACE: ${nextRace.raceName} at ${nextRace.circuitName}')
        ..writeln('Race date: ${nextRace.raceDateTime.toUtc().toIso8601String()}')
        ..writeln();
    }

    buffer.writeln('DRIVER STANDINGS:');
    for (final driver in standings.driverStandings) {
      buffer.writeln(
        '${driver.position}. ${driver.givenName} ${driver.familyName} '
        '(${driver.driverCode ?? driver.driverId}, ${driver.constructorName}) '
        '${_number(driver.points)} points, ${driver.wins} wins',
      );
    }

    buffer
      ..writeln()
      ..writeln('CONSTRUCTOR STANDINGS:');
    for (final constructor in standings.constructorStandings) {
      buffer.writeln(
        '${constructor.position}. ${constructor.constructorName} '
        '${_number(constructor.points)} points, ${constructor.wins} wins',
      );
    }

    if (raceResults.isNotEmpty) {
      final resultsByRound = <int, List<RaceResult>>{};
      for (final result in raceResults) {
        (resultsByRound[result.round] ??= []).add(result);
      }
      final roundsAsc = resultsByRound.keys.toList()..sort();

      // Precomputed per-driver DNF/finish/pole counts, so the LLM never has to count itself.
      final finishCounts = <String, int>{};
      final dnfCounts = <String, int>{};
      for (final result in raceResults) {
        final target = _isDnf(result.status) ? dnfCounts : finishCounts;
        target[result.driverCode] = (target[result.driverCode] ?? 0) + 1;
      }
      final poleCounts = <String, int>{};
      final poleByRound = <int, String>{};
      for (final qualifying in qualifyingResults) {
        if (qualifying.position != 1) continue;
        poleCounts[qualifying.driverCode] = (poleCounts[qualifying.driverCode] ?? 0) + 1;
        poleByRound[qualifying.round] = qualifying.driverCode;
      }
      buffer
        ..writeln()
        ..writeln('SEASON RELIABILITY (finishes / DNFs) and POLES per driver:');
      for (final driver in standings.driverStandings) {
        final code = driver.driverCode ?? driver.driverId;
        buffer.writeln(
          '${driver.givenName} ${driver.familyName} ($code): '
          '${finishCounts[code] ?? 0} finishes, ${dnfCounts[code] ?? 0} DNFs, '
          '${poleCounts[code] ?? 0} poles',
        );
      }

      // Compact podium + pole + DNF line for every round, so any round is answerable.
      buffer
        ..writeln()
        ..writeln('ROUND-BY-ROUND RESULTS (pole, podium, DNFs):');
      for (final round in roundsAsc) {
        final roundResults = resultsByRound[round]!
          ..sort((a, b) => a.position.compareTo(b.position));
        final raceName = races
            .where((race) => race.round == round)
            .map((race) => race.raceName)
            .firstOrNull;
        final pole = poleByRound[round];
        final podium = roundResults
            .take(3)
            .map((result) => 'P${result.position} ${result.driverCode}')
            .join(', ');
        final dnfs = roundResults
            .where((result) => _isDnf(result.status))
            .map((result) => result.driverCode)
            .join(', ');
        buffer.writeln(
          'Round $round${raceName != null ? ' ($raceName)' : ''}: '
          '${pole != null ? 'Pole $pole, ' : ''}$podium'
          '${dnfs.isEmpty ? '' : ' | DNF: $dnfs'}',
        );
      }

      // Full top-10 detail for the last 3 rounds, for "what happened" style questions.
      final detailedRounds = roundsAsc.reversed.take(3).toList().reversed;
      for (final round in detailedRounds) {
        final roundResults = resultsByRound[round]!;
        buffer
          ..writeln()
          ..writeln('FULL RESULTS — Round $round:');
        for (final result in roundResults.take(10)) {
          buffer.writeln(
            'P${result.position} ${result.driverCode} (${result.constructorName}) '
            '${result.status}, ${_number(result.points)} points',
          );
        }
      }
    }

    debugPrint('[GroqAiAssistant] Answered from local data: $buffer');
    return buffer.toString();
  }

  bool _isDnf(String status) => !status.startsWith('Finished') && !status.startsWith('+');

  @override
  String? answerFromLocalData(String question) {
    // This is a synchronous method, but we need async data.
    // We'll return null here and handle local-first in streamAnswer instead.
    return null;
  }

  /// Tries to answer factual questions directly from cached data.
  /// Returns the answer string if handled locally, null if LLM is needed.
  Future<String?> tryAnswerLocally(String question) async {
    final lowerQuestion = question.toLowerCase();

    // Fetch fresh data for local queries
    final scheduleResult = await scheduleRepository.getSeasonSchedule();
    final standingsResult = await standingsRepository.getCurrentStandings();

    final schedule = switch (scheduleResult) {
      Left(value: final failure) => throw AiAssistantException(failure.message),
      Right(value: final value) => value,
    };
    final standings = switch (standingsResult) {
      Left(value: final failure) => throw AiAssistantException(failure.message),
      Right(value: final value) => value,
    };

    final now = DateTime.now();
    final races = schedule.races;
    final completedRaces = races.where((race) => race.statusAt(now) == RaceStatus.past).toList();
    final nextRace = races.where((race) => race.statusAt(now) != RaceStatus.past).firstOrNull;

    // Championship leader queries (single driver, not the whole table)
    if (_matchesAny(lowerQuestion, [
      'who is leading',
      'who leads',
      'who is first',
      'who is in first',
      'championship leader',
      'points leader',
    ])) {
      final leader = standings.driverStandings.firstOrNull;
      if (leader != null) {
        return '**${leader.givenName} ${leader.familyName}** '
            '(${leader.driverCode ?? leader.driverId}, ${leader.constructorName}) leads the '
            'championship with ${_number(leader.points)} points and ${leader.wins} wins.';
      }
    }

    // Driver standings queries (full table)
    if (_matchesAny(lowerQuestion, [
      'driver standing',
      'driver championship',
      'points table',
      'standings',
    ])) {
      final buffer = StringBuffer('**Driver Standings:**\n');
      for (final driver in standings.driverStandings.take(10)) {
        buffer.writeln(
          '${driver.position}. ${driver.givenName} ${driver.familyName} '
          '(${driver.driverCode ?? driver.driverId}, ${driver.constructorName}) — '
          '${_number(driver.points)} pts, ${driver.wins} wins',
        );
      }
      return buffer.toString();
    }

    // Constructor standings queries
    if (_matchesAny(lowerQuestion, [
      'constructor standing',
      'constructor championship',
      'team standing',
      'team championship',
      'which team',
    ])) {
      final buffer = StringBuffer('**Constructor Standings:**\n');
      for (final constructor in standings.constructorStandings) {
        buffer.writeln(
          '${constructor.position}. ${constructor.constructorName} — '
          '${_number(constructor.points)} pts, ${constructor.wins} wins',
        );
      }
      return buffer.toString();
    }

    // Next race queries
    if (_matchesAny(lowerQuestion, [
      'next race',
      'upcoming race',
      'when is the next',
      'next grand prix',
      'next gp',
    ])) {
      if (nextRace != null) {
        return '**Next Race:** ${nextRace.raceName} at ${nextRace.circuitName}\n'
            'Date: ${_formatDate(nextRace.raceDateTime)}';
      }
      return 'No upcoming races in the current season.';
    }

    // Season progress queries
    if (_matchesAny(lowerQuestion, [
      'how many races',
      'races completed',
      'season progress',
      'rounds done',
      'rounds left',
    ])) {
      final total = races.length;
      final done = completedRaces.length;
      return 'Season progress: **$done of $total rounds completed** (${total - done} remaining).';
    }

    // Specific driver queries — only single-driver asks, not comparisons or DNF-style questions
    // that need reasoning over multiple drivers (those fall through to the LLM).
    final isComparisonQuestion = _matchesAny(lowerQuestion, [
      'compare',
      'comparison',
      'more dnf',
      'most dnf',
      'who has more',
      'vs',
      ' or ',
    ]);
    if (!isComparisonQuestion) {
      for (final driver in standings.driverStandings) {
        final name = '${driver.givenName} ${driver.familyName}'.toLowerCase();
        final code = (driver.driverCode ?? driver.driverId).toLowerCase();
        if (_containsWord(lowerQuestion, name) || _containsWord(lowerQuestion, code)) {
          return '**${driver.givenName} ${driver.familyName}** (${driver.driverCode ?? driver.driverId})\n'
              'Team: ${driver.constructorName}\n'
              'Position: P${driver.position}\n'
              'Points: ${_number(driver.points)}\n'
              'Wins: ${driver.wins}';
        }
      }

      // Specific team queries
      for (final constructor in standings.constructorStandings) {
        final teamName = constructor.constructorName.toLowerCase();
        if (_containsWord(lowerQuestion, teamName)) {
          return '**${constructor.constructorName}**\n'
              'Position: P${constructor.position}\n'
              'Points: ${_number(constructor.points)}\n'
              'Wins: ${constructor.wins}';
        }
      }
    }

    // Last race winner
    if (_matchesAny(lowerQuestion, [
      'who won',
      'last race winner',
      'previous race winner',
      'last grand prix winner',
    ])) {
      if (completedRaces.isNotEmpty) {
        final lastRace = completedRaces.last;
        // We'd need to fetch the result for this specific round
        return 'The last completed race was **${lastRace.raceName}** (Round ${lastRace.round}). '
            'Ask me for the full results of that round!';
      }
      return 'No races have been completed yet this season.';
    }

    return null;
  }

  bool _matchesAny(String question, List<String> keywords) =>
      keywords.any((kw) => question.contains(kw));

  /// Whole-word/phrase match, so short codes like 'str' don't match inside
  /// unrelated words such as 'constructors'.
  bool _containsWord(String haystack, String needle) =>
      RegExp(r'\b' + RegExp.escape(needle) + r'\b').hasMatch(haystack);

  String _formatDate(DateTime date) {
    final local = date.toLocal();
    return '${local.day} ${_monthName(local.month)} ${local.year} at ${local.hour.toString().padLeft(2, '0')}:${local.minute.toString().padLeft(2, '0')}';
  }

  String _monthName(int month) => const [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ][month - 1];

  int _seasonYear(List<Race> races) =>
      races.isEmpty ? DateTime.now().year : races.first.raceDateTime.toLocal().year;

  String _number(double value) =>
      value == value.roundToDouble() ? value.toInt().toString() : value.toStringAsFixed(1);

  String _systemPrompt(String context) =>
      '''
You are Pitbox AI, a Formula 1 statistics assistant inside Pitbox Wall.
Answer only from the season data below. Be concise, specific, and helpful.
Never invent a result, position, driver statistic, date, or lap time.
If the data does not answer the question, say: "I don't have that data right now."
When comparing drivers or teams, use the numbers in the context and show the useful difference.
IMPORTANT: Do NOT use markdown tables, tables, or tabular formatting in your responses. Use plain text, bullet points, or short paragraphs instead. Tables do not render well in chat bubbles.

$context
''';
}
