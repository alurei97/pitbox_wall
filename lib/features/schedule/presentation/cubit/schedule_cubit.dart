import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/either.dart';
import '../../../../shared/models/cache_info.dart';
import '../../domain/repositories/schedule_repository.dart';
import 'schedule_state.dart';

class ScheduleCubit extends Cubit<ScheduleState> {
  ScheduleCubit(this._repository) : super(const ScheduleState.initial());

  final ScheduleRepository _repository;

  Future<void> load({bool forceRefresh = false}) async {
    emit(const ScheduleState.loading());

    final sw = Stopwatch()..start();
    final result = await _repository.getSeasonSchedule(forceRefresh: forceRefresh);
    sw.stop();

    switch (result) {
      case Left(value: final failure):
        emit(ScheduleState.error(message: failure.message));
      case Right(value: final scheduleResult):
        // Override responseTimeMs with the actual wall-clock time.
        final old = scheduleResult.cache;
        emit(
          ScheduleState.loaded(
            races: scheduleResult.races,
            cache: CacheInfo(
              fromCache: old.fromCache,
              responseTimeMs: sw.elapsedMilliseconds,
              fetchedAt: old.fetchedAt,
              ttlSeconds: old.ttlSeconds,
            ),
          ),
        );
    }
  }
}
