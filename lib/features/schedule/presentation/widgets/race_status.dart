import '../../domain/entities/race.dart';

// ---------------------------------------------------------------------------
// Status chips
// ---------------------------------------------------------------------------

/// Which badge (if any) a race card shows, relative to "now".
enum ListChip {
  done,
  next('Next', 'E5484D');

  const ListChip([this.label, this.hexColor]);

  /// Null for [done] — we show a 🏁 instead of a text chip.
  final String? label;
  final String? hexColor;
}

/// Computes the badge for each race (keyed by round).
///
/// - Every finished race → [done].
/// - The single next race (first one not finished) → [next].
/// - All later races → `null` (obviously upcoming, no chip).
Map<int, ListChip?> chipsFor(List<Race> races, DateTime now) {
  final map = <int, ListChip?>{};
  var nextShown = false;

  for (final race in races) {
    if (race.statusAt(now) == RaceStatus.past) {
      map[race.round] = ListChip.done;
    } else if (!nextShown) {
      map[race.round] = ListChip.next;
      nextShown = true;
    } else {
      map[race.round] = null;
    }
  }
  return map;
}
