import 'package:flutter/material.dart';

import '../../../../shared/theme/app_theme.dart';
import '../../../standings/domain/entities/constructor_standing.dart';

/// Compact section showing the top 3 constructor standings on the home screen.
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
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.colorScheme.onPrimary.withValues(alpha: 0.5),
          ),
        ),
        for (final standing in constructors) _ConstructorStandingRow(standing: standing),
      ],
    );
  }
}

class _ConstructorStandingRow extends StatelessWidget {
  const _ConstructorStandingRow({required this.standing});

  final ConstructorStanding standing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final teamColor = AppTheme.teamColor(standing.constructorId);

    return Row(
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
          decoration: BoxDecoration(color: teamColor),
        ),
        const SizedBox(width: 4),

        Expanded(
          child: Text(
            standing.constructorName,
            maxLines: 1,
            overflow: .ellipsis,
            style: theme.textTheme.titleMedium,
          ),
        ),

        Text(
          standing.points.toStringAsFixed(0),
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
