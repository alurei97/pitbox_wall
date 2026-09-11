import 'package:flutter/material.dart';

import '../../../../shared/widgets/downloading_history_view.dart';
import '../../../standings/domain/entities/driver_standing.dart';
import 'driver_header.dart';

class DriverLoadingView extends StatelessWidget {
  const DriverLoadingView({
    this.driver,
    this.onBack,
    super.key,
  });

  /// Driver info passed from the navigation site, shown instantly while the
  /// rest of the season data loads. Null when the page was opened without it.
  final DriverStanding? driver;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (driver != null && onBack != null) DriverHeader(driver: driver!, onBack: onBack!),
        const Expanded(
          child: Center(
            child: DownloadingHistoryView(message: 'Fetching driver data...'),
          ),
        ),
      ],
    );
  }
}
