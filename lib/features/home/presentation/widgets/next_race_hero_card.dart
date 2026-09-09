import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../schedule/domain/entities/race.dart';
import '../cubit/home_state.dart';
import '../../../../shared/utils/date_time_format.dart';

/// Hero card for the next race, shown on the home screen.
/// Shows a live countdown to the next session.
/// Tappable — navigates to the race weekend page.
class NextRaceHeroCard extends StatelessWidget {
  const NextRaceHeroCard({required this.race, required this.sessions, super.key});

  final Race race;
  final List<SessionEntry> sessions;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final now = DateTime.now();

    // Find next upcoming session
    final upcoming = sessions.where((s) => s.dateTime.isAfter(now)).toList();
    upcoming.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    final next = upcoming.isEmpty ? null : upcoming.first;

    final countdown = next != null ? _countdown(next.dateTime, now) : '—';

    final raceDate = race.raceDateTime.toLocal();
    final raceLabel = formatRaceDateTime(raceDate);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => context.push('/race/${race.round}', extra: race),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: theme.colorScheme.outline),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 14),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              if (next != null)
                Text(
                  '${next.name} starts in',
                  style: theme.textTheme.titleLarge,
                ),

              Text(
                countdown,
                style: theme.textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ),

              const SizedBox(height: 8),
              Text(
                '🏁 Race: $raceLabel',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Human-readable countdown from [now] until [target].
String _countdown(DateTime target, DateTime now) {
  final diff = target.difference(now);
  if (diff.isNegative) return 'started';
  final days = diff.inDays;
  final hours = diff.inHours % 24;
  final minutes = diff.inMinutes % 60;
  if (days > 14) return '${diff.inDays}d';
  if (days > 0) return '${days}d ${hours}h';
  if (hours > 0) return '${hours}h ${minutes}m';
  return '${minutes}m';
}
