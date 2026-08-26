// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_standing.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DriverStanding _$DriverStandingFromJson(Map<String, dynamic> json) =>
    _DriverStanding(
      position: (json['position'] as num).toInt(),
      points: (json['points'] as num).toDouble(),
      wins: (json['wins'] as num).toInt(),
      driverId: json['driverId'] as String,
      driverCode: json['driverCode'] as String?,
      driverNumber: json['driverNumber'] as String,
      givenName: json['givenName'] as String,
      familyName: json['familyName'] as String,
      constructorId: json['constructorId'] as String,
      constructorName: json['constructorName'] as String,
    );

Map<String, dynamic> _$DriverStandingToJson(_DriverStanding instance) =>
    <String, dynamic>{
      'position': instance.position,
      'points': instance.points,
      'wins': instance.wins,
      'driverId': instance.driverId,
      'driverCode': instance.driverCode,
      'driverNumber': instance.driverNumber,
      'givenName': instance.givenName,
      'familyName': instance.familyName,
      'constructorId': instance.constructorId,
      'constructorName': instance.constructorName,
    };
