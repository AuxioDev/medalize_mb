import 'package:flutter/material.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';

/// Inline validation/submit-error message shown beneath a form, standardizing
/// the `bodyMedium` + [AppColors.error] look every form screen already
/// reaches for by hand.
class FormErrorText extends StatelessWidget {
  const FormErrorText(this.message, {super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.error),
    );
  }
}
