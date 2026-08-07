import 'package:flutter/material.dart';

import '../../../schedule/presentation/widgets/race_status.dart' show ListChip, StatusChip;

/// Shows [ListChip.raceWeek] during race week, or [ListChip.next] otherwise.
class RaceWeekBadge extends StatelessWidget {
  const RaceWeekBadge({required this.raceDate, super.key});

  final DateTime raceDate;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final raceLocal = raceDate.toLocal();

    // Find the Monday of the week the race falls in.
    final monday = DateTime(
      raceLocal.year,
      raceLocal.month,
      raceLocal.day,
    ).subtract(Duration(days: raceLocal.weekday - 1));

    final isRaceWeek = !now.isBefore(monday);
    final chip = isRaceWeek ? ListChip.raceWeek : ListChip.next;

    return StatusChip(chip: chip);
  }
}
