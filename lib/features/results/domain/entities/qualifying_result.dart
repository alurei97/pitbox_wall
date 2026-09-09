import 'package:freezed_annotation/freezed_annotation.dart';

part 'qualifying_result.freezed.dart';
part 'qualifying_result.g.dart';

@freezed
abstract class QualifyingResult with _$QualifyingResult {
  const factory QualifyingResult({
    required String sessionType,
    required int round,
    required String driverId,
    required String driverCode,
    required String givenName,
    required String familyName,
    required String constructorName,
    required int position,
    String? q1,
    String? q2,
    String? q3,
  }) = _QualifyingResult;

  factory QualifyingResult.fromJson(Map<String, dynamic> json) => _$QualifyingResultFromJson(json);
}
