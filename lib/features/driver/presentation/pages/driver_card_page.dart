import 'package:flutter/material.dart';

/// Driver card — stats, season results, points chart.
/// Full-screen route (outside the shell → no bottom nav, no appbar).
class DriverCardPage extends StatelessWidget {
  final String id;

  const DriverCardPage({required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Center(child: Text('Driver card — Phase 2')),
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
