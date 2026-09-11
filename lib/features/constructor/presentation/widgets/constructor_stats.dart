import 'package:flutter/material.dart';

class ConstructorStats extends StatelessWidget {
  const ConstructorStats({
    required this.stats,
    super.key,
  });

  final List<(String, int)> stats;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const .all(16),
    child: GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 2.4,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      children: [
        for (final stat in stats)
          Card(
            child: Padding(
              padding: const .all(12),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(stat.$1, style: Theme.of(context).textTheme.labelSmall),
                  Text(
                    '${stat.$2}',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
            ),
          ),
      ],
    ),
  );
}
