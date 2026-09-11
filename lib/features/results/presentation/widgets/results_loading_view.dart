import 'package:flutter/material.dart';

import '../../../../shared/widgets/downloading_history_view.dart';

class ResultsLoadingView extends StatelessWidget {
  const ResultsLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const DownloadingHistoryView(
      message: 'Downloading session results...',
      showIcon: true,
    );
  }
}
