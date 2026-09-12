import 'package:flutter/material.dart';

import '../../../../shared/debug/debug_flags.dart';
import '../../../../shared/widgets/cache_info_banner.dart';
import '../cubit/home_state.dart';
import 'next_race_hero_card.dart';
import 'last_race_podium.dart';
import 'race_week_badge.dart';
import 'top_constructors_card.dart';
import 'top_drivers_card.dart';

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
                  GestureDetector(
                    onLongPress: () => showCacheInfo.value = !showCacheInfo.value,
                    child: Text(
                      nextRace != null ? nextRace.raceName : 'Season $seasonYear finished',
                      style: theme.textTheme.headlineLarge,
                      maxLines: 1,
                      overflow: .ellipsis,
                    ),
                  ),
                  if (nextRace != null)
                    Text(
                      '${nextRace.circuitName} · Round ${nextRace.round}',
                      style: theme.textTheme.titleSmall,
                      maxLines: 1,
                      overflow: .ellipsis,
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
        CacheInfoBanner(cache: data.cache, label: 'SCHEDULE'),
        if (data.standingsCache != null)
          CacheInfoBanner(cache: data.standingsCache!, label: 'STANDINGS'),

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

        // ── Top 5 drivers ──
        if (data.topDrivers.isNotEmpty) ...[
          Padding(
            padding: const .symmetric(horizontal: 16),
            child: TopDrivers(drivers: data.topDrivers),
          ),
        ],

        // ── Top 3 constructors ──
        if (data.topConstructors.isNotEmpty) ...[
          const SizedBox(height: 24),
          Padding(
            padding: const .symmetric(horizontal: 16),
            child: TopConstructors(constructors: data.topConstructors),
          ),
        ],

        // ── Last race podium ──
        if (data.lastRace != null && data.podium.isNotEmpty) ...[
          const SizedBox(height: 24),
          Padding(
            padding: const .symmetric(horizontal: 16),
            child: LastRacePodium(race: data.lastRace!, podium: data.podium),
          ),
        ],
      ],
    );
  }
}
