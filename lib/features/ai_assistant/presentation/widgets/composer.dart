import 'package:flutter/material.dart';

/// Text input field and send button for composing messages.
class Composer extends StatelessWidget {
  const Composer({
    required this.controller,
    required this.enabled,
    required this.onSend,
    required this.colorScheme,
    super.key,
  });

  final TextEditingController controller;
  final bool enabled;
  final VoidCallback onSend;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 14),
      child: Row(
        crossAxisAlignment: .end,
        spacing: 8,
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              enabled: enabled,
              minLines: 1,
              maxLines: 4,
              textInputAction: .newline,
              onSubmitted: (_) => onSend(),
              decoration: const InputDecoration(hintText: 'Ask about F1 stats...'),
            ),
          ),
          IconButton.filled(
            tooltip: 'Send message',
            onPressed: enabled ? onSend : null,
            icon: const Icon(Icons.arrow_upward),
            style: IconButton.styleFrom(
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
              minimumSize: const Size(48, 48),
            ),
          ),
        ],
      ),
    );
  }
}
