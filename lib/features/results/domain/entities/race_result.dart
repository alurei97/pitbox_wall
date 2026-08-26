import 'package:freezed_annotation/freezed_annotation.dart';

part 'race_result.freezed.dart';
part 'race_result.g.dart';

@freezed
abstract class RaceResult with _$RaceResult {
  const factory RaceResult({
    required String sessionType,
    required int round,
    required String driverId,
    required String driverCode,
    required String driverNumber,
    required String givenName,
    required String familyName,
    required String nationality,
    required String constructorId,
    required String constructorName,
    required int position,
    required int grid,
    required double points,
    required String status,
  }) = _RaceResult;

  factory RaceResult.fromJson(Map<String, dynamic> json) => _$RaceResultFromJson(json);
}
