import 'package:medalize_mb/core/constants/app_strings.dart';

abstract final class Validators {
  // RFC 5322 simplified: local-part @ domain.tld (tld >= 2 chars)
  static final _emailRe = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+"
    r'@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?'
    r'(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*'
    r'\.[a-zA-Z]{2,}$',
  );

  // Matches backend rule: 8+ chars, ≥1 letter, ≥1 digit
  static final _passwordMinRe = RegExp(r'^(?=.*[A-Za-z])(?=.*\d).{8,}$');

  // Unicode letters (basic + extended Latin), spaces, hyphens, apostrophes — 2–50 chars
  static final _nameRe = RegExp(r"^[a-zA-ZÀ-ÖØ-öø-ÿ' -]{2,50}$");

  // ── Helpers ────────────────────────────────────────────────────────────────

  // Count digits in a string using LINQ-style codeUnit filtering.
  static int _digitCount(String v) =>
      v.codeUnits.where((u) => u >= 48 && u <= 57).length;

  // ── Form validators (return error string or null) ──────────────────────────

  static String? email(String? v) {
    if (v == null || v.trim().isEmpty) return AppStrings.emailRequired;
    if (!_emailRe.hasMatch(v.trim())) return AppStrings.emailInvalid;
    return null;
  }

  static String? password(String? v) {
    if (v == null || v.isEmpty) return AppStrings.passwordRequired;
    if (v.length < 8) return AppStrings.passwordTooShort;
    if (!v.contains(RegExp(r'[A-Za-z]'))) return AppStrings.passwordNeedsLetter;
    if (!v.contains(RegExp(r'[0-9]'))) return AppStrings.passwordNeedsDigit;
    return null;
  }

  static String? confirmPassword(String? v, String original) {
    if (v == null || v.isEmpty) return AppStrings.passwordConfirmRequired;
    if (v != original) return AppStrings.passwordMismatch;
    return null;
  }

  static String? name(String? v, {String label = 'This field'}) {
    final s = v?.trim() ?? '';
    if (s.isEmpty) return '$label is required';
    if (s.length < 2) return AppStrings.nameMinLength;
    if (!_nameRe.hasMatch(s)) return '$label contains invalid characters';
    return null;
  }

  static String? phone(String? v) {
    if (v == null || v.trim().isEmpty) return AppStrings.phoneRequired;
    final d = _digitCount(v);
    if (d < 7) return AppStrings.phoneTooShort;
    if (d > 9) return AppStrings.phoneTooLong;
    return null;
  }

  // ── Live boolean helpers (for button enable/disable) ──────────────────────

  static bool emailOk(String v) => _emailRe.hasMatch(v.trim());
  static bool passwordOk(String v) => _passwordMinRe.hasMatch(v);

  static bool nameOk(String v) {
    final s = v.trim();
    return s.length >= 2 && _nameRe.hasMatch(s);
  }

  static bool phoneOk(String v) {
    final d = _digitCount(v);
    return d == 0 || (d >= 7 && d <= 9);
  }
}
