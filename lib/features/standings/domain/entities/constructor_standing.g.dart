// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'constructor_standing.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ConstructorStanding _$ConstructorStandingFromJson(Map<String, dynamic> json) =>
    _ConstructorStanding(
      position: (json['position'] as num).toInt(),
      points: (json['points'] as num).toDouble(),
      wins: (json['wins'] as num).toInt(),
      constructorId: json['constructorId'] as String,
      constructorName: json['constructorName'] as String,
    );

Map<String, dynamic> _$ConstructorStandingToJson(
  _ConstructorStanding instance,
) => <String, dynamic>{
  'position': instance.position,
  'points': instance.points,
  'wins': instance.wins,
  'constructorId': instance.constructorId,
  'constructorName': instance.constructorName,
};
