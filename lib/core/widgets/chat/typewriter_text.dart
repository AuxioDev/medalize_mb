import 'package:flutter/material.dart';

/// Reveals [text] progressively, character by character, like a typewriter —
/// for a freshly-arrived AI reply, so it reads as being composed live rather
/// than dropped in all at once.
///
/// Animates once per mount. Give the surrounding widget a stable `key` (e.g.
/// the message id) so a parent rebuild — a new message arriving, a list
/// scroll — reuses this element instead of remounting it and restarting the
/// reveal. Honors the OS "reduce motion" setting by showing the full text
/// immediately.
class TypewriterText extends StatefulWidget {
  const TypewriterText({super.key, required this.text, this.style});

  final String text;
  final TextStyle? style;

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText>
    with SingleTickerProviderStateMixin {
  // Constant per-character pace, capped so a long reply still finishes in a
  // reasonable time instead of taking many seconds to reveal.
  static const _perChar = Duration(milliseconds: 18);
  static const _maxDuration = Duration(milliseconds: 2500);

  AnimationController? _ctrl;
  Animation<int>? _charCount;
  var _initialized = false;

  // MediaQuery.maybeOf needs an inherited-widget lookup, which Flutter
  // disallows during a State's first build (initState) — didChangeDependencies
  // is the earliest safe place, guarded so it only runs setup once.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialized) return;
    _initialized = true;

    final reducedMotion = MediaQuery.maybeOf(context)?.disableAnimations ?? false;
    if (reducedMotion || widget.text.isEmpty) return;

    final fullDuration = _perChar * widget.text.length;
    final duration = fullDuration > _maxDuration ? _maxDuration : fullDuration;
    final ctrl = AnimationController(vsync: this, duration: duration);
    _ctrl = ctrl;
    _charCount = IntTween(begin: 0, end: widget.text.length).animate(ctrl);
    ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final charCount = _charCount;
    if (charCount == null) return Text(widget.text, style: widget.style);
    return AnimatedBuilder(
      animation: charCount,
      builder: (context, _) =>
          Text(widget.text.substring(0, charCount.value), style: widget.style),
    );
  }
}
