import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';

/// FilledButton with press-scale, spring-release, haptic feedback, an
/// animated loading state, and optional long-press. The Material ink ripple
/// is suppressed so only the scale animation provides tactile feedback.
class AnimatedButton extends StatefulWidget {
  const AnimatedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.onLongPress,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final VoidCallback? onLongPress;

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    // Negative lower bound lets the spring overshoot slightly above 1.0.
    _ctrl = AnimationController(
      vsync: this,
      lowerBound: -0.4,
      upperBound: 1.0,
      value: 0.0,
    );
    _scale = _ctrl.drive(Tween<double>(begin: 1.0, end: 0.96));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  bool get _enabled => !widget.isLoading && widget.onPressed != null;

  void _onPointerDown(PointerDownEvent _) {
    if (!_enabled) return;
    HapticFeedback.lightImpact();
    _ctrl.animateTo(
      1.0,
      duration: const Duration(milliseconds: 90),
      curve: Curves.easeIn,
    );
  }

  void _onPointerUp(PointerUpEvent _) => _springRelease();
  void _onPointerCancel(PointerCancelEvent _) => _springRelease();

  void _springRelease() {
    _ctrl.animateWith(SpringSimulation(
      const SpringDescription(mass: 0.5, stiffness: 300, damping: 15),
      _ctrl.value,
      0.0,
      -8.0,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: _onPointerDown,
      onPointerUp: _onPointerUp,
      onPointerCancel: _onPointerCancel,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 180),
        opacity: (widget.isLoading || _enabled) ? 1.0 : 0.5,
        child: ScaleTransition(
          scale: _scale,
          child: FilledButton(
            onPressed: _enabled ? widget.onPressed : null,
            onLongPress: widget.onLongPress != null
                ? () {
                    HapticFeedback.mediumImpact();
                    widget.onLongPress!();
                  }
                : null,
            style: FilledButton.styleFrom(
              splashFactory: NoSplash.splashFactory,
              overlayColor: Colors.transparent,
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 220),
              transitionBuilder: (child, anim) => FadeTransition(
                opacity: anim,
                child: ScaleTransition(
                  scale: Tween<double>(begin: 0.75, end: 1.0).animate(anim),
                  child: child,
                ),
              ),
              child: widget.isLoading
                  ? const SizedBox(
                      key: ValueKey('loading'),
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      key: const ValueKey('label'),
                      widget.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
