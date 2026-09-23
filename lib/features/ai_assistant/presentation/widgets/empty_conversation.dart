import 'package:flutter/material.dart';

/// Empty state widget shown when the conversation has no messages yet.
/// Displays suggested prompts the user can tap to start a conversation.
class EmptyConversation extends StatelessWidget {
  const EmptyConversation({
    required this.onPromptSelected,
    required this.controller,
    super.key,
  });

  final ValueChanged<String> onPromptSelected;
  final ScrollController controller;

  static const _prompts = [
    'Who is leading the drivers\' championship?',
    'Compare the top constructors',
    'What is the next race weekend?',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView(
      controller: controller,
      padding: const .all(20),
      children: [
        const SizedBox(height: 60),
        Icon(Icons.query_stats, size: 42, color: theme.colorScheme.primary),
        const SizedBox(height: 16),
        Text(
          'Your race engineer in your pocket.',
          textAlign: .center,
          style: theme.textTheme.headlineMedium,
        ),
        const SizedBox(height: 10),
        Text(
          'Ask a stats question and get a clear answer from the season data.',
          textAlign: .center,
          style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white60),
        ),
        const SizedBox(height: 32),
        Text('TRY ASKING', style: theme.textTheme.labelSmall),
        const SizedBox(height: 10),
        ..._prompts.map(
          (prompt) => Padding(
            padding: const .only(bottom: 8),
            child: OutlinedButton(
              onPressed: () => onPromptSelected(prompt),
              style: OutlinedButton.styleFrom(
                alignment: .centerLeft,
                padding: const .symmetric(horizontal: 14, vertical: 14),
                side: BorderSide(color: theme.colorScheme.outline),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text(prompt),
            ),
          ),
        ),
      ],
    );
  }
}
