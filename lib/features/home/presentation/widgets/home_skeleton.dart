import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// Skeleton placeholder that mirrors the home screen layout while data loads.
class HomeSkeleton extends StatelessWidget {
  const HomeSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: Column(
        crossAxisAlignment: .start,
        children: [
          // ── Season header ──
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: .center,
              children: [
                Column(
                  crossAxisAlignment: .start,
                  children: [
                    Bone.text(width: 160, fontSize: 30),
                    SizedBox(height: 4),
                    Bone.text(width: 120, fontSize: 14),
                  ],
                ),
                Spacer(),
                Bone.text(width: 80, fontSize: 12),
              ],
            ),
          ),

          // ── Cache banner bones ──
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Bone.text(width: 220, fontSize: 11),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Bone.text(width: 200, fontSize: 11),
          ),

          // ── Next race hero card ──
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(width: 1.5),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 26, vertical: 14),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Bone.text(width: 100, fontSize: 18),
                    SizedBox(height: 8),
                    Bone.text(width: 140, fontSize: 40),
                    SizedBox(height: 8),
                    Bone.text(width: 160, fontSize: 14),
                  ],
                ),
              ),
            ),
          ),

          // ── Top 5 drivers ──
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: .start,
              spacing: 8,
              children: [
                const Bone.text(width: 160, fontSize: 18),
                const SizedBox(height: 4),
                for (var i = 0; i < 5; i++) ...[
                  const _StandingRowSkeleton(),
                  if (i < 4) const SizedBox(height: 8),
                ],
              ],
            ),
          ),

          // ── Top 3 constructors ──
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: .start,
              spacing: 8,
              children: [
                const SizedBox(height: 24),
                const Bone.text(width: 200, fontSize: 18),
                const SizedBox(height: 4),
                for (var i = 0; i < 3; i++) ...[
                  const _StandingRowSkeleton(),
                  if (i < 2) const SizedBox(height: 8),
                ],
              ],
            ),
          ),

          // ── Last race podium ──
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                const SizedBox(height: 24),
                const Bone.text(width: 180, fontSize: 18),
                const SizedBox(height: 4),
                const Bone.text(width: 200, fontSize: 14),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: .end,
                  children: [
                    for (var i = 0; i < 3; i++)
                      Expanded(
                        child: _PodiumSpotSkeleton(stepHeight: [50.0, 68.0, 38.0][i]),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StandingRowSkeleton extends StatelessWidget {
  const _StandingRowSkeleton();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: .center,
      children: [
        const SizedBox(
          width: 24,
          child: Bone.text(width: 24, fontSize: 16),
        ),
        const Bone.text(width: 6, fontSize: 26),
        const SizedBox(width: 6),
        Expanded(
          child: Bone.text(fontSize: 16),
        ),
        const SizedBox(width: 4),
        const Bone.text(width: 30, fontSize: 14),
        const SizedBox(width: 4),
        const Bone.text(width: 40, fontSize: 16),
      ],
    );
  }
}

class _PodiumSpotSkeleton extends StatelessWidget {
  const _PodiumSpotSkeleton({required this.stepHeight});

  final double stepHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: stepHeight + 45,
      child: Center(child: Bone.text(fontSize: stepHeight + 45)),
    );
  }
}
