import '../../../../core/error/either.dart';
import '../../../../core/error/failures.dart';
import '../../../../shared/models/cache_info.dart';
import '../entities/qualifying_result.dart';
import '../entities/race_result.dart';

class ResultsResult {
  const ResultsResult({
    required this.raceResults,
    required this.qualifyingResults,
    required this.cache,
  });

  final List<RaceResult> raceResults;
  final List<QualifyingResult> qualifyingResults;
  final CacheInfo cache;
}

abstract class ResultsRepository {
  Future<Either<Failure, ResultsResult>> getRoundResults({
    required int season,
    required int round,
    bool forceRefresh = false,
  });

  Future<Either<Failure, ResultsResult>> getSeasonResults({
    required int season,
    required int lastCompletedRound,
    bool forceRefresh = false,
  });
}
