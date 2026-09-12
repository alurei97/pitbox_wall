import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/theme/app_theme.dart';
import '../../../results/domain/entities/race_result.dart';
import '../../../schedule/domain/entities/race.dart';

/// Podium for the last completed race, shown on the home screen.
/// Tappable — navigates to the race weekend page.
class LastRacePodium extends StatelessWidget {
  const LastRacePodium({required this.race, required this.podium, super.key});

  final Race race;
  final List<RaceResult> podium;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Classic podium layout: 2nd on the left, 1st in the middle, 3rd on the right.
    final ordered = <RaceResult?>[
      podium.length > 1 ? podium[1] : null,
      podium.isNotEmpty ? podium[0] : null,
      podium.length > 2 ? podium[2] : null,
    ];

    return GestureDetector(
      behavior: .opaque,
      onTap: () => context.push('/race/${race.round}', extra: race),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Text(
            'LAST RACE PODIUM',
            style: theme.textTheme.titleLarge,
          ),
          Text(
            '${race.raceName} · Round ${race.round}',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: .end,
            children: [
              for (int i = 0; i < ordered.length; i++)
                Expanded(
                  child: _PodiumSpot(
                    result: ordered[i],
                    stepHeight: switch (i) {
                      1 => 68,
                      0 => 50,
                      _ => 38,
                    },
                    stepColor: switch (i) {
                      1 => const Color(0xFFD4AF37).withValues(alpha: 0.6),
                      0 => const Color(0xFFB8B8C8).withValues(alpha: 0.6),
                      _ => const Color(0xFFCD7F32).withValues(alpha: 0.6),
                    },
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PodiumSpot extends StatelessWidget {
  const _PodiumSpot({
    required this.result,
    required this.stepHeight,
    required this.stepColor,
  });

  final RaceResult? result;
  final double stepHeight;
  final Color stepColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final teamColor = result != null ? AppTheme.teamColor(result!.constructorId) : null;

    return Column(
      mainAxisSize: .min,
      crossAxisAlignment: .stretch,
      children: [
        // Driver card
        SizedBox(
          height: 60,
          child: result != null
              ? Container(
                  margin: const .symmetric(horizontal: 4),
                  padding: const .symmetric(horizontal: 8, vertical: 6),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest,
                    borderRadius: .circular(8),
                    border: .all(color: theme.colorScheme.outline),
                  ),
                  child: Column(
                    crossAxisAlignment: .stretch,
                    mainAxisSize: .min,
                    children: [
                      Container(height: 3, color: teamColor),
                      Text(
                        result!.familyName,
                        maxLines: 1,
                        overflow: .ellipsis,
                        textAlign: .center,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: .w700,
                        ),
                      ),
                      Text(
                        result!.constructorName,
                        maxLines: 1,
                        overflow: .ellipsis,
                        textAlign: .center,
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
        ),

        // Podium step
        Container(
          height: stepHeight,
          decoration: BoxDecoration(
            color: stepColor,
            borderRadius: const .vertical(top: .circular(8)),
          ),
          child: Center(
            child: Text(
              result?.position.toString() ?? '',
              style: theme.textTheme.headlineMedium?.copyWith(
                color: Colors.white.withValues(alpha: 0.7),
                fontWeight: .w800,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
