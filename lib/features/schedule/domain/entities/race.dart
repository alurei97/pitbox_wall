import 'package:freezed_annotation/freezed_annotation.dart';

part 'race.freezed.dart';
part 'race.g.dart';

/// Where a race sits relative to "now".
enum RaceStatus {
  /// The race weekend has already finished.
  past('Done', '2FA45C'),

  /// The race weekend is currently happening
  /// (from FP1 through the end of race day).
  currentWeek('Next', 'E5484D'),

  /// The race weekend hasn't started yet.
  future('Upcoming', '9AA0A6');

  const RaceStatus(this.label, this.hexColor);

  final String label;

  /// A compact hex color (no `#`) used for the status chip.
  final String hexColor;
}

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

/// Classifies a [Race] as [RaceStatus.past], [RaceStatus.currentWeek]
/// or [RaceStatus.future] relative to [now].
extension RaceStatusX on Race {
  RaceStatus statusAt(DateTime now) {
    if (now.isAfter(raceDateTime)) return RaceStatus.past;
    if (now.isBefore(fp1DateTime)) return RaceStatus.future;
    return RaceStatus.currentWeek;
  }
}
