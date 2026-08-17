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
            padding: .symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Bone.text(width: 160, fontSize: 30),
                SizedBox(height: 4),
                Bone.text(width: 120, fontSize: 14),
              ],
            ),
          ),

          // ── Cache banner bones ──
          const Padding(
            padding: .symmetric(horizontal: 16, vertical: 4),
            child: Bone.text(width: 220, fontSize: 11),
          ),
          const Padding(
            padding: .symmetric(horizontal: 16, vertical: 4),
            child: Bone.text(width: 200, fontSize: 11),
          ),

          // ── Next race hero card ──
          Padding(
            padding: const .all(16),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: .circular(12),
                border: .all(width: 1.5),
              ),
              child: const Padding(
                padding: .symmetric(horizontal: 26, vertical: 14),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Bone.text(width: 100, fontSize: 18),
                    SizedBox(height: 8),
                    Bone.text(width: 140, fontSize: 40),
                    SizedBox(height: 12),
                    Bone.text(width: 160, fontSize: 14),
                  ],
                ),
              ),
            ),
          ),

          // ── Top drivers section ──
          const Padding(
            padding: .symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Bone.text(width: 140, fontSize: 16),
                SizedBox(height: 10),
                Bone.text(width: .infinity, fontSize: 14),
                SizedBox(height: 8),
                Bone.text(width: .infinity, fontSize: 14),
                SizedBox(height: 8),
                Bone.text(width: .infinity, fontSize: 14),
                SizedBox(height: 8),
                Bone.text(width: .infinity, fontSize: 14),
                SizedBox(height: 8),
                Bone.text(width: .infinity, fontSize: 14),
              ],
            ),
          ),

          // ── Top constructors section ──
          const Padding(
            padding: .symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Bone.text(width: 180, fontSize: 16),
                SizedBox(height: 10),
                Bone.text(width: .infinity, fontSize: 14),
                SizedBox(height: 8),
                Bone.text(width: .infinity, fontSize: 14),
                SizedBox(height: 8),
                Bone.text(width: .infinity, fontSize: 14),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
