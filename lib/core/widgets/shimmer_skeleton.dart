import 'package:flutter/material.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerSkeleton extends StatelessWidget {
  const ShimmerSkeleton({
    super.key,
    this.height = 72,
    this.width = double.infinity,
    this.radius = 14,
    this.margin = const EdgeInsets.only(bottom: 10),
  });

  final double height;
  final double width;
  final double radius;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // Shimmer reads best when the highlight is lighter than the base.
    final base = isDark ? c.surfaceAlt : c.border;
    final highlight = isDark ? c.border : c.surfaceAlt;

    return Padding(
      padding: margin,
      child: Shimmer.fromColors(
        baseColor: base,
        highlightColor: highlight,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: base,
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
      ),
    );
  }
}
