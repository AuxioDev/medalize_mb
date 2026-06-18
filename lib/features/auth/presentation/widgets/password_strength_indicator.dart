import 'package:flutter/material.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';

enum PasswordStrength { empty, weak, fair, good, strong }

PasswordStrength evaluatePasswordStrength(String password) {
  if (password.isEmpty) return PasswordStrength.empty;

  var score = 0;
  if (password.length >= 8) score++;
  if (password.length >= 12) score++;
  if (password.contains(RegExp(r'[a-z]'))) score++;
  if (password.contains(RegExp(r'[A-Z]'))) score++;
  if (password.contains(RegExp(r'[0-9]'))) score++;
  if (password.contains(RegExp(r'[!@#$%^&*()\-_=+\[\]{};:,.<>?/\\|`~]'))) {
    score++;
  }

  return switch (score) {
    <= 2 => PasswordStrength.weak,
    3 => PasswordStrength.fair,
    4 => PasswordStrength.good,
    _ => PasswordStrength.strong,
  };
}

class PasswordStrengthIndicator extends StatelessWidget {
  const PasswordStrengthIndicator({super.key, required this.password});

  final String password;

  @override
  Widget build(BuildContext context) {
    final strength = evaluatePasswordStrength(password);
    if (strength == PasswordStrength.empty) return const SizedBox.shrink();

    final (color, label, value) = _attrs(strength);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpacing.xs),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: value),
            duration: const Duration(milliseconds: 300),
            builder: (_, v, _) => LinearProgressIndicator(
              value: v,
              minHeight: 4,
              backgroundColor: AppColors.border,
              valueColor: AlwaysStoppedAnimation(color),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'Strength: $label',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: color,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
        ),
      ],
    );
  }
}

(Color, String, double) _attrs(PasswordStrength s) => switch (s) {
      PasswordStrength.weak => (AppColors.strengthWeak, 'Weak', 0.25),
      PasswordStrength.fair => (const Color(0xFFF97316), 'Fair', 0.5),
      PasswordStrength.good => (const Color(0xFF84CC16), 'Good', 0.75),
      PasswordStrength.strong => (AppColors.strengthStrong, 'Strong', 1.0),
      PasswordStrength.empty => (AppColors.border, '', 0.0),
    };
