// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'race.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Race _$RaceFromJson(Map<String, dynamic> json) => _Race(
  round: (json['round'] as num).toInt(),
  raceName: json['raceName'] as String,
  circuitName: json['circuitName'] as String,
  country: json['country'] as String,
  fp1DateTime: DateTime.parse(json['fp1DateTime'] as String),
  fp2DateTime: json['fp2DateTime'] == null
      ? null
      : DateTime.parse(json['fp2DateTime'] as String),
  sprintDateTime: json['sprintDateTime'] == null
      ? null
      : DateTime.parse(json['sprintDateTime'] as String),
  fp3DateTime: json['fp3DateTime'] == null
      ? null
      : DateTime.parse(json['fp3DateTime'] as String),
  sprintQualifyingDateTime: json['sprintQualifyingDateTime'] == null
      ? null
      : DateTime.parse(json['sprintQualifyingDateTime'] as String),
  qualifyingDateTime: DateTime.parse(json['qualifyingDateTime'] as String),
  raceDateTime: DateTime.parse(json['raceDateTime'] as String),
);

Map<String, dynamic> _$RaceToJson(_Race instance) => <String, dynamic>{
  'round': instance.round,
  'raceName': instance.raceName,
  'circuitName': instance.circuitName,
  'country': instance.country,
  'fp1DateTime': instance.fp1DateTime.toIso8601String(),
  'fp2DateTime': instance.fp2DateTime?.toIso8601String(),
  'sprintDateTime': instance.sprintDateTime?.toIso8601String(),
  'fp3DateTime': instance.fp3DateTime?.toIso8601String(),
  'sprintQualifyingDateTime': instance.sprintQualifyingDateTime
      ?.toIso8601String(),
  'qualifyingDateTime': instance.qualifyingDateTime.toIso8601String(),
  'raceDateTime': instance.raceDateTime.toIso8601String(),
};
