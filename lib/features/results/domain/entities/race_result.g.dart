// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'race_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RaceResult _$RaceResultFromJson(Map<String, dynamic> json) => _RaceResult(
  sessionType: json['sessionType'] as String,
  round: (json['round'] as num).toInt(),
  driverId: json['driverId'] as String,
  driverCode: json['driverCode'] as String,
  driverNumber: json['driverNumber'] as String,
  givenName: json['givenName'] as String,
  familyName: json['familyName'] as String,
  nationality: json['nationality'] as String,
  constructorId: json['constructorId'] as String,
  constructorName: json['constructorName'] as String,
  position: (json['position'] as num).toInt(),
  grid: (json['grid'] as num).toInt(),
  points: (json['points'] as num).toDouble(),
  status: json['status'] as String,
);

Map<String, dynamic> _$RaceResultToJson(_RaceResult instance) =>
    <String, dynamic>{
      'sessionType': instance.sessionType,
      'round': instance.round,
      'driverId': instance.driverId,
      'driverCode': instance.driverCode,
      'driverNumber': instance.driverNumber,
      'givenName': instance.givenName,
      'familyName': instance.familyName,
      'nationality': instance.nationality,
      'constructorId': instance.constructorId,
      'constructorName': instance.constructorName,
      'position': instance.position,
      'grid': instance.grid,
      'points': instance.points,
      'status': instance.status,
    };
