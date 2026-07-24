import 'dart:io';

import 'package:flutter/material.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/i18n/strings.g.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

/// "Continue with Google" / "Continue with Apple" buttons for the login
/// screen. Apple's button follows Apple's own guidelines via the
/// sign_in_with_apple package's widget, and is only shown on iOS — that's
/// where App Store guideline 4.8 requires it alongside any third-party login.
/// Google's button is a custom pill: google_sign_in 7.x ships no bundled
/// button widget, so this uses the brand's "G" glyph as a placeholder —
/// swap in the official multi-colour asset before a Play Store submission.
class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({
    super.key,
    required this.enabled,
    required this.onGoogleTap,
    required this.onAppleTap,
  });

  final bool enabled;
  final VoidCallback onGoogleTap;
  final VoidCallback onAppleTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _OrDivider(label: context.t.auth.orDivider),
        const SizedBox(height: 16),
        _GoogleButton(
          label: context.t.auth.continueWithGoogle,
          onPressed: enabled ? onGoogleTap : null,
        ),
        if (Platform.isIOS) ...[
          const SizedBox(height: 10),
          SignInWithAppleButton(
            onPressed: enabled ? onAppleTap : null,
            text: context.t.auth.continueWithApple,
            height: 48,
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
        ],
      ],
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    final color = context.colors.border;
    return Row(
      children: [
        Expanded(child: Divider(color: color)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(label,
              style: TextStyle(color: context.colors.textSecondary, fontSize: 13)),
        ),
        Expanded(child: Divider(color: color)),
      ],
    );
  }
}

class _GoogleButton extends StatelessWidget {
  const _GoogleButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: context.colors.border),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.md)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'G',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Color(0xFF4285F4),
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Text(label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: context.colors.textPrimary,
                      fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }
}
