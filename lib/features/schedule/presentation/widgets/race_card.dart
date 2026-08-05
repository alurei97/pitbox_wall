import 'package:flutter/material.dart';

import '../../../../shared/utils/flags.dart';
import '../../domain/entities/race.dart';
import 'race_status.dart';
import 'schedule_items.dart' show monthNames;

// ---------------------------------------------------------------------------
// Race card
// ---------------------------------------------------------------------------

class RaceCard extends StatelessWidget {
  const RaceCard({
    super.key,
    required this.race,
    required this.chip,
    required this.onTap,
    this.showDivider = false,
  });

  final Race race;
  final ListChip? chip;
  final VoidCallback onTap;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final flag = flagEmojiForCountry(race.country);

    return Padding(
      padding: EdgeInsets.only(bottom: showDivider ? 0 : 8),
      child: Column(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.12,
                    child: Text(
                      _dateLabel(race),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 12,
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ),

                  Column(
                    children: [
                      Text(
                        flag ?? '',
                        style: theme.textTheme.headlineSmall,
                      ),
                      Text(
                        'R${race.round}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          race.raceName,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          race.circuitName,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    child: chip != null ? StatusChip(chip: chip!) : const Offstage(),
                  ),
                ],
              ),
            ),
          ),

          if (showDivider)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Divider(
                height: 4,
                thickness: 1,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
              ),
            ),
        ],
      ),
    );
  }

  String _dateLabel(Race r) {
    final local = r.fp1DateTime.toLocal();
    final raceLocal = r.raceDateTime.toLocal();
    final month = monthNames[raceLocal.month - 1].substring(0, 3);
    return '${local.day}-${raceLocal.day}\n$month';
  }
}

// ---------------------------------------------------------------------------
// Status chip
// ---------------------------------------------------------------------------

/// Small rounded status badge shown on each race card.
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
