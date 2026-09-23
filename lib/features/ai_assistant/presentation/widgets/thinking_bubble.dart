import 'package:flutter/material.dart';

/// Loading indicator shown while the AI is generating a response.
class ThinkingBubble extends StatelessWidget {
  const ThinkingBubble({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: .centerLeft,
      child: Container(
        margin: const .only(bottom: 12),
        padding: const .symmetric(horizontal: 16, vertical: 14),
        child: const SizedBox(width: 52, child: LinearProgressIndicator(minHeight: 5)),
      ),
    );
  }
}
