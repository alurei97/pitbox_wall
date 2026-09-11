import 'package:flutter/material.dart';

import '../../../../core/utils/f1_cdn.dart';
import '../../../standings/domain/entities/driver_standing.dart';

class ConstructorDriversList extends StatelessWidget {
  const ConstructorDriversList({
    required this.drivers,
    required this.teamColor,
    super.key,
  });

  final List<DriverStanding> drivers;
  final Color teamColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Text(
            'Drivers',
            style: theme.textTheme.titleMedium,
          ),
          for (final driver in drivers)
            ListTile(
              contentPadding: .zero,
              leading: CircleAvatar(
                backgroundColor: teamColor.withValues(alpha: .35),
                child: ClipOval(
                  child: Image.network(
                    F1Cdn.driverAvatar(
                      driver.constructorId,
                      driver.givenName,
                      driver.familyName,
                    ),
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => const Icon(Icons.person, size: 40),
                  ),
                ),
              ),
              title: Text(
                '${driver.givenName} ${driver.familyName}',
                style: theme.textTheme.bodyLarge,
              ),
              subtitle: Text(
                'P${driver.position} · ${driver.points.toStringAsFixed(0)} pts',
                style: theme.textTheme.bodyMedium,
              ),
            ),
        ],
      ),
    );
  }
}
