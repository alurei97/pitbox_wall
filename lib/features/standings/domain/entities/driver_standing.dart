import 'package:freezed_annotation/freezed_annotation.dart';

part 'driver_standing.freezed.dart';
part 'driver_standing.g.dart';

@freezed
abstract class DriverStanding with _$DriverStanding {
  const factory DriverStanding({
    required int position,
    required double points,
    required int wins,
    required String driverId,
    String? driverCode,
    required String driverNumber,
    required String givenName,
    required String familyName,
    required String constructorId,
    required String constructorName,
  }) = _DriverStanding;

  factory DriverStanding.fromJson(Map<String, dynamic> json) => _$DriverStandingFromJson(json);
}
