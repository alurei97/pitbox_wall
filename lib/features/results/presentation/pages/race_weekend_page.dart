import 'package:flutter/material.dart';

/// Race weekend — Qualifying / Race / Sprint tabs.
/// Full-screen route (outside the shell → no bottom nav, no appbar).
class RaceWeekendPage extends StatelessWidget {
  final String round;

  const RaceWeekendPage({required this.round, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Center(child: Text('Race weekend — Phase 2')),
          // Back affordance since this is a full-screen push with no appbar.
          Positioned(
            top: 0,
            left: 0,
            child: SafeArea(
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
