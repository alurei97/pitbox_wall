import 'package:flutter/material.dart';

import '../../../schedule/domain/entities/race.dart';
import 'race_weekend_sessions.dart';

class UpcomingRaceCard extends StatelessWidget {
  const UpcomingRaceCard({required this.race, required this.now, super.key});

  final Race race;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const .fromLTRB(16, 50, 16, 0),
      child: Column(
        crossAxisAlignment: .start,
        spacing: 8,
        children: [
          const SizedBox(height: 4),
          Text(
            'Race starts in ${formatRaceCountdown(race.raceDateTime, now)}',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: .w600,
            ),
          ),

          Row(
            children: [
              Icon(Icons.timer_outlined, color: theme.colorScheme.primary),
              const SizedBox(width: 8),
              Text(
                'Weekend not started yet',
                style: theme.textTheme.titleMedium,
              ),
            ],
          ),

          Text(
            'This race weekend hasn\'t begun. Check back when the session schedule is live for timings and results.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: .6),
            ),
          ),
        ],
      ),
    );
  }
}
