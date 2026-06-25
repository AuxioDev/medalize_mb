import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medalize_mb/core/theme/app_motion.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';

/// Shared scaffold for all auth screens.
/// Provides the blue gradient background, centered white card, and
/// exposes an [animationController] so each screen can drive staggered
/// animations for its own content.
class AuthScaffold extends StatelessWidget {
  const AuthScaffold({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1E3A8A), Color(0xFF2563EB)],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: ConstrainedBox(
                // minHeight fills the visible area so Center works vertically
                constraints: BoxConstraints(minHeight: constraints.maxHeight - 48),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: _Card(child: child),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 48,
            spreadRadius: 0,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      padding: const EdgeInsets.all(28),
      child: child,
    );
  }
}

/// Centered header used at the top of every auth card.
class AuthCardHeader extends StatelessWidget {
  const AuthCardHeader({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.iconColor = const Color(0xFF2563EB),
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: iconColor, size: 28),
        ),
        const SizedBox(height: 16),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 22),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

/// Floating-label text field styled for the white card background.
/// Validates on focus-loss (blur) in addition to form submit.
class AuthCardField extends StatefulWidget {
  const AuthCardField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.keyboardType,
    this.textInputAction,
    this.autofillHints,
    this.obscureText = false,
    this.suffix,
    this.errorText,
    this.validator,
    this.onFieldSubmitted,
    this.inputFormatters,
  });

  final TextEditingController controller;
  final String label;
  final String? hint;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;
  final bool obscureText;
  final Widget? suffix;
  final String? errorText;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<AuthCardField> createState() => _AuthCardFieldState();
}

class _AuthCardFieldState extends State<AuthCardField> {
  final _fieldKey = GlobalKey<FormFieldState<String>>();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _fieldKey.currentState?.validate();
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: _fieldKey,
      controller: widget.controller,
      focusNode: _focusNode,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      autofillHints: widget.autofillHints,
      obscureText: widget.obscureText,
      onFieldSubmitted: widget.onFieldSubmitted,
      validator: widget.validator,
      inputFormatters: widget.inputFormatters,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hint,
        suffixIcon: widget.suffix,
        errorText: widget.errorText,
        fillColor: context.colors.surfaceAlt,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      ),
    );
  }
}

/// Visibility toggle icon for password fields — animated icon swap.
class VisibilityToggle extends StatelessWidget {
  const VisibilityToggle({super.key, required this.obscure, required this.onToggle});

  final bool obscure;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: AnimatedSwitcher(
        duration: AppDuration.fast,
        transitionBuilder: (child, anim) => FadeTransition(
          opacity: anim,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.7, end: 1.0).animate(anim),
            child: child,
          ),
        ),
        child: Icon(
          key: ValueKey(obscure),
          obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
          color: context.colors.textSecondary,
          size: 20,
        ),
      ),
      onPressed: onToggle,
    );
  }
}
