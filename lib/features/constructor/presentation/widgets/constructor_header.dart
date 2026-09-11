import 'package:flutter/material.dart';

import '../../../../core/utils/f1_cdn.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../../standings/domain/entities/constructor_standing.dart';

class ConstructorHeader extends StatelessWidget {
  const ConstructorHeader({
    required this.constructor,
    required this.onBack,
    super.key,
  });

  final ConstructorStanding constructor;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final teamColor = AppTheme.teamColor(constructor.constructorId);

    return Container(
      padding: const .fromLTRB(0, 16, 16, 16),
      decoration: BoxDecoration(color: teamColor.withValues(alpha: .14)),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  'P${constructor.position}',
                  style: theme.textTheme.labelLarge?.copyWith(color: teamColor),
                ),
                Text(
                  constructor.constructorName,
                  style: theme.textTheme.headlineLarge,
                ),
              ],
            ),
          ),

          Container(
            width: 76,
            height: 76,
            padding: const .all(8),
            decoration: BoxDecoration(
              color: teamColor.withValues(alpha: .35),
              shape: BoxShape.circle,
            ),
            child: Image.network(
              F1Cdn.teamLogo(constructor.constructorId),
              fit: BoxFit.contain,
              errorBuilder: (_, _, _) => const Icon(Icons.flag, size: 40),
            ),
          ),
        ],
      ),
    );
  }
}
