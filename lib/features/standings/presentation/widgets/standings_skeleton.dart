import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// Skeleton placeholder that mirrors the standings toggle and list layout.
class StandingsSkeleton extends StatelessWidget {
  const StandingsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Bone.text(width: 110, fontSize: 30),
                Spacer(),
                Bone.text(width: 150, fontSize: 14),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Bone.text(width: 220, fontSize: 11),
          ),
          const SizedBox(height: 2),
          Expanded(
            child: ListView.separated(
              itemCount: 12,
              padding: const EdgeInsets.all(16),
              separatorBuilder: (_, _) => const Bone.text(width: double.infinity, fontSize: 1),
              itemBuilder: (_, _) => const Padding(
                padding: EdgeInsets.symmetric(horizontal: 2, vertical: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 40,
                      child: Bone.text(width: 24, fontSize: 22),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Bone.text(width: 150, fontSize: 16),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Bone.text(width: 16, fontSize: 16),
                              SizedBox(width: 4),
                              Bone.text(width: 100, fontSize: 12),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Bone.text(width: 42, fontSize: 16),
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
