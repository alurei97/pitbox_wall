import '../../../../core/error/either.dart';
import '../../../../core/error/failures.dart';
import '../entities/race.dart';

abstract class ScheduleRepository {
  Future<Either<Failure, List<Race>>> getSeasonSchedule({bool forceRefresh = false});
}
