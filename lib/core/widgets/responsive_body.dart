import 'package:flutter/material.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';

/// Centers content and caps its width on large screens (tablets, landscape,
/// desktop) so layouts don't stretch edge-to-edge. On phones it's a no-op
/// passthrough since the screen is narrower than [maxWidth].
class ResponsiveBody extends StatelessWidget {
  const ResponsiveBody({
    super.key,
    required this.child,
    this.maxWidth = AppSpacing.contentMaxWidth,
  });

  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }

  /// Picks a sensible column count for a grid given the available [width].
  static int columnsFor(double width, {double minTileWidth = 180}) {
    return (width / minTileWidth).floor().clamp(2, 4);
  }
}
