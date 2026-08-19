import '../../../../core/error/either.dart';
import '../../../../core/error/failures.dart';
import '../../../../shared/models/cache_info.dart';
import '../entities/constructor_standing.dart';
import '../entities/driver_round_standing.dart';
import '../entities/driver_standing.dart';

class StandingsResult {
  const StandingsResult({
    required this.driverStandings,
    required this.constructorStandings,
    required this.cache,
  });

  final List<DriverStanding> driverStandings;
  final List<ConstructorStanding> constructorStandings;
  final CacheInfo cache;
}

abstract class StandingsRepository {
  Future<Either<Failure, StandingsResult>> getCurrentStandings({bool forceRefresh = false});

  Future<Either<Failure, List<DriverRoundStanding>>> getDriverStandingsAtRound({
    required int season,
    required int round,
    bool forceRefresh = false,
  });
}
