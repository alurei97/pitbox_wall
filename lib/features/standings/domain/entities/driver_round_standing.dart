import 'package:freezed_annotation/freezed_annotation.dart';

part 'driver_round_standing.freezed.dart';
part 'driver_round_standing.g.dart';

@freezed
abstract class DriverRoundStanding with _$DriverRoundStanding {
  const factory DriverRoundStanding({
    required int round,
    required String driverId,
    required String driverCode,
    required String constructorId,
    required int position,
    required double points,
  }) = _DriverRoundStanding;

  factory DriverRoundStanding.fromJson(Map<String, dynamic> json) =>
      _$DriverRoundStandingFromJson(json);
}
