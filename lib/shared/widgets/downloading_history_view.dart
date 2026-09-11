import 'package:flutter/material.dart';

/// Matches the "Downloading standings history" look from the bump chart,
/// reused wherever season results load in the background.
class DownloadingHistoryView extends StatelessWidget {
  const DownloadingHistoryView({
    required this.message,
    this.showIcon = false,
    super.key,
  });

  final String message;
  final bool showIcon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showIcon) ...[
            Icon(
              Icons.show_chart,
              size: 42,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
            ),
            const SizedBox(height: 8),
            Text('Loading season results', style: theme.textTheme.titleMedium),
            const SizedBox(height: 25),
          ],
          const LinearProgressIndicator(minHeight: 6),
          const SizedBox(height: 12),
          Text(
            message,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
