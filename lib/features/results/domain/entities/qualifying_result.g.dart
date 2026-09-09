// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qualifying_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QualifyingResult _$QualifyingResultFromJson(Map<String, dynamic> json) =>
    _QualifyingResult(
      sessionType: json['sessionType'] as String,
      round: (json['round'] as num).toInt(),
      driverId: json['driverId'] as String,
      driverCode: json['driverCode'] as String,
      givenName: json['givenName'] as String,
      familyName: json['familyName'] as String,
      constructorName: json['constructorName'] as String,
      position: (json['position'] as num).toInt(),
      q1: json['q1'] as String?,
      q2: json['q2'] as String?,
      q3: json['q3'] as String?,
    );

Map<String, dynamic> _$QualifyingResultToJson(_QualifyingResult instance) =>
    <String, dynamic>{
      'sessionType': instance.sessionType,
      'round': instance.round,
      'driverId': instance.driverId,
      'driverCode': instance.driverCode,
      'givenName': instance.givenName,
      'familyName': instance.familyName,
      'constructorName': instance.constructorName,
      'position': instance.position,
      'q1': instance.q1,
      'q2': instance.q2,
      'q3': instance.q3,
    };
