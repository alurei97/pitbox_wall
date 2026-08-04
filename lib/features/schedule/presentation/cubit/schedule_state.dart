import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/race.dart';

part 'schedule_state.freezed.dart';

@freezed
abstract class ScheduleState with _$ScheduleState {
  const factory ScheduleState.initial() = _Initial;
  const factory ScheduleState.loading() = _Loading;
  const factory ScheduleState.loaded({required List<Race> races, required bool fromCache}) =
      _Loaded;
  const factory ScheduleState.error({required String message}) = _Error;
}
