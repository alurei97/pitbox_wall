import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/f1_cdn.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../domain/entities/constructor_standing.dart';

class ConstructorStandingRow extends StatelessWidget {
  const ConstructorStandingRow({
    required this.standing,
    this.selecting = false,
    this.selected = false,
    this.onToggle,
    super.key,
  });

  final ConstructorStanding standing;
  final bool selecting;
  final bool selected;
  final VoidCallback? onToggle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final teamColor = AppTheme.teamColor(standing.constructorId);

    return GestureDetector(
      behavior: .opaque,
      onTap: selecting ? onToggle : () => context.push('/constructor/${standing.constructorId}'),
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

            _TeamLogoPreview(
              team: standing.constructorId,
              background: teamColor.withValues(alpha: 0.6),
            ),
            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    standing.constructorName,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: .w600,
                    ),
                    maxLines: 1,
                    overflow: .ellipsis,
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

            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  standing.points.toStringAsFixed(0),
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
                if (selecting)
                  Checkbox(
                    value: selected,
                    onChanged: (_) => onToggle?.call(),
                    visualDensity: VisualDensity.compact,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TeamLogoPreview extends StatelessWidget {
  const _TeamLogoPreview({required this.team, required this.background});

  final String team;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: background.withValues(alpha: 0.6),
        shape: .circle,
      ),
      clipBehavior: .antiAlias,
      child: CachedNetworkImage(
        imageUrl: F1Cdn.teamLogo(team),
        fit: BoxFit.contain,
        placeholder: (_, _) => const SizedBox.shrink(),
        errorWidget: (_, _, _) => const Icon(Icons.flag_outlined, size: 18),
      ),
    );
  }
}
