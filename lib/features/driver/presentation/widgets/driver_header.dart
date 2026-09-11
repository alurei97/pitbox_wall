import 'package:flutter/material.dart';

import '../../../../core/utils/f1_cdn.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../../standings/domain/entities/driver_standing.dart';

class DriverHeader extends StatelessWidget {
  const DriverHeader({
    required this.driver,
    required this.onBack,
    super.key,
  });

  final DriverStanding driver;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final teamColor = AppTheme.teamColor(driver.constructorId);

    return Container(
      padding: const .fromLTRB(0, 16, 16, 16),
      decoration: BoxDecoration(
        color: teamColor.withValues(alpha: .14),
      ),
      child: Row(
        crossAxisAlignment: .center,
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
                  'P${driver.position}',
                  style: theme.textTheme.labelLarge?.copyWith(color: teamColor),
                ),
                Text(
                  '${driver.givenName} ${driver.familyName}',
                  style: theme.textTheme.headlineLarge,
                ),
                Text(
                  driver.constructorName,
                  style: theme.textTheme.headlineSmall,
                ),
                Text(
                  '${driver.nationality}  ·  ${_age(driver.dateOfBirth)}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: .6),
                  ),
                ),
              ],
            ),
          ),

          Column(
            crossAxisAlignment: .center,
            children: [
              Text(
                driver.driverCode ?? ' ',
                style: theme.textTheme.titleMedium,
              ),
              CircleAvatar(
                radius: 36,
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
              Text(
                driver.driverNumber,
                style: theme.textTheme.titleLarge?.copyWith(color: teamColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static String _age(String dateOfBirth) {
    final dob = DateTime.tryParse(dateOfBirth);
    if (dob == null) return '';
    final now = DateTime.now();
    var years = now.year - dob.year;
    if (now.month < dob.month || (now.month == dob.month && now.day < dob.day)) years--;
    return '$years yrs';
  }
}
