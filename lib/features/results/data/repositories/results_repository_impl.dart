import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../core/db/app_database.dart';
import '../../../../core/error/either.dart';
import '../../../../core/error/failures.dart';
import '../../../../shared/models/cache_info.dart';
import '../../domain/entities/qualifying_result.dart';
import '../../domain/entities/race_result.dart';
import '../../domain/repositories/results_repository.dart';
import '../datasources/results_remote_data_source.dart';

class ResultsRepositoryImpl implements ResultsRepository {
  ResultsRepositoryImpl(this._remote, this._db);

  final ResultsRemoteDataSource _remote;
  final AppDatabase _db;

  @override
  Future<Either<Failure, ResultsResult>> getRoundResults({
    required int season,
    required int round,
    bool forceRefresh = false,
  }) async {
    final cacheKey = 'results_${season}_round_$round';
    if (!forceRefresh) {
      final cached = await _db.getFresh(cacheKey);
      if (cached != null) {
        try {
          return Right(_decodeRound(cached.jsonData, cached.fetchedAt));
        } catch (_) {}
      }
    }

    try {
      final race = await _remote.fetchRaceResults(season: season, round: round);
      final sprint = await _remote.fetchSprintResults(season: season, round: round);
      final qualifying = await _remote.fetchQualifyingResults(season: season, round: round);
      if (race.isEmpty && sprint.isEmpty && qualifying.isEmpty) {
        return const Left(ServerFailure('No results have been published yet.'));
      }
      final payload = jsonEncode({
        'raceResults': [...race, ...sprint].map((r) => r.toJson()).toList(growable: false),
        'qualifyingResults': qualifying.map((r) => r.toJson()).toList(growable: false),
      });
      await _db.upsert(cacheKey, payload, ttlSeconds: CacheTTL.forever);
      return Right(
        ResultsResult(
          raceResults: [...race, ...sprint],
          qualifyingResults: qualifying,
          cache: CacheInfo(
            fromCache: false,
            responseTimeMs: 0,
            fetchedAt: DateTime.now(),
            ttlSeconds: CacheTTL.forever,
          ),
        ),
      );
    } on DioException catch (e) {
      return Left(
        e.response?.statusCode == 429
            ? const RateLimitFailure('Rate limited by Jolpica (429).')
            : NetworkFailure(e.message ?? 'Network error while fetching results.'),
      );
    } catch (e) {
      return Left(UnknownFailure('Unexpected results error: $e'));
    }
  }

  ResultsResult _decodeRound(String raw, DateTime fetchedAt) {
    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    return ResultsResult(
      raceResults: (decoded['raceResults'] as List)
          .whereType<Map<String, dynamic>>()
          .map(RaceResult.fromJson)
          .toList(growable: false),
      qualifyingResults: (decoded['qualifyingResults'] as List)
          .whereType<Map<String, dynamic>>()
          .map(QualifyingResult.fromJson)
          .toList(growable: false),
      cache: CacheInfo(
        fromCache: true,
        responseTimeMs: 0,
        fetchedAt: fetchedAt,
        ttlSeconds: CacheTTL.forever,
      ),
    );
  }

  @override
  Future<Either<Failure, ResultsResult>> getSeasonResults({
    required int season,
    required int lastCompletedRound,
    bool forceRefresh = false,
  }) async {
    final raceResults = <RaceResult>[];
    final qualifyingResults = <QualifyingResult>[];
    var fetchedAnyRound = false;
    var usedCache = true;
    DateTime? oldestFetchedAt;
    int? ttlSeconds;

    for (var round = 1; round <= lastCompletedRound; round++) {
      final cacheKey = 'results_${season}_round_$round';
      final cached = !forceRefresh ? await _db.getFresh(cacheKey) : null;

      if (cached != null) {
        try {
          final decoded = jsonDecode(cached.jsonData) as Map<String, dynamic>;
          raceResults.addAll(
            (decoded['raceResults'] as List).whereType<Map<String, dynamic>>().map(
              RaceResult.fromJson,
            ),
          );
          qualifyingResults.addAll(
            (decoded['qualifyingResults'] as List).whereType<Map<String, dynamic>>().map(
              QualifyingResult.fromJson,
            ),
          );
          oldestFetchedAt = _oldest(oldestFetchedAt, cached.fetchedAt);
          ttlSeconds = cached.ttlSeconds;
          fetchedAnyRound = true;
          continue;
        } catch (_) {
          // Ignore invalid cache and refetch this round.
        }
      }

      try {
        final roundRaceResults = await _remote.fetchRaceResults(season: season, round: round);
        final roundSprintResults = await _remote.fetchSprintResults(
          season: season,
          round: round,
        );
        final roundQualifyingResults = await _remote.fetchQualifyingResults(
          season: season,
          round: round,
        );
        if (roundRaceResults.isEmpty) continue;

        final payload = jsonEncode({
          'raceResults': [
            ...roundRaceResults,
            ...roundSprintResults,
          ].map((result) => result.toJson()).toList(growable: false),
          'qualifyingResults': roundQualifyingResults
              .map((result) => result.toJson())
              .toList(growable: false),
        });
        await _db.upsert(cacheKey, payload, ttlSeconds: CacheTTL.forever);
        raceResults.addAll(roundRaceResults);
        raceResults.addAll(roundSprintResults);
        qualifyingResults.addAll(roundQualifyingResults);
        fetchedAnyRound = true;
        usedCache = false;
        oldestFetchedAt = _oldest(oldestFetchedAt, DateTime.now());
        ttlSeconds = CacheTTL.forever;
      } on DioException catch (e) {
        if (!fetchedAnyRound && e.response?.statusCode == 429) {
          return const Left(RateLimitFailure('Rate limited by Jolpica (429).'));
        }
        continue;
      } catch (_) {
        continue;
      }
    }

    if (!fetchedAnyRound || raceResults.isEmpty || oldestFetchedAt == null) {
      return const Left(ServerFailure('No race results returned by Jolpica.'));
    }

    return Right(
      ResultsResult(
        raceResults: List.unmodifiable(raceResults),
        qualifyingResults: List.unmodifiable(qualifyingResults),
        cache: CacheInfo(
          fromCache: usedCache,
          responseTimeMs: 0,
          fetchedAt: oldestFetchedAt,
          ttlSeconds: ttlSeconds,
        ),
      ),
    );
  }

  DateTime _oldest(DateTime? current, DateTime candidate) {
    if (current == null || candidate.isBefore(current)) return candidate;
    return current;
  }
}
