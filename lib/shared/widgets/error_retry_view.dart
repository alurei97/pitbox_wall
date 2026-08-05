import 'package:flutter/material.dart';

/// Full-screen error state with a retry action.
///
/// Used when a screen has no data to show: empty cache + failed network call
/// (first launch while offline, API down, rate-limited).
class ErrorRetryView extends StatelessWidget {
  /// Icon shown above the message. Defaults to `cloud_off`.
  final IconData icon;

  /// Short headline, e.g. "Can't reach the F1 servers".
  final String title;

  /// One-line explanation for the user, e.g. "Check your connection and try again."
  final String message;

  /// Retry button label. Defaults to "Retry".
  final String actionLabel;

  /// Called when the user taps the action. Null hides the button entirely.
  final VoidCallback? onRetry;

  const ErrorRetryView({
    super.key,
    this.icon = Icons.cloud_off,
    required this.title,
    required this.message,
    this.actionLabel = 'Retry',
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const .symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: .min,
          children: [
            Icon(icon, size: 56, color: const Color(0xFF555555)),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: .center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: .center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: Text(actionLabel),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
