import 'package:flutter/material.dart';

/// Constructor card — team details, standings, and season results.
/// Full-screen route outside the shell.
class ConstructorCardPage extends StatelessWidget {
  const ConstructorCardPage({required this.id, super.key});

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Text('Constructor card — $id — Phase 2'),
          ),
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
