import 'package:flutter/material.dart';

/// Fades and slides [child] up into place as [animation] runs 0→1. Unlike
/// [AnimatedEntrance] (which owns its own per-widget `AnimationController` and
/// stagger delay), this takes an externally-driven [animation] — e.g. one
/// `Interval`-clipped segment of a single shared controller, for a
/// multi-section reveal where sections overlap on one timeline instead of
/// firing independently. Shared by the auth screens (login/register/forgot
/// and reset password) — previously four byte-identical private `_Section`
/// classes, each paired with its own screen-specific controller/interval
/// setup (which stays screen-specific; only this fade+slide recipe was
/// duplicated).
class FadeSlideTransition extends StatelessWidget {
  const FadeSlideTransition({
    super.key,
    required this.animation,
    required this.child,
  });

  final Animation<double> animation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.14),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      ),
    );
  }
}
