import 'package:flutter/material.dart';

import '../../../schedule/domain/entities/race.dart';
import '../../../../shared/utils/date_time_format.dart';

class RaceSessionEntry {
  const RaceSessionEntry(this.name, this.dt);

  final String name;
  final DateTime dt;
}

List<RaceSessionEntry> buildRaceSessions(Race race) {
  return [
    RaceSessionEntry('Free Practice 1', race.fp1DateTime),
    if (race.fp2DateTime != null) RaceSessionEntry('Free Practice 2', race.fp2DateTime!),
    if (race.sprintQualifyingDateTime != null)
      RaceSessionEntry('Sprint Qualifying', race.sprintQualifyingDateTime!),
    if (race.sprintDateTime != null) RaceSessionEntry('Sprint', race.sprintDateTime!),
    if (race.fp3DateTime != null) RaceSessionEntry('Free Practice 3', race.fp3DateTime!),
    RaceSessionEntry('Qualifying', race.qualifyingDateTime),
    RaceSessionEntry('Race', race.raceDateTime),
  ]..sort((a, b) => a.dt.compareTo(b.dt));
}

enum RaceSessionState { active, finished, upcoming }

class RaceSessionSchedule extends StatelessWidget {
  const RaceSessionSchedule({
    required this.sessions,
    required this.status,
    required this.activeIndex,
    required this.now,
    super.key,
  });

  final List<RaceSessionEntry> sessions;
  final RaceStatus status;
  final int? activeIndex;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Padding(
          padding: const .fromLTRB(16, 24, 16, 0),
          child: Text(
            'Session Schedule',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),

        for (var i = 0; i < sessions.length; i++) ...[
          Padding(
            padding: const .symmetric(horizontal: 0),
            child: _RaceSessionTile(
              name: sessions[i].name,
              dt: sessions[i].dt,
              highlight: sessions[i].name == 'Race',
              state: _sessionState(sessions[i], i, status, activeIndex, now),
              now: now,
            ),
          ),
        ],
      ],
    );
  }
}

RaceSessionState? _sessionState(
  RaceSessionEntry session,
  int index,
  RaceStatus status,
  int? activeIndex,
  DateTime now,
) {
  if (status != .currentWeek) return null;
  if (index == activeIndex) return .active;
  if (session.dt.isAfter(now)) return .upcoming;
  return .finished;
}

class _RaceSessionTile extends StatelessWidget {
  const _RaceSessionTile({
    required this.name,
    required this.dt,
    this.highlight = false,
    this.state,
    this.now,
  });

  final String name;
  final DateTime dt;
  final bool highlight;
  final RaceSessionState? state;
  final DateTime? now;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    final (textColor, weight, trailing, trailingColor) = switch (state) {
      .active => (primary, FontWeight.w700, 'In progress', primary),
      .finished => (
        theme.colorScheme.onSurface.withValues(alpha: .35),
        FontWeight.w400,
        formatSessionDateTime(dt),
        theme.colorScheme.onSurface.withValues(alpha: .35),
      ),
      .upcoming => (
        theme.colorScheme.onSurface,
        FontWeight.w500,
        'in ${formatRaceCountdown(dt, now!)}',
        theme.colorScheme.onSurface.withValues(alpha: .6),
      ),
      null => (
        highlight ? primary : theme.colorScheme.onSurface,
        highlight ? FontWeight.w700 : FontWeight.w500,
        formatSessionDateTime(dt),
        (highlight ? primary : theme.colorScheme.onSurface).withValues(alpha: highlight ? 1 : .6),
      ),
    };

    return Padding(
      padding: const .symmetric(horizontal: 20, vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              name,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: weight,
                color: textColor,
              ),
            ),
          ),
          Text(
            trailing,
            style: TextStyle(fontWeight: weight, color: trailingColor),
          ),
        ],
      ),
    );
  }
}

String formatRaceCountdown(DateTime target, DateTime now) {
  final diff = target.difference(now);
  if (diff.isNegative) return 'soon';
  final days = diff.inDays;
  final hours = diff.inHours % 24;
  final minutes = diff.inMinutes % 60;
  if (days > 0) return '${days}d ${hours}h';
  if (hours > 0) return '${hours}h ${minutes}m';
  return '${minutes}m';
}
