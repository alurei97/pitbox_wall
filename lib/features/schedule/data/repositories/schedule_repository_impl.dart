import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../core/db/app_database.dart';
import '../../../../core/error/either.dart';
import '../../../../core/error/failures.dart';
import '../../../../shared/models/cache_info.dart';
import '../../domain/entities/race.dart';
import '../../domain/repositories/schedule_repository.dart';
import '../datasources/schedule_remote_data_source.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  ScheduleRepositoryImpl({
    required this._remote,
    required this._db,
  });

  static const _cacheKey = 'schedule_current_season';

  final ScheduleRemoteDataSource _remote;
  final AppDatabase _db;

  @override
  Future<Either<Failure, ScheduleResult>> getSeasonSchedule({bool forceRefresh = false}) async {
    if (!forceRefresh) {
      final fresh = await _db.getFresh(_cacheKey);
      if (fresh != null) {
        try {
          final races = _decodeRaces(fresh.jsonData);
          return Right(
            ScheduleResult(
              races: races,
              cache: CacheInfo(
                fromCache: true,
                responseTimeMs: 0, // cache read is sub-ms; caller overrides with Stopwatch
                fetchedAt: fresh.fetchedAt,
                ttlSeconds: fresh.ttlSeconds,
              ),
            ),
          );
        } catch (_) {
          // Ignore bad cache and refetch.
        }
      }
    }

    try {
      final remoteRaces = await _remote.fetchCurrentSeasonRaces();
      if (remoteRaces.isEmpty) {
        return await _staleOrFailure(const ServerFailure('No races returned by Jolpica.'));
      }

      final now = DateTime.now();
      await _db.upsert(
        _cacheKey,
        jsonEncode(remoteRaces.map((r) => r.toJson()).toList(growable: false)),
        ttlSeconds: CacheTTL.day,
      );
      return Right(
        ScheduleResult(
          races: remoteRaces,
          cache: CacheInfo(
            fromCache: false,
            responseTimeMs: 0, // caller overrides with Stopwatch
            fetchedAt: now,
            ttlSeconds: CacheTTL.day,
          ),
        ),
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 429) {
        return _staleOrFailure(const RateLimitFailure('Rate limited by Jolpica (429).'));
      }
      return _staleOrFailure(NetworkFailure(e.message ?? 'Network error while fetching schedule.'));
    } catch (e) {
      return _staleOrFailure(UnknownFailure('Unexpected schedule error: $e'));
    }
  }

  Future<Either<Failure, ScheduleResult>> _staleOrFailure(Failure failure) async {
    final stale = await (_db.select(
      _db.cacheEntries,
    )..where((t) => t.key.equals(_cacheKey))).getSingleOrNull();

    if (stale != null) {
      try {
        final races = _decodeRaces(stale.jsonData);
        return Right(
          ScheduleResult(
            races: races,
            cache: CacheInfo(
              fromCache: true,
              responseTimeMs: 0,
              fetchedAt: stale.fetchedAt,
              ttlSeconds: stale.ttlSeconds,
            ),
          ),
        );
      } catch (_) {
        return const Left(CacheFailure('Cached schedule is invalid.'));
      }
    }

    return Left(failure);
  }

  List<Race> _decodeRaces(String rawJson) {
    final decoded = jsonDecode(rawJson);
    if (decoded is! List) {
      throw const FormatException('Expected list of races.');
    }

    return decoded.whereType<Map<String, dynamic>>().map(Race.fromJson).toList(growable: false);
  }
}
