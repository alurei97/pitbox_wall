// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_round_standing.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DriverRoundStanding _$DriverRoundStandingFromJson(Map<String, dynamic> json) =>
    _DriverRoundStanding(
      round: (json['round'] as num).toInt(),
      driverId: json['driverId'] as String,
      driverCode: json['driverCode'] as String,
      constructorId: json['constructorId'] as String,
      position: (json['position'] as num).toInt(),
      points: (json['points'] as num).toDouble(),
    );

Map<String, dynamic> _$DriverRoundStandingToJson(
  _DriverRoundStanding instance,
) => <String, dynamic>{
  'round': instance.round,
  'driverId': instance.driverId,
  'driverCode': instance.driverCode,
  'constructorId': instance.constructorId,
  'position': instance.position,
  'points': instance.points,
};
