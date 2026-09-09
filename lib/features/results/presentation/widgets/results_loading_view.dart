import 'package:flutter/material.dart';

class ResultsLoadingView extends StatelessWidget {
  const ResultsLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(50),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 12,
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: theme.colorScheme.primary,
              ),
            ),
            Text(
              'Downloading session results',
              style: theme.textTheme.titleSmall,
            ),
          ],
        ),
      ),
    );
  }
}
