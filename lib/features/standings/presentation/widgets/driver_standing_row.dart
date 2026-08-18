import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/f1_cdn.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../domain/entities/driver_standing.dart';

class DriverStandingRow extends StatelessWidget {
  const DriverStandingRow({required this.standing, super.key});

  final DriverStanding standing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final teamColor = AppTheme.teamColor(standing.constructorId);

    return GestureDetector(
      behavior: .opaque,
      onTap: () => context.push('/driver/${standing.driverId}'),
      child: Padding(
        padding: const .symmetric(horizontal: 2, vertical: 12),
        child: Row(
          crossAxisAlignment: .center,
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.1,
              child: Text(
                standing.position.toString(),
                textAlign: .left,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.onPrimary.withValues(alpha: 0.6),
                ),
              ),
            ),

            _DriverAvatar(teamColor: teamColor, standing: standing),
            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    '${standing.givenName} ${standing.familyName}',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: .w600,
                    ),
                    maxLines: 1,
                    overflow: .ellipsis,
                  ),
                  Text(
                    standing.constructorName,
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

class _DriverAvatar extends StatelessWidget {
  const _DriverAvatar({required this.teamColor, required this.standing});

  final Color teamColor;
  final DriverStanding standing;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: teamColor.withValues(alpha: 0.6),
        shape: .circle,
      ),
      clipBehavior: .antiAlias,
      child: CachedNetworkImage(
        imageUrl: F1Cdn.driverAvatar(
          standing.constructorId,
          standing.givenName,
          standing.familyName,
        ),
        fit: BoxFit.cover,
        placeholder: (_, _) => const SizedBox.shrink(),
        errorWidget: (_, _, _) => const Icon(Icons.person_outline),
      ),
    );
  }
}
