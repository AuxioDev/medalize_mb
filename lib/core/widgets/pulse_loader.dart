import 'package:flutter/material.dart';

/// Animated ECG-style trace used as the app's loading indicator, mirroring
/// the pulse mark used for the launcher icon and the web loader.
class PulseLoader extends StatefulWidget {
  const PulseLoader({
    super.key,
    this.width = 120,
    this.height = 40,
    this.color = Colors.white70,
  });

  final double width;
  final double height;
  final Color color;

  @override
  State<PulseLoader> createState() => _PulseLoaderState();
}

class _PulseLoaderState extends State<PulseLoader> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  var _initialized = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 2400));
  }

  // MediaQuery.maybeOf needs an inherited-widget lookup, which Flutter
  // disallows during a State's first build (initState) — didChangeDependencies
  // is the earliest safe place, guarded so it only runs setup once.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialized) return;
    _initialized = true;

    final reducedMotion = MediaQuery.maybeOf(context)?.disableAnimations ?? false;
    if (reducedMotion) {
      // Parks on the "hold" plateau (see _PulsePainter) so the full trace
      // stays drawn instead of animating through the draw/retreat cycle.
      _controller.value = 0.5;
    } else {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) =>
            CustomPaint(painter: _PulsePainter(progress: _controller.value, color: widget.color)),
      ),
    );
  }
}

class _PulsePainter extends CustomPainter {
  _PulsePainter({required this.progress, required this.color});

  final double progress;
  final Color color;

  // Normalized (0-1) points tracing the same waveform as the launcher icon
  // and the web PulseTrace: flat, a small beat, the sharp QRS spike, flat.
  static const List<Offset> _points = [
    Offset(0.0, 0.50),
    Offset(0.22, 0.50),
    Offset(0.30, 0.30),
    Offset(0.375, 0.50),
    Offset(0.47, 0.50),
    Offset(0.55, 0.80),
    Offset(0.64, 0.10),
    Offset(0.725, 0.83),
    Offset(0.80, 0.50),
    Offset(1.0, 0.50),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    for (var i = 0; i < _points.length; i++) {
      final p = Offset(_points[i].dx * size.width, _points[i].dy * size.height);
      if (i == 0) {
        path.moveTo(p.dx, p.dy);
      } else {
        path.lineTo(p.dx, p.dy);
      }
    }

    final dimPaint = Paint()
      ..color = color.withValues(alpha: color.a * 0.22)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(path, dimPaint);

    final metric = path.computeMetrics().firstOrNull;
    if (metric == null) return;
    final length = metric.length;

    // Draw-in, hold, then retreat — same timing as the web sweep animation
    // (0-46% draw, 46-58% hold at full length, 58-100% retreat) so both
    // platforms read as the same motion.
    double start;
    double end;
    if (progress < 0.46) {
      start = 0;
      end = length * (progress / 0.46);
    } else if (progress < 0.58) {
      start = 0;
      end = length;
    } else {
      start = length * ((progress - 0.58) / 0.42);
      end = length;
    }

    final tracePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(metric.extractPath(start, end), tracePaint);
  }

  @override
  bool shouldRepaint(covariant _PulsePainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.color != color;
}
