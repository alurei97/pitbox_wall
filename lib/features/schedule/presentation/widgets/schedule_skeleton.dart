import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../shared/widgets/list_divider.dart';

/// Skeleton placeholder that mirrors the loaded schedule layout while data is loading.
class ScheduleSkeleton extends StatelessWidget {
  const ScheduleSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: Column(
        children: [
          // ── Season header ──
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Bone.text(width: 160, fontSize: 30),
            ),
          ),

          // ── Cache banner ──
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Bone.text(width: 220, fontSize: 11),
          ),

          // ── Scrollable list skeleton ──
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Month header
                const Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Bone.text(width: 100, fontSize: 14),
                ),

                // Race card skeletons — matches the real Row layout
                for (var i = 0; i < 4; i++) ...[
                  const _RaceCardSkeleton(),
                ],

                const SizedBox(height: 24),

                // Second month header
                const Padding(
                  padding: EdgeInsets.only(bottom: 8),
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
      padding: EdgeInsets.only(bottom: 8),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2, vertical: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Date column
                SizedBox(
                  width: 56,
                  child: Bone.text(width: 48, fontSize: 16),
                ),

                // Flag + round
                Column(
                  children: [
                    Bone.text(width: 24, fontSize: 20),
                    SizedBox(height: 2),
                    Bone.text(width: 20, fontSize: 14),
                  ],
                ),
                SizedBox(width: 10),

                // Name + circuit
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Bone.text(width: 160, fontSize: 16),
                      SizedBox(height: 4),
                      Bone.text(width: 120, fontSize: 12),
                    ],
                  ),
                ),

                // Status chip
                Bone.text(width: 44, fontSize: 12),
              ],
            ),
          ),
          ListDivider(),
        ],
      ),
    );
  }
}
