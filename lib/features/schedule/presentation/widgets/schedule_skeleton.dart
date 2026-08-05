import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// Skeleton placeholder that mirrors the loaded schedule layout while data is loading.
class ScheduleSkeleton extends StatelessWidget {
  const ScheduleSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: Column(
        children: [
          // ── Season year header ──
          const Padding(
            padding: .fromLTRB(16, 12, 16, 0),
            child: Align(
              alignment: .centerLeft,
              child: Bone.text(width: 160, fontSize: 30),
            ),
          ),

          // ── Scrollable list skeleton ──
          Expanded(
            child: ListView(
              padding: const .all(16),
              children: [
                // Month header
                const Padding(
                  padding: .only(bottom: 8),
                  child: Bone.text(width: 100, fontSize: 14),
                ),

                // Race card skeletons — matches the real Row layout
                for (var i = 0; i < 4; i++) ...[
                  const _RaceCardSkeleton(),
                ],

                const SizedBox(height: 10),

                // Second month header
                const Padding(
                  padding: .only(bottom: 8),
                  child: Bone.text(width: 100, fontSize: 14),
                ),

                // More race card skeletons
                for (var i = 0; i < 3; i++) ...[
                  const _RaceCardSkeleton(),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Skeleton that mirrors the real race card Row layout:
/// date | flag + round | name/circuit | chip
class _RaceCardSkeleton extends StatelessWidget {
  const _RaceCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: .only(bottom: 8),
      child: Column(
        children: [
          Padding(
            padding: .symmetric(horizontal: 2, vertical: 12),
            child: Row(
              crossAxisAlignment: .center,
              spacing: 12,
              children: [
                // Date column
                SizedBox(
                  width: 30,
                  child: Bone.text(width: 30, fontSize: 12),
                ),

                // Flag + round
                Column(
                  spacing: 2,
                  children: [
                    Bone.text(width: 30, fontSize: 24),
                    Bone.text(width: 20, fontSize: 12),
                  ],
                ),

                // Name + circuit
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4,
                    children: [
                      Bone.text(width: 160, fontSize: 16),
                      Bone.text(width: 120, fontSize: 12),
                    ],
                  ),
                ),

                // Chip
                Bone.text(width: 40, fontSize: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
