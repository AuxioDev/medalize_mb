import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:medalize_mb/core/theme/app_motion.dart';

/// Standard entrance animation (fade + subtle slide) used across the app.
///
/// Pass [index] for staggered list/grid items. Honors the OS "reduce motion"
/// accessibility setting by rendering the child immediately when animations are
/// disabled.
class AnimatedEntrance extends StatelessWidget {
  const AnimatedEntrance({
    super.key,
    required this.child,
    this.index = 0,
    this.slideY = 0.06,
    this.slideX = 0,
  });

  final Widget child;
  final int index;
  final double slideY;
  final double slideX;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.maybeOf(context)?.disableAnimations ?? false) {
      return child;
    }

    final steps = index.clamp(0, AppDuration.maxStaggerItems);
    final delay = AppDuration.stagger * steps;

    var anim = child.animate(delay: delay).fadeIn(
          duration: AppDuration.base,
          curve: AppCurve.enter,
        );
    if (slideY != 0) {
      anim = anim.slideY(
        begin: slideY,
        end: 0,
        duration: AppDuration.base,
        curve: AppCurve.enter,
      );
    }
    if (slideX != 0) {
      anim = anim.slideX(
        begin: slideX,
        end: 0,
        duration: AppDuration.base,
        curve: AppCurve.enter,
      );
    }
    return anim;
  }
}
