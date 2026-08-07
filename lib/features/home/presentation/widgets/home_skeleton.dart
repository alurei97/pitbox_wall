import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// Skeleton placeholder that mirrors the home screen layout while data loads.
class HomeSkeleton extends StatelessWidget {
  const HomeSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Season header ──
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Bone.text(width: 140, fontSize: 30),
          ),

          // ── Cache banner bone ──
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Bone.text(width: 180, fontSize: 11),
          ),

          // ── Next race hero card ──
          Padding(
            padding: EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(width: 1.5),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 26, vertical: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
        ],
      ),
    );
  }
}
