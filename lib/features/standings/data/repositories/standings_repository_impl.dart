import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../core/db/app_database.dart';
import '../../../../core/error/either.dart';
import '../../../../core/error/failures.dart';
import '../../../../shared/models/cache_info.dart';
import '../../domain/entities/constructor_standing.dart';
import '../../domain/entities/driver_round_standing.dart';
import '../../domain/entities/driver_standing.dart';
import '../../domain/repositories/standings_repository.dart';
import '../datasources/standings_remote_data_source.dart';

class StandingsRepositoryImpl implements StandingsRepository {
  StandingsRepositoryImpl(this._remote, this._db);

  static const _cacheKey = 'standings_current_season';

  final StandingsRemoteDataSource _remote;
  final AppDatabase _db;

  @override
  Future<Either<Failure, StandingsResult>> getCurrentStandings({bool forceRefresh = false}) async {
    if (!forceRefresh) {
      final fresh = await _db.getFresh(_cacheKey);
      if (fresh != null) {
        try {
          return Right(
            StandingsResult(
              driverStandings: _decodeDriverStandings(fresh.jsonData),
              constructorStandings: _decodeConstructorStandings(fresh.jsonData),
              cache: CacheInfo(
                fromCache: true,
                responseTimeMs: 0,
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
      final drivers = await _remote.fetchCurrentDriverStandings();
      final constructors = await _remote.fetchCurrentConstructorStandings();

      if (drivers.isEmpty && constructors.isEmpty) {
        return _staleOrFailure(const ServerFailure('No standings returned by Jolpica.'));
      }

      final payload = jsonEncode({
        'drivers': drivers.map((d) => d.toJson()).toList(growable: false),
        'constructors': constructors.map((c) => c.toJson()).toList(growable: false),
      });

      await _db.upsert(_cacheKey, payload, ttlSeconds: CacheTTL.hour);

      final now = DateTime.now();
      return Right(
        StandingsResult(
          driverStandings: drivers,
          constructorStandings: constructors,
          cache: CacheInfo(
            fromCache: false,
            responseTimeMs: 0,
            fetchedAt: now,
            ttlSeconds: CacheTTL.hour,
          ),
        ),
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 429) {
        return _staleOrFailure(const RateLimitFailure('Rate limited by Jolpica (429).'));
      }
      return _staleOrFailure(
        NetworkFailure(e.message ?? 'Network error while fetching standings.'),
      );
    } catch (e) {
      return _staleOrFailure(UnknownFailure('Unexpected standings error: $e'));
    }
  }

  @override
  Future<Either<Failure, List<DriverRoundStanding>>> getDriverStandingsAtRound({
    required int season,
    required int round,
    bool forceRefresh = false,
  }) async {
    final cacheKey = 'standings_${season}_round_$round';

    if (!forceRefresh) {
      final fresh = await _db.getFresh(cacheKey);
      if (fresh != null) {
        try {
          return Right(_decodeRoundStandings(fresh.jsonData));
        } catch (_) {
          // Ignore bad cache and refetch.
        }
      }
    }

    try {
      final standings = await _remote.fetchDriverStandingsAtRound(
        season: season,
        round: round,
      );
      if (standings.isEmpty) {
        return _staleRoundOrFailure(
          cacheKey,
          const ServerFailure('No historical standings returned.'),
        );
      }

      await _db.upsert(
        cacheKey,
        jsonEncode(standings.map((standing) => standing.toJson()).toList(growable: false)),
        ttlSeconds: CacheTTL.forever,
      );
      return Right(standings);
    } on DioException catch (e) {
      if (e.response?.statusCode == 429) {
        return _staleRoundOrFailure(
          cacheKey,
          const RateLimitFailure('Rate limited by Jolpica (429).'),
        );
      }
      return _staleRoundOrFailure(
        cacheKey,
        NetworkFailure(e.message ?? 'Network error while fetching historical standings.'),
      );
    } catch (e) {
      return _staleRoundOrFailure(
        cacheKey,
        UnknownFailure('Unexpected historical standings error: $e'),
      );
    }
  }

  Future<Either<Failure, List<DriverRoundStanding>>> _staleRoundOrFailure(
    String cacheKey,
    Failure failure,
  ) async {
    final stale = await (_db.select(
      _db.cacheEntries,
    )..where((t) => t.key.equals(cacheKey))).getSingleOrNull();

    if (stale != null) {
      try {
        return Right(_decodeRoundStandings(stale.jsonData));
      } catch (_) {
        return const Left(CacheFailure('Cached historical standings are invalid.'));
      }
    }

    return Left(failure);
  }

  Future<Either<Failure, StandingsResult>> _staleOrFailure(Failure failure) async {
    final stale = await (_db.select(
      _db.cacheEntries,
    )..where((t) => t.key.equals(_cacheKey))).getSingleOrNull();

    if (stale != null) {
      try {
        return Right(
          StandingsResult(
            driverStandings: _decodeDriverStandings(stale.jsonData),
            constructorStandings: _decodeConstructorStandings(stale.jsonData),
            cache: CacheInfo(
              fromCache: true,
              responseTimeMs: 0,
              fetchedAt: stale.fetchedAt,
              ttlSeconds: stale.ttlSeconds,
            ),
          ),
        );
      } catch (_) {
        return const Left(CacheFailure('Cached standings are invalid.'));
      }
    }

    return Left(failure);
  }

  List<DriverStanding> _decodeDriverStandings(String rawJson) {
    final decoded = jsonDecode(rawJson);
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('Expected standings map payload.');
    }

    final driversRaw = decoded['drivers'];
    if (driversRaw is! List) {
      throw const FormatException('Expected drivers list in standings payload.');
    }

    return driversRaw
        .whereType<Map<String, dynamic>>()
        .map(DriverStanding.fromJson)
        .toList(growable: false);
  }

  List<ConstructorStanding> _decodeConstructorStandings(String rawJson) {
    final decoded = jsonDecode(rawJson);
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('Expected standings map payload.');
    }

    final constructorsRaw = decoded['constructors'];
    if (constructorsRaw is! List) {
      throw const FormatException('Expected constructors list in standings payload.');
    }

    return constructorsRaw
        .whereType<Map<String, dynamic>>()
        .map(ConstructorStanding.fromJson)
        .toList(growable: false);
  }

  List<DriverRoundStanding> _decodeRoundStandings(String rawJson) {
    final decoded = jsonDecode(rawJson);
    if (decoded is! List) {
      throw const FormatException('Expected historical standings list.');
    }

    return decoded
        .whereType<Map<String, dynamic>>()
        .map(DriverRoundStanding.fromJson)
        .toList(growable: false);
  }
}
