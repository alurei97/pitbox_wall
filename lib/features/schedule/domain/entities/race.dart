import 'package:freezed_annotation/freezed_annotation.dart';

part 'race.freezed.dart';
part 'race.g.dart';

@freezed
abstract class Race with _$Race {
  const factory Race({
    required int round,
    required String raceName,
    required String circuitName,
    required String country,
    required DateTime fp1DateTime,
    DateTime? fp2DateTime,
    DateTime? sprintDateTime,
    DateTime? fp3DateTime,
    DateTime? sprintQualifyingDateTime,
    required DateTime qualifyingDateTime,
    required DateTime raceDateTime,
  }) = _Race;

  factory Race.fromJson(Map<String, dynamic> json) => _$RaceFromJson(json);
}
