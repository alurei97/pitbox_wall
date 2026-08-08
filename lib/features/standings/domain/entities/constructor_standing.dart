import 'package:freezed_annotation/freezed_annotation.dart';

part 'constructor_standing.freezed.dart';
part 'constructor_standing.g.dart';

@freezed
abstract class ConstructorStanding with _$ConstructorStanding {
  const factory ConstructorStanding({
    required int position,
    required double points,
    required int wins,
    required String constructorId,
    required String constructorName,
  }) = _ConstructorStanding;

  factory ConstructorStanding.fromJson(Map<String, dynamic> json) =>
      _$ConstructorStandingFromJson(json);
}
