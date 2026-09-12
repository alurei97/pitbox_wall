import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/either.dart';
import '../../../../shared/models/cache_info.dart';
import '../../../results/domain/entities/race_result.dart';
import '../../../results/domain/repositories/results_repository.dart';
import '../../../schedule/domain/entities/race.dart';
import '../../../schedule/domain/repositories/schedule_repository.dart';
import '../../../standings/domain/entities/constructor_standing.dart';
import '../../../standings/domain/entities/driver_standing.dart';
import '../../../standings/domain/repositories/standings_repository.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
    this._scheduleRepository,
    this._standingsRepository,
    this._resultsRepository,
  ) : super(const HomeState.initial());

  final ScheduleRepository _scheduleRepository;
  final StandingsRepository _standingsRepository;
  final ResultsRepository _resultsRepository;

  Future<void> load({bool forceRefresh = false}) async {
    emit(const HomeState.loading());

    final sw = Stopwatch()..start();
    final result = await _scheduleRepository.getSeasonSchedule(forceRefresh: forceRefresh);
    sw.stop();

    switch (result) {
      case Left(value: final failure):
        emit(HomeState.error(message: failure.message));

      case Right(value: final scheduleResult):
        final now = DateTime.now();
        final races = scheduleResult.races;
        final nextRace = _findNextRace(races, now);
        final sessions = _buildSessions(nextRace, now);

        // Fetch standings non-blocking — top 5 drivers for home preview.
        final standingsResult = await _standingsRepository.getCurrentStandings();
        final topDrivers = switch (standingsResult) {
          Right(value: final sr) => sr.driverStandings.take(5).toList(growable: false),
          _ => <DriverStanding>[],
        };
        final topConstructors = switch (standingsResult) {
          Right(value: final sr) => sr.constructorStandings.take(5).toList(growable: false),
          _ => <ConstructorStanding>[],
        };
        final standingsCache = switch (standingsResult) {
          Right(value: final sr) => sr.cache,
          _ => null,
        };

        // Fetch the last completed race's podium (non-blocking preview).
        final lastRace = _findLastCompletedRace(races, now);
        final podium = await _fetchPodium(lastRace);

        final old = scheduleResult.cache;
        emit(
          HomeState.loaded(
            data: HomeData(
              nextRace: nextRace,
              sessions: sessions,
              totalRounds: races.length,
              completedRounds: races.where((r) => r.statusAt(now) == RaceStatus.past).length,
              cache: CacheInfo(
                fromCache: old.fromCache,
                responseTimeMs: sw.elapsedMilliseconds,
                fetchedAt: old.fetchedAt,
                ttlSeconds: old.ttlSeconds,
              ),
              topDrivers: topDrivers,
              topConstructors: topConstructors,
              standingsCache: standingsCache,
              lastRace: lastRace,
              podium: podium,
            ),
          ),
        );
    }
  }

  /// Returns the most recent race that has already finished, or null if the
  /// season hasn't produced any results yet.
  Race? _findLastCompletedRace(List<Race> races, DateTime now) {
    for (var i = races.length - 1; i >= 0; i--) {
      if (races[i].statusAt(now) == RaceStatus.past) return races[i];
    }
    return null;
  }

  /// Fetches the top 3 finishers of [race] (main race only, not sprint).
  Future<List<RaceResult>> _fetchPodium(Race? race) async {
    if (race == null) return const [];

    final result = await _resultsRepository.getRoundResults(
      season: race.raceDateTime.toLocal().year,
      round: race.round,
    );

    return switch (result) {
      Right(value: final rr) => _topThree(rr.raceResults),
      _ => const [],
    };
  }

  /// Sorts race results by finishing position and keeps the top 3.
  List<RaceResult> _topThree(List<RaceResult> results) {
    final raceResults = results.where((r) => r.sessionType == 'race').toList(growable: false)
      ..sort((a, b) => a.position.compareTo(b.position));
    return raceResults.take(3).toList(growable: false);
  }

  /// Returns the first race that isn't finished yet, or the most recent past
  /// race if the entire season is over.
  Race? _findNextRace(List<Race> races, DateTime now) {
    for (final race in races) {
      if (race.statusAt(now) != RaceStatus.past) return race;
    }
    return races.isNotEmpty ? races.last : null;
  }

  /// Builds a chronological list of sessions for a given race.
  List<SessionEntry> _buildSessions(Race? race, DateTime now) {
    if (race == null) return const [];

    final entries = <SessionEntry>[
      SessionEntry('Free Practice 1', race.fp1DateTime),
      if (race.fp2DateTime != null) SessionEntry('Free Practice 2', race.fp2DateTime!),
      if (race.sprintQualifyingDateTime != null)
        SessionEntry('Sprint Qualifying', race.sprintQualifyingDateTime!),
      if (race.sprintDateTime != null) SessionEntry('Sprint', race.sprintDateTime!),
      if (race.fp3DateTime != null) SessionEntry('Free Practice 3', race.fp3DateTime!),
      SessionEntry('Qualifying', race.qualifyingDateTime),
      SessionEntry('Race', race.raceDateTime),
    ]..sort((a, b) => a.dateTime.compareTo(b.dateTime));

    return entries;
  }
}
