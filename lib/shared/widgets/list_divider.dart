import 'package:flutter/material.dart';

class ListDivider extends StatelessWidget {
  const ListDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const .symmetric(horizontal: 0),
      child: Divider(
        height: 4,
        thickness: 1,
        color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
      ),
    );
  }
}
