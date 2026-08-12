import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/core/utils/validators.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

/// Azerbaijan-only phone input: the app serves a single market (see
/// apps.users.phone.normalize_az_phone on the backend, which validates
/// against region 'AZ' and rejects everything else), so there is no country
/// picker — just a fixed `+994` prefix and a 9-digit local-number field.
/// [controller] holds only the 9 local digits; callers prefix `+994`
/// themselves when building the E.164 value to send to the backend (see
/// RegisterRequest/LoginRequest).
class PhoneField extends StatefulWidget {
  const PhoneField({
    super.key,
    required this.controller,
    this.textInputAction,
    this.onFieldSubmitted,
    this.label,
    this.hint = '50 123 45 67',
    this.autofillHints,
    this.errorText,
  });

  final TextEditingController controller;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;

  /// Defaults to the localized "Phone Number" label when null.
  final String? label;
  final String? hint;
  final Iterable<String>? autofillHints;

  /// External (e.g. backend "phone already registered") error, shown
  /// instead of the client-side validator's message when set — same
  /// override convention as AuthCardField.errorText.
  final String? errorText;

  @override
  State<PhoneField> createState() => _PhoneFieldState();
}

class _PhoneFieldState extends State<PhoneField> {
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode()..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: (_) => Validators.phone(widget.controller.text),
      builder: (state) {
        final c = context.colors;
        final focused = _focusNode.hasFocus;
        final effectiveErrorText = widget.errorText ?? state.errorText;
        final hasError = effectiveErrorText != null;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.label ?? context.t.phoneField.label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: c.textPrimary,
                  ),
            ),
            const SizedBox(height: 4),
            AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              decoration: BoxDecoration(
                color: c.surfaceAlt,
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(
                  color: hasError
                      ? AppColors.error
                      : focused
                          ? AppColors.primary
                          : c.border,
                  width: focused || hasError ? 2 : 1,
                ),
              ),
              child: Row(
                children: [
                  // ── Fixed +994 prefix ──────────────────────────────
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 13),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('🇦🇿', style: TextStyle(fontSize: 20)),
                        const SizedBox(width: 6),
                        Text(
                          '+994',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: c.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // ── Divider ───────────────────────────────────────
                  Container(
                    width: 1,
                    height: 24,
                    color: c.border,
                  ),
                  // ── Number input ──────────────────────────────────
                  Expanded(
                    child: TextField(
                      controller: widget.controller,
                      focusNode: _focusNode,
                      keyboardType: TextInputType.phone,
                      textInputAction: widget.textInputAction,
                      onSubmitted: widget.onFieldSubmitted,
                      autofillHints: widget.autofillHints,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(9),
                      ],
                      style: TextStyle(
                        fontSize: 15,
                        color: c.textPrimary,
                      ),
                      decoration: InputDecoration(
                        hintText: widget.hint,
                        hintStyle: TextStyle(color: c.textSecondary),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 13),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (hasError)
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 4),
                child: Text(
                  effectiveErrorText,
                  style: Theme.of(context).inputDecorationTheme.errorStyle ??
                      const TextStyle(
                          fontSize: 12, color: AppColors.error),
                ),
              ),
          ],
        );
      },
    );
  }
}
