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
      position: (json['position'] as num).toInt(),
    );

Map<String, dynamic> _$QualifyingResultToJson(_QualifyingResult instance) =>
    <String, dynamic>{
      'sessionType': instance.sessionType,
      'round': instance.round,
      'driverId': instance.driverId,
      'driverCode': instance.driverCode,
      'givenName': instance.givenName,
      'familyName': instance.familyName,
      'position': instance.position,
    };
