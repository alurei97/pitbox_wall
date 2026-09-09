import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// Skeleton placeholder that mirrors the race weekend page layout.
class RaceWeekendSkeleton extends StatelessWidget {
  const RaceWeekendSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.paddingOf(context).top + kMinInteractiveDimension;

    return Skeletonizer(
      child: ListView(
        padding: EdgeInsets.fromLTRB(16, topInset, 16, 16),
        children: [
          // ── Header ──
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Bone.text(width: 72, fontSize: 12),
                  SizedBox(width: 8),
                  Bone.text(width: 56, fontSize: 10),
                ],
              ),
              SizedBox(height: 4),
              Bone.text(width: 240, fontSize: 26),
              SizedBox(height: 4),
              Bone.text(width: 210, fontSize: 14),
              SizedBox(height: 4),
              Row(
                children: [
                  Bone.text(width: 100, fontSize: 12),
                  Spacer(),
                  Bone.icon(size: 20),
                ],
              ),
              SizedBox(height: 16),
            ],
          ),

          const SizedBox(height: 24),
          const Bone.text(width: 130, fontSize: 16),
          const SizedBox(height: 8),

          // ── Session tiles ──
          for (var i = 0; i < 7; i++) ...[
            const _SessionTileSkeleton(),
            if (i < 6) const SizedBox(height: 6),
          ],

          const SizedBox(height: 24),
          const Bone.text(width: 100, fontSize: 16),
          const SizedBox(height: 8),

          // ── Tabs skeleton ──
          const Row(
            children: [
              Bone.text(width: 60, fontSize: 14),
              SizedBox(width: 16),
              Bone.text(width: 28, fontSize: 14),
              SizedBox(width: 16),
              Bone.text(width: 28, fontSize: 14),
              SizedBox(width: 16),
              Bone.text(width: 28, fontSize: 14),
              Spacer(),
              Bone.text(width: 40, fontSize: 14),
            ],
          ),
          const SizedBox(height: 12),

          // ── Results table skeleton ──
          const Card(
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                children: [
                  Bone.text(width: 60, fontSize: 14),
                  SizedBox(height: 12),
                  _ResultRowSkeleton(),
                  SizedBox(height: 8),
                  _ResultRowSkeleton(),
                  SizedBox(height: 8),
                  _ResultRowSkeleton(),
                  SizedBox(height: 8),
                  _ResultRowSkeleton(),
                  SizedBox(height: 8),
                  _ResultRowSkeleton(),
                  SizedBox(height: 8),
                  _ResultRowSkeleton(),
                  SizedBox(height: 8),
                  _ResultRowSkeleton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SessionTileSkeleton extends StatelessWidget {
  const _SessionTileSkeleton();

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        child: Row(
          children: [
            Expanded(child: Bone.text(width: 140, fontSize: 14)),
            Bone.text(width: 90, fontSize: 13),
          ],
        ),
      ),
    );
  }
}

class _ResultRowSkeleton extends StatelessWidget {
  const _ResultRowSkeleton();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Bone.text(width: 28, fontSize: 14),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Bone.text(width: 140, fontSize: 13),
              Bone.text(width: 100, fontSize: 11),
            ],
          ),
        ),
        Bone.text(width: 50, fontSize: 13),
      ],
    );
  }
}
