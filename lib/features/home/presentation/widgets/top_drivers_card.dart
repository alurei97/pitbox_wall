import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/theme/app_theme.dart';
import '../../../standings/domain/entities/driver_standing.dart';

/// Compact section showing top 5 drivers on the home screen.
class TopDrivers extends StatelessWidget {
  const TopDrivers({required this.drivers, super.key});

  final List<DriverStanding> drivers;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: .start,
      spacing: 8,
      children: [
        Text(
          'DRIVER STANDINGS',
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.colorScheme.onPrimary.withValues(alpha: 0.5),
          ),
        ),
        for (var i = 0; i < drivers.length; i++) ...[
          _DriverStandingRow(standing: drivers[i], maxScore: drivers.first.points),
        ],
      ],
    );
  }
}

class _DriverStandingRow extends StatelessWidget {
  const _DriverStandingRow({required this.standing, required this.maxScore});

  final DriverStanding standing;
  final double maxScore;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final teamColor = AppTheme.teamColor(standing.constructorId);
    final double pointsDelta = standing.points - maxScore;

    return GestureDetector(
      behavior: .opaque,
      onTap: () => context.push('/driver/${standing.driverId}'),
      child: Row(
        crossAxisAlignment: .center,
        children: [
          SizedBox(
            width: 24,
            child: Text(
              standing.position.toString(),
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onPrimary.withValues(alpha: 0.5),
              ),
            ),
          ),

          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: teamColor,
            ),
          ),
          const SizedBox(width: 4),

          Expanded(
            child: Text(
              standing.familyName,
              maxLines: 1,
              overflow: .ellipsis,
              style: theme.textTheme.titleMedium,
            ),
          ),

          if (pointsDelta < 0) ...[
            Text(
              '(${pointsDelta.toStringAsFixed(0)})',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onPrimary.withValues(alpha: 0.5),
              ),
            ),
            const SizedBox(width: 4),
          ],

          Text(
            standing.points.toStringAsFixed(0),
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
