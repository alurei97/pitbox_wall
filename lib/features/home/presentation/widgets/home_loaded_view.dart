import 'package:flutter/material.dart';

import '../../../../shared/widgets/cache_info_banner.dart';
import '../cubit/home_state.dart';
import 'next_race_hero_card.dart';
import 'race_week_badge.dart';

/// Next race card, session countdown, season stats.
class HomeLoadedView extends StatelessWidget {
  const HomeLoadedView({required this.data, super.key});

  final HomeData data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final now = DateTime.now();
    final nextRace = data.nextRace;
    final seasonYear = data.nextRace?.raceDateTime.toLocal().year ?? now.year;

    return Column(
      crossAxisAlignment: .start,
      children: [
        // ── Season header ──
        Padding(
          padding: const .symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: .center,
            children: [
              Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    nextRace != null ? nextRace.raceName : 'Season $seasonYear finished',
                    style: theme.textTheme.headlineLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (nextRace != null)
                    Text(
                      '${nextRace.circuitName} · Round ${nextRace.round}',
                      style: theme.textTheme.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),

              if (nextRace != null) ...[
                const Spacer(),
                RaceWeekBadge(raceDate: nextRace.raceDateTime),
              ],
            ],
          ),
        ),
        CacheInfoBanner(cache: data.cache),

        // ── All-done message ──
        if (nextRace == null)
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(top: 48),
              child: Center(
                child: Text(
                  '🏁 Season finished!\nSee you next year!',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: .w700,
                  ),
                ),
              ),
            ),
          ),
        //TODO: if season if finished: add season stats, winner...

        // ── Next race card ──
        if (nextRace != null) ...[
          Padding(
            padding: const .all(16.0),
            child: NextRaceHeroCard(race: nextRace, sessions: data.sessions),
          ),
        ],

        const Text(
          'TODO(phase-3): Season stats — top 3 drivers + constructors by points, and last race result summary (podium + fastest lap).',
        ),
      ],
    );
  }
}
