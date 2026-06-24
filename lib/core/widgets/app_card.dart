import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';

class AppCard extends StatefulWidget {
  const AppCard({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.padding = const EdgeInsets.all(16),
    this.margin = const EdgeInsets.only(bottom: 10),
  });

  final Widget child;
  final VoidCallback? onTap;

  /// Optional long-press action. When provided, holding the card fires a
  /// medium haptic pulse and calls this callback.
  final VoidCallback? onLongPress;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  @override
  State<AppCard> createState() => _AppCardState();
}

class _AppCardState extends State<AppCard> with SingleTickerProviderStateMixin {
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
    _scale = _ctrl.drive(Tween<double>(begin: 1.0, end: 0.97));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  bool get _interactive => widget.onTap != null || widget.onLongPress != null;

  void _onTapDown(TapDownDetails _) {
    if (!_interactive) return;
    _ctrl.animateTo(
      1.0,
      duration: const Duration(milliseconds: 80),
      curve: Curves.easeIn,
    );
  }

  void _onTapUp(TapUpDetails _) {
    if (!_interactive) return;
    _springRelease();
    widget.onTap?.call();
  }

  void _onTapCancel() {
    _springRelease();
  }

  void _onLongPress() {
    HapticFeedback.mediumImpact();
    _springRelease();
    widget.onLongPress?.call();
  }

  void _springRelease() {
    _ctrl.animateWith(SpringSimulation(
      const SpringDescription(mass: 0.5, stiffness: 280, damping: 14),
      _ctrl.value,
      0.0,
      -6.0,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Padding(
      padding: widget.margin,
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        onLongPress: widget.onLongPress != null ? _onLongPress : null,
        child: ScaleTransition(
          scale: _scale,
          child: Container(
            decoration: BoxDecoration(
              color: c.surfaceAlt,
              borderRadius: BorderRadius.circular(AppRadius.lg),
              border: Border.all(color: c.border, width: 1),
            ),
            padding: widget.padding,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
