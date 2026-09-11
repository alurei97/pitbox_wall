import 'package:flutter/material.dart';

import '../../../../shared/widgets/downloading_history_view.dart';
import '../../../standings/domain/entities/driver_standing.dart';
import 'driver_header.dart';

class DriverLoadingView extends StatelessWidget {
  const DriverLoadingView({
    required this.driver,
    required this.onBack,
    super.key,
  });

  final DriverStanding driver;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DriverHeader(driver: driver, onBack: onBack),
        const Expanded(
          child: Center(
            child: DownloadingHistoryView(message: 'Fetching driver data...'),
          ),
        ),
      ],
    );
  }
}
