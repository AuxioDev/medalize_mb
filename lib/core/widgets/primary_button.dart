import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';

/// Full-width filled button with press-scale, spring-release, haptic feedback,
/// and an optional hold-to-confirm mode. When [loading] is true the button is
/// disabled and shows a spinner. When [onLongPress] is provided, holding the
/// button sweeps a progress arc around it; on completion it fires the callback
/// with a medium haptic pulse.
class LoadingFilledButton extends StatefulWidget {
  const LoadingFilledButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.loading = false,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.onLongPress,
    this.holdDuration = const Duration(milliseconds: 700),
  });

  final String label;
  final VoidCallback? onPressed;
  final bool loading;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final VoidCallback? onLongPress;
  final Duration holdDuration;

  @override
  State<LoadingFilledButton> createState() => _LoadingFilledButtonState();
}

class _LoadingFilledButtonState extends State<LoadingFilledButton>
    with TickerProviderStateMixin {
  late final AnimationController _pressCtrl;
  late final Animation<double> _scale;
  AnimationController? _holdCtrl;

  @override
  void initState() {
    super.initState();
    _pressCtrl = AnimationController(
      vsync: this,
      // Negative lower bound lets the spring overshoot past 1.0 scale.
      lowerBound: -0.4,
      upperBound: 1.0,
      value: 0.0,
    );
    _scale = _pressCtrl.drive(Tween<double>(begin: 1.0, end: 0.96));

    if (widget.onLongPress != null) {
      _holdCtrl = AnimationController(vsync: this, duration: widget.holdDuration)
        ..addStatusListener(_onHoldStatus);
    }
  }

  @override
  void didUpdateWidget(LoadingFilledButton old) {
    super.didUpdateWidget(old);
    if (old.onLongPress == null && widget.onLongPress != null) {
      _holdCtrl ??= AnimationController(vsync: this, duration: widget.holdDuration)
        ..addStatusListener(_onHoldStatus);
    }
  }

  @override
  void dispose() {
    _pressCtrl.dispose();
    _holdCtrl?.dispose();
    super.dispose();
  }

  bool get _enabled => !widget.loading && widget.onPressed != null;

  void _onHoldStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      HapticFeedback.mediumImpact();
      widget.onLongPress?.call();
      _holdCtrl?.reset();
    }
  }

  void _onPointerDown(PointerDownEvent _) {
    if (!_enabled) return;
    HapticFeedback.lightImpact();
    _pressCtrl.animateTo(
      1.0,
      duration: const Duration(milliseconds: 90),
      curve: Curves.easeIn,
    );
    _holdCtrl?.forward();
  }

  void _onPointerUp(PointerUpEvent _) {
    _springRelease();
    if (_holdCtrl?.isAnimating == true) _holdCtrl?.reverse();
  }

  void _onPointerCancel(PointerCancelEvent _) {
    _springRelease();
    _holdCtrl?.reverse();
  }

  void _springRelease() {
    _pressCtrl.animateWith(SpringSimulation(
      const SpringDescription(mass: 0.5, stiffness: 300, damping: 15),
      _pressCtrl.value,
      0.0,
      -8.0,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final fg = widget.foregroundColor ?? Colors.white;

    final style = FilledButton.styleFrom(
      backgroundColor: widget.backgroundColor,
      foregroundColor: fg,
      splashFactory: NoSplash.splashFactory,
      overlayColor: Colors.transparent,
    );

    final content = widget.loading
        ? SizedBox(
            height: 22,
            width: 22,
            child: CircularProgressIndicator(strokeWidth: 2.4, color: fg),
          )
        : (widget.icon == null
            ? Text(widget.label)
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(widget.icon, size: 20),
                  const SizedBox(width: 8),
                  Text(widget.label),
                ],
              ));

    Widget button = FilledButton(
      onPressed: _enabled ? widget.onPressed : null,
      style: style,
      child: content,
    );

    if (_holdCtrl != null) {
      button = AnimatedBuilder(
        animation: _holdCtrl!,
        builder: (context, child) => CustomPaint(
          foregroundPainter: _HoldProgressPainter(
            progress: _holdCtrl!.value,
            color: fg,
          ),
          child: child,
        ),
        child: button,
      );
    }

    return Listener(
      onPointerDown: _onPointerDown,
      onPointerUp: _onPointerUp,
      onPointerCancel: _onPointerCancel,
      child: ScaleTransition(
        scale: _scale,
        child: button,
      ),
    );
  }
}

class _HoldProgressPainter extends CustomPainter {
  const _HoldProgressPainter({required this.progress, required this.color});

  final double progress;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0) return;
    final paint = Paint()
      ..color = color.withValues(alpha: 0.75)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    // Follow the exact outline of the pill-shaped button.
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(1.25, 1.25, size.width - 2.5, size.height - 2.5),
      Radius.circular((size.height - 2.5) / 2),
    );
    final path = Path()..addRRect(rrect);
    final metrics = path.computeMetrics().first;
    final partial = metrics.extractPath(0, metrics.length * progress);
    canvas.drawPath(partial, paint);
  }

  @override
  bool shouldRepaint(_HoldProgressPainter old) => old.progress != progress;
}

/// Pinned bottom action area: a SafeArea-padded bar with a top divider and the
/// surface background, suited to a primary call-to-action.
class BottomActionBar extends StatelessWidget {
  const BottomActionBar({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      decoration: BoxDecoration(
        color: c.surface,
        border: Border(top: BorderSide(color: c.border)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
              AppSpacing.md, AppSpacing.sm + 2, AppSpacing.md, AppSpacing.md),
          child: child,
        ),
      ),
    );
  }
}
