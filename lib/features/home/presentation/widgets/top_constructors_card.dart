import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/theme/app_theme.dart';
import '../../../standings/domain/entities/constructor_standing.dart';

/// Compact section showing the top 5 constructor standings on the home screen.
class TopConstructors extends StatelessWidget {
  const TopConstructors({required this.constructors, super.key});

  final List<ConstructorStanding> constructors;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: .start,
      spacing: 8,
      children: [
        Text(
          'CONSTRUCTOR STANDINGS',
          style: theme.textTheme.titleLarge,
        ),
        for (final standing in constructors.take(5))
          _ConstructorStandingRow(standing: standing, maxScore: constructors.first.points),
      ],
    );
  }
}

class _ConstructorStandingRow extends StatelessWidget {
  const _ConstructorStandingRow({required this.standing, required this.maxScore});

  final ConstructorStanding standing;
  final double maxScore;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final teamColor = AppTheme.teamColor(standing.constructorId);
    final double pointsDelta = standing.points - maxScore;

    return GestureDetector(
      behavior: .opaque,
      onTap: () => context.push('/constructor/${standing.constructorId}', extra: standing),
      child: Row(
        crossAxisAlignment: .center,
        children: [
          SizedBox(
            width: 24,
            child: Text(
              standing.position.toString(),
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onPrimary.withValues(alpha: 0.6),
              ),
            ),
          ),

          Container(
            width: 6,
            height: 26,
            decoration: BoxDecoration(color: teamColor),
          ),
          const SizedBox(width: 4),

          Expanded(
            child: Text(
              standing.constructorName,
              maxLines: 1,
              overflow: .ellipsis,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: .w600,
              ),
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
