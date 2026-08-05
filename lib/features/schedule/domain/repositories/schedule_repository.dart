import '../../../../core/error/either.dart';
import '../../../../core/error/failures.dart';
import '../../../../shared/models/cache_info.dart';
import '../entities/race.dart';

/// Result of a schedule fetch, pairing the data with cache metadata.
class ScheduleResult {
  const ScheduleResult({
    required this.races,
    required this.cache,
  });

  final List<Race> races;
  final CacheInfo cache;
}

abstract class ScheduleRepository {
  Future<Either<Failure, ScheduleResult>> getSeasonSchedule({bool forceRefresh = false});
}
