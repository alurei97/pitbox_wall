import 'package:flutter/material.dart';

import '../../domain/entities/race_result.dart';

class RaceResultsTable extends StatelessWidget {
  const RaceResultsTable({super.key, required this.title, required this.results});

  final String title;
  final List<RaceResult> results;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const .all(12),
      child: Column(
        crossAxisAlignment: .start,
        mainAxisSize: .min,
        children: [
          for (final result in results)
            ListTile(
              dense: true,
              contentPadding: .zero,
              textColor: _statusColor(context, result),
              leading: Text(
                'P${result.position}',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: _statusColor(context, result),
                ),
              ),
              title: Text(
                '${result.givenName} ${result.familyName}',
                style: theme.textTheme.bodySmall?.copyWith(color: _statusColor(context, result)),
              ),
              subtitle: Text(
                result.constructorName,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: .4),
                ),
              ),
              trailing: Column(
                mainAxisAlignment: .center,
                crossAxisAlignment: .end,
                children: [
                  Row(
                    mainAxisSize: .min,
                    children: [
                      if (_isRetired(result))
                        const _StatusTag(label: 'DNF')
                      else ...[
                        if (result.points > 0) Text('+${result.points.toStringAsFixed(0)} pts'),
                      ],
                    ],
                  ),
                  if (result.status == 'Lapped')
                    Text('LAPPED', style: Theme.of(context).textTheme.labelSmall),
                  if (result.time != null && result.status != 'Lapped')
                    Text(result.time!, style: Theme.of(context).textTheme.labelSmall),
                ],
              ),
            ),
        ],
      ),
    );
  }

  bool _isRetired(RaceResult result) => result.status != 'Finished' && result.status != 'Lapped';

  Color _statusColor(BuildContext context, RaceResult result) => switch (result.status) {
    'Retired' => Theme.of(context).colorScheme.onSurface.withValues(alpha: .4),
    _ => Theme.of(context).colorScheme.onSurface,
  };
}

class _StatusTag extends StatelessWidget {
  const _StatusTag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const .symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: .1),
        borderRadius: .circular(4),
      ),
      child: Text(label, style: Theme.of(context).textTheme.bodySmall),
    );
  }
}
