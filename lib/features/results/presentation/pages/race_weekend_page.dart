import 'package:flutter/material.dart';

import '../../../schedule/domain/entities/race.dart';
import '../widgets/race_weekend_header.dart';
import '../widgets/race_weekend_results.dart';
import '../widgets/race_weekend_sessions.dart';
import '../widgets/race_weekend_skeleton.dart';
import '../widgets/race_weekend_status.dart';

/// Full-screen race detail page: event header, schedule, and session results.
class RaceWeekendPage extends StatelessWidget {
  const RaceWeekendPage({required this.round, this.race, super.key});

  final String round;
  final Race? race;

  @override
  Widget build(BuildContext context) {
    final currentRace = race;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Stack(
        children: [
          if (currentRace != null)
            _RaceWeekendContent(race: currentRace)
          else
            const RaceWeekendSkeleton(),

          Positioned(
            top: 0,
            left: 0,
            child: SafeArea(
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RaceWeekendContent extends StatelessWidget {
  const _RaceWeekendContent({required this.race});

  final Race race;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final status = race.statusAt(now);
    final sessions = buildRaceSessions(race);
    final activeIndex = status == RaceStatus.currentWeek
        ? sessions.lastIndexWhere((session) => !session.dt.isAfter(now))
        : null;
    final topInset = MediaQuery.paddingOf(context).top + kMinInteractiveDimension;

    if (status == .future) {
      return Padding(
        padding: EdgeInsets.fromLTRB(16, topInset, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RaceWeekendHeader(race: race, status: status, sessionCount: sessions.length),
            RaceSessionSchedule(
              sessions: sessions,
              status: status,
              activeIndex: activeIndex,
              now: now,
            ),
            UpcomingRaceCard(race: race, now: now),
          ],
        ),
      );
    }

    return ListView(
      padding: EdgeInsets.fromLTRB(16, topInset, 16, 16),
      children: [
        RaceWeekendHeader(race: race, status: status, sessionCount: sessions.length),

        if (status != .past)
          RaceSessionSchedule(
            sessions: sessions,
            status: status,
            activeIndex: activeIndex,
            now: now,
          ),

        RaceResultsSection(
          race: race,
          isCurrentWeek: status == .currentWeek,
        ),
      ],
    );
  }
}
