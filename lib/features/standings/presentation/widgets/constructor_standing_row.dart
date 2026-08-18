import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/theme/app_theme.dart';
import '../../domain/entities/constructor_standing.dart';

class ConstructorStandingRow extends StatelessWidget {
  const ConstructorStandingRow({required this.standing, super.key});

  final ConstructorStanding standing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final teamColor = AppTheme.teamColor(standing.constructorId);

    return GestureDetector(
      behavior: .opaque,
      onTap: () => context.push('/constructor/${standing.constructorId}'),
      child: Padding(
        padding: const .symmetric(horizontal: 2, vertical: 12),
        child: Row(
          crossAxisAlignment: .center,
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.12,
              child: Text(
                standing.position.toString(),
                textAlign: .left,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.onPrimary.withValues(alpha: 0.6),
                ),
              ),
            ),

            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Row(
                    spacing: 6,
                    children: [
                      Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(color: teamColor),
                      ),
                      Text(
                        standing.constructorName,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: .w600,
                        ),
                        maxLines: 1,
                        overflow: .ellipsis,
                      ),
                    ],
                  ),
                  Text(
                    '${standing.wins} wins',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                    maxLines: 1,
                    overflow: .ellipsis,
                  ),
                ],
              ),
            ),

            Text(
              standing.points.toStringAsFixed(0),
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
