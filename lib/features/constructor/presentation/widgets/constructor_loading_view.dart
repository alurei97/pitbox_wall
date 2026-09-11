import 'package:flutter/material.dart';

import '../../../standings/domain/entities/constructor_standing.dart';
import '../../../../shared/widgets/downloading_history_view.dart';
import 'constructor_header.dart';

class ConstructorLoadingView extends StatelessWidget {
  const ConstructorLoadingView({required this.constructor, required this.onBack, super.key});

  final ConstructorStanding constructor;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ConstructorHeader(constructor: constructor, onBack: onBack),
        const Expanded(
          child: Center(
            child: DownloadingHistoryView(message: 'Fetching constructor data...'),
          ),
        ),
      ],
    );
  }
}
