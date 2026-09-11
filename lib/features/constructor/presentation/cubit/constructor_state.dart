import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../results/domain/entities/race_result.dart';
import '../../../standings/domain/entities/constructor_standing.dart';
import '../../../standings/domain/entities/driver_standing.dart';

part 'constructor_state.freezed.dart';

class ConstructorData {
  const ConstructorData({
    required this.constructor,
    required this.drivers,
    required this.results,
  });

  final ConstructorStanding constructor;
  final List<DriverStanding> drivers;
  final List<RaceResult> results;
}

@freezed
abstract class ConstructorState with _$ConstructorState {
  const factory ConstructorState.initial() = _Initial;
  const factory ConstructorState.loading() = _Loading;
  const factory ConstructorState.loaded({required ConstructorData data}) = _Loaded;
  const factory ConstructorState.error({required String message}) = _Error;
}
