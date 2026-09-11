import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../results/domain/entities/race_result.dart';
import '../../../standings/domain/entities/driver_standing.dart';

part 'driver_state.freezed.dart';

class DriverData {
  const DriverData({
    required this.driver,
    required this.raceResults,
    required this.poles,
  });

  final DriverStanding driver;
  final List<RaceResult> raceResults;
  final int poles;
}

@freezed
abstract class DriverState with _$DriverState {
  const factory DriverState.initial() = _Initial;
  const factory DriverState.loading() = _Loading;
  const factory DriverState.loaded({required DriverData data}) = _Loaded;
  const factory DriverState.error({required String message}) = _Error;
}
