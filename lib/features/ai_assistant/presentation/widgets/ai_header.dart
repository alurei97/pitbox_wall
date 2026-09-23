import 'package:flutter/material.dart';

/// Header widget for the AI chat page showing title, status, and clear button.
class AiHeader extends StatelessWidget {
  const AiHeader({required this.theme, required this.onClear, super.key});

  final ThemeData theme;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .symmetric(horizontal: 16),
      child: Row(
        children: [
          Text(
            'Pitbox Wall AI',
            style: theme.textTheme.headlineLarge,
          ),
          const Spacer(),
          IconButton(
            tooltip: 'Clear conversation',
            onPressed: onClear,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}
