import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/either.dart';
import '../../domain/repositories/schedule_repository.dart';
import 'schedule_state.dart';

class ScheduleCubit extends Cubit<ScheduleState> {
  ScheduleCubit(this._repository) : super(const ScheduleState.initial());

  final ScheduleRepository _repository;

  Future<void> load({bool forceRefresh = false}) async {
    emit(const ScheduleState.loading());

    final result = await _repository.getSeasonSchedule(forceRefresh: forceRefresh);

    switch (result) {
      case Left(value: final failure):
        emit(ScheduleState.error(message: failure.message));
      case Right(value: final races):
        emit(ScheduleState.loaded(races: races, fromCache: !forceRefresh));
    }
  }
}
