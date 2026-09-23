import 'package:flutter/material.dart';

import 'chat_message.dart';
import 'markdown_utils.dart';

/// A single chat message bubble in the conversation.
class ChatBubble extends StatelessWidget {
  const ChatBubble({required this.message, super.key});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isUser = message.isUser;
    final width = MediaQuery.of(context).size.width;

    return Align(
      alignment: isUser ? .centerRight : .centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: width * .9),
        margin: const .only(bottom: 12),
        padding: const .symmetric(horizontal: 14, vertical: 11),
        decoration: BoxDecoration(
          color: isUser ? theme.colorScheme.primary : null,
          borderRadius: BorderRadius.only(
            topLeft: const .circular(14),
            topRight: const .circular(14),
            bottomLeft: .circular(isUser ? 14 : 0),
            bottomRight: .circular(isUser ? 3 : 0),
          ),
        ),
        child: Text.rich(
          TextSpan(children: markdownToSpans(message.text, theme.textTheme.bodyMedium)),
        ),
      ),
    );
  }
}
