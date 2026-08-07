import 'package:flutter/material.dart';

import '../../domain/entities/race.dart';

// ---------------------------------------------------------------------------
// Status chips
// ---------------------------------------------------------------------------

/// Which badge (if any) a race card shows, relative to "now".
enum ListChip {
  done('', ''),
  next('Next', 'E8002D'),
  raceWeek("IT'S WACE REEK", 'FFFFFF');

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

// ---------------------------------------------------------------------------
// Status chip widget
// ---------------------------------------------------------------------------

/// Small rounded status badge driven by [ListChip].
class StatusChip extends StatelessWidget {
  const StatusChip({required this.chip, super.key});

  final ListChip chip;

  @override
  Widget build(BuildContext context) {
    if (chip == ListChip.done) {
      return const Text('🏁', style: TextStyle(fontSize: 14));
    }

    final color = Color(int.parse('FF${chip.hexColor}', radix: 16));
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        chip.label!,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}
