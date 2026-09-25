import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../theme/app_theme.dart';

/// A list of shimmering placeholder cards, shown instead of a plain
/// spinner while the very first network request is in flight. Gives
/// the loading state some visual polish instead of a blank screen.
class SkeletonLoader extends StatelessWidget {
  final int itemCount;

  const SkeletonLoader({super.key, this.itemCount = 6});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFE9EAF2),
      highlightColor: const Color(0xFFF6F7FB),
      period: const Duration(milliseconds: 1400),
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
        itemCount: itemCount,
        separatorBuilder: (_, __) => const SizedBox(height: 14),
        itemBuilder: (_, __) => Container(
          height: 108,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppTheme.cardBorder),
          ),
        ),
      ),
    );
  }
}
