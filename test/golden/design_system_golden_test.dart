import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/widgets/app_badge.dart';
import 'package:medalize_mb/core/widgets/app_card.dart';
import 'package:medalize_mb/core/widgets/app_chip.dart';
import 'package:medalize_mb/core/widgets/primary_button.dart';
import 'package:medalize_mb/core/widgets/status_chip.dart';
import 'package:medalize_mb/features/auth/presentation/widgets/password_strength_indicator.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

/// Regression baseline for the design system's visual tokens (color, radius,
/// spacing, type) as applied by a representative set of `core/widgets/` +
/// [PasswordStrengthIndicator]. Deliberately component-level, not
/// full-screen: full screens pull providers/network and are flaky here.
///
/// Passwords below are chosen to land on each [PasswordStrength] tier via
/// `evaluatePasswordStrength`'s scoring (length>=8, length>=12, lower, upper,
/// digit, symbol): "abc" -> 1 (weak), "abcdefgH" -> 3 (fair),
/// "abcdefgH1" -> 4 (good), "Abcdefgh12!" -> 5 (strong).
const _statuses = [
  'confirmed',
  'pending',
  'cancelled',
  'requires_rescheduling',
  'no_show',
  'completed',
];

const _passwords = ['abc', 'abcdefgH', 'abcdefgH1', 'Abcdefgh12!'];

class _DesignSystemShowcase extends StatelessWidget {
  const _DesignSystemShowcase();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final status in _statuses) StatusChip(status: status),
            ],
          ),
          const SizedBox(height: 16),
          const LoadingFilledButton(label: 'Continue', onPressed: null),
          const SizedBox(height: 8),
          const LoadingFilledButton(
            label: 'Continue',
            onPressed: null,
            loading: true,
          ),
          const SizedBox(height: 16),
          AppCard(
            child: Text('Card content', style: Theme.of(context).textTheme.bodyMedium),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              const AppBadge(label: 'Primary'),
              AppBadge(label: 'Warning', color: AppColors.warning),
              AppChip.filter(label: 'Filter', selected: true, onSelected: (_) {}),
              AppChip.filter(label: 'Filter', selected: false, onSelected: (_) {}),
              AppChip.choice(label: 'Choice', selected: true, onTap: () {}),
              AppChip.choice(label: 'Choice', selected: false, onTap: () {}),
            ],
          ),
          const SizedBox(height: 16),
          for (final password in _passwords)
            PasswordStrengthIndicator(password: password),
        ],
      ),
    );
  }
}

/// Builds [themeBuilder] inside its own error zone.
///
/// `AppTheme.light`/`.dark` call `GoogleFonts.inter()`, which — with runtime
/// fetching disabled below — kicks off a background font-load that's
/// expected to fail offline (no bundled/cached Inter ttf) and rejects an
/// internal, never-awaited `Future` (a google_fonts implementation detail).
/// Left alone, that surfaces as an unrelated "test failed after completion"
/// even though the widget already rendered correctly with the fallback
/// system font. Scoping constructing to its own zone catches only that
/// specific, known, harmless error without swallowing real ones or touching
/// the surrounding `pumpWidget`/golden-match flow.
ThemeData _buildThemeIgnoringOfflineFontFetch(ThemeData Function() themeBuilder) {
  late final ThemeData theme;
  runZonedGuarded(() => theme = themeBuilder(), (error, stack) {
    if (!error.toString().contains('allowRuntimeFetching')) {
      Zone.root.handleUncaughtError(error, stack);
    }
  });
  return theme;
}

Widget _host(ThemeData theme) {
  return TranslationProvider(
    child: MaterialApp(
      theme: theme,
      home: Scaffold(body: SizedBox(width: 360, child: const _DesignSystemShowcase())),
    ),
  );
}

void main() {
  setUpAll(() {
    // No network in this test environment (font-CDN requests hang rather
    // than fail fast) — render with the offline fallback font instead.
    // Goldens here assert layout/color/shape, not glyph rendering.
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  testWidgets('design system showcase — light', (tester) async {
    await tester.pumpWidget(_host(_buildThemeIgnoringOfflineFontFetch(() => AppTheme.light)));
    await tester.pump();
    await expectLater(
      find.byType(_DesignSystemShowcase),
      matchesGoldenFile('design_system_light.png'),
    );
  });

  testWidgets('design system showcase — dark', (tester) async {
    await tester.pumpWidget(_host(_buildThemeIgnoringOfflineFontFetch(() => AppTheme.dark)));
    await tester.pump();
    await expectLater(
      find.byType(_DesignSystemShowcase),
      matchesGoldenFile('design_system_dark.png'),
    );
  });
}
