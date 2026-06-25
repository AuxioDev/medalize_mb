import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medalize_mb/core/theme/app_motion.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';

/// 6-digit segmented OTP input.
/// Each box auto-advances focus on digit entry and handles backspace-to-previous.
/// Supports clipboard paste of a 6-digit code and SMS autofill.
class OtpCodeField extends StatefulWidget {
  const OtpCodeField({
    super.key,
    required this.onCompleted,
    this.onChanged,
    this.hasError = false,
  });

  final ValueChanged<String> onCompleted;
  final ValueChanged<String>? onChanged;
  final bool hasError;

  @override
  State<OtpCodeField> createState() => _OtpCodeFieldState();
}

class _OtpCodeFieldState extends State<OtpCodeField>
    with SingleTickerProviderStateMixin {
  static const _length = 6;
  final _controllers = List.generate(_length, (_) => TextEditingController());
  final _focusNodes = List.generate(_length, (_) => FocusNode());
  late final AnimationController _shakeCtrl;
  late final Animation<double> _shakeAnim;

  @override
  void initState() {
    super.initState();
    _shakeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _shakeAnim = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: -6), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -6, end: 6), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 6, end: -4), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -4, end: 4), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 4, end: 0), weight: 1),
    ]).animate(CurvedAnimation(parent: _shakeCtrl, curve: Curves.easeInOut));
  }

  @override
  void didUpdateWidget(OtpCodeField old) {
    super.didUpdateWidget(old);
    if (widget.hasError && !old.hasError) {
      _shakeCtrl.forward(from: 0);
      HapticFeedback.mediumImpact();
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    _shakeCtrl.dispose();
    super.dispose();
  }

  String get _value =>
      _controllers.map((c) => c.text).join();

  void _onChanged(int index, String value) {
    if (value.length > 1) {
      // Paste handling: distribute digits across boxes.
      final digits = value.replaceAll(RegExp(r'\D'), '');
      if (digits.isNotEmpty) {
        for (var i = 0; i < _length; i++) {
          _controllers[i].text = i < digits.length ? digits[i] : '';
        }
        final nextEmpty = digits.length < _length ? digits.length : _length - 1;
        _focusNodes[nextEmpty].requestFocus();
        setState(() {});
        final full = _value;
        widget.onChanged?.call(full);
        if (full.length == _length) widget.onCompleted(full);
      }
      return;
    }

    if (value.isNotEmpty && index < _length - 1) {
      _focusNodes[index + 1].requestFocus();
    }
    setState(() {});
    final full = _value;
    widget.onChanged?.call(full);
    if (full.length == _length) {
      HapticFeedback.lightImpact();
      widget.onCompleted(full);
    }
  }

  void _onKeyEvent(int index, KeyEvent event) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace &&
        _controllers[index].text.isEmpty &&
        index > 0) {
      _focusNodes[index - 1].requestFocus();
      _controllers[index - 1].clear();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shakeAnim,
      builder: (_, child) => Transform.translate(
        offset: Offset(_shakeAnim.value, 0),
        child: child,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(_length, (i) => _OtpBox(
          controller: _controllers[i],
          focusNode: _focusNodes[i],
          hasError: widget.hasError,
          onChanged: (v) => _onChanged(i, v),
          onKeyEvent: (e) => _onKeyEvent(i, e),
        )),
      ),
    );
  }
}

class _OtpBox extends StatefulWidget {
  const _OtpBox({
    required this.controller,
    required this.focusNode,
    required this.hasError,
    required this.onChanged,
    required this.onKeyEvent,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final bool hasError;
  final ValueChanged<String> onChanged;
  final ValueChanged<KeyEvent> onKeyEvent;

  @override
  State<_OtpBox> createState() => _OtpBoxState();
}

class _OtpBoxState extends State<_OtpBox> {
  bool _focused = false;
  late final FocusNode _keyListenerNode;
  late final VoidCallback _focusListener;

  @override
  void initState() {
    super.initState();
    _keyListenerNode = FocusNode(skipTraversal: true);
    _focusListener = () => setState(() => _focused = widget.focusNode.hasFocus);
    widget.focusNode.addListener(_focusListener);
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_focusListener);
    _keyListenerNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final filled = widget.controller.text.isNotEmpty;
    final borderColor = widget.hasError
        ? AppColors.error
        : _focused
            ? AppColors.primary
            : c.border;
    final borderWidth = (_focused || widget.hasError) ? 2.0 : 1.0;

    return AnimatedContainer(
      duration: AppDuration.fast,
      width: 44,
      height: 52,
      decoration: BoxDecoration(
        color: filled ? AppColors.primary.withValues(alpha: 0.06) : c.surfaceAlt,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor, width: borderWidth),
      ),
      child: KeyboardListener(
        focusNode: _keyListenerNode,
        onKeyEvent: widget.onKeyEvent,
        child: TextField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(1),
          ],
          autofillHints: const [AutofillHints.oneTimeCode],
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: c.textPrimary,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            filled: false,
            contentPadding: EdgeInsets.zero,
            counterText: '',
          ),
          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}
