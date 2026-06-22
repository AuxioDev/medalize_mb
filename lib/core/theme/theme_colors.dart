import 'package:flutter/material.dart';

/// Semantic neutral + accent colors that flip between light and dark themes.
///
/// Brand colors (primary blue, status colors, gradients) live in [AppColors]
/// and stay constant across brightnesses. Anything that must change with the
/// theme (surfaces, text, borders, tinted accents) belongs here and is read via
/// `context.colors`.
@immutable
class ThemeColors extends ThemeExtension<ThemeColors> {
  const ThemeColors({
    required this.background,
    required this.surface,
    required this.surfaceAlt,
    required this.textPrimary,
    required this.textSecondary,
    required this.border,
    required this.primarySurface,
    required this.primaryText,
    required this.shadow,
  });

  /// Page / scaffold background.
  final Color background;

  /// Elevated surfaces: app bars, sheets, the white auth card.
  final Color surface;

  /// Card fill (was `cardBg`).
  final Color surfaceAlt;

  final Color textPrimary;
  final Color textSecondary;
  final Color border;

  /// Pale primary-tinted fill behind accent icons / badges (was `primaryLight`).
  final Color primarySurface;

  /// Accent foreground (icons, small labels) that stays legible on neutral and
  /// [primarySurface] backgrounds in both themes.
  final Color primaryText;

  final Color shadow;

  static const light = ThemeColors(
    background: Color(0xFFF1F5F9),
    surface: Colors.white,
    surfaceAlt: Color(0xFFF8FAFC),
    textPrimary: Color(0xFF0F172A),
    textSecondary: Color(0xFF64748B),
    border: Color(0xFFE2E8F0),
    primarySurface: Color(0xFFEFF6FF),
    primaryText: Color(0xFF2563EB),
    shadow: Color(0x14000000),
  );

  static const dark = ThemeColors(
    background: Color(0xFF0B1120),
    surface: Color(0xFF111827),
    surfaceAlt: Color(0xFF1B2536),
    textPrimary: Color(0xFFF1F5F9),
    textSecondary: Color(0xFF94A3B8),
    border: Color(0xFF2A3850),
    primarySurface: Color(0xFF1E2A4A),
    primaryText: Color(0xFF60A5FA),
    shadow: Color(0x66000000),
  );

  @override
  ThemeColors copyWith({
    Color? background,
    Color? surface,
    Color? surfaceAlt,
    Color? textPrimary,
    Color? textSecondary,
    Color? border,
    Color? primarySurface,
    Color? primaryText,
    Color? shadow,
  }) {
    return ThemeColors(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceAlt: surfaceAlt ?? this.surfaceAlt,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      border: border ?? this.border,
      primarySurface: primarySurface ?? this.primarySurface,
      primaryText: primaryText ?? this.primaryText,
      shadow: shadow ?? this.shadow,
    );
  }

  @override
  ThemeColors lerp(ThemeColors? other, double t) {
    if (other is! ThemeColors) return this;
    return ThemeColors(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceAlt: Color.lerp(surfaceAlt, other.surfaceAlt, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      border: Color.lerp(border, other.border, t)!,
      primarySurface: Color.lerp(primarySurface, other.primarySurface, t)!,
      primaryText: Color.lerp(primaryText, other.primaryText, t)!,
      shadow: Color.lerp(shadow, other.shadow, t)!,
    );
  }
}

extension AppColorsX on BuildContext {
  /// Theme-aware neutral + accent colors. Usage: `context.colors.surface`.
  ThemeColors get colors => Theme.of(this).extension<ThemeColors>()!;
}
