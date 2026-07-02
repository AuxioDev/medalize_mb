import 'package:medalize_mb/i18n/strings.g.dart';

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
    if (v == null || v.trim().isEmpty) return t.validation.emailRequired;
    if (!_emailRe.hasMatch(v.trim())) return t.validation.emailInvalid;
    return null;
  }

  static String? password(String? v) {
    if (v == null || v.isEmpty) return t.validation.passwordRequired;
    if (v.length < 8) return t.validation.passwordTooShort;
    if (!v.contains(RegExp(r'[A-Za-z]'))) return t.validation.passwordNeedsLetter;
    if (!v.contains(RegExp(r'[0-9]'))) return t.validation.passwordNeedsDigit;
    return null;
  }

  static String? confirmPassword(String? v, String original) {
    if (v == null || v.isEmpty) return t.validation.passwordConfirmRequired;
    if (v != original) return t.validation.passwordMismatch;
    return null;
  }

  static String? name(String? v, {required String label}) {
    final s = v?.trim() ?? '';
    if (s.isEmpty) return t.validation.fieldRequired(field: label);
    if (s.length < 2) return t.validation.nameMinLength;
    if (!_nameRe.hasMatch(s)) return t.validation.fieldInvalid(field: label);
    return null;
  }

  static String? phone(String? v) {
    if (v == null || v.trim().isEmpty) return t.validation.phoneRequired;
    final d = _digitCount(v);
    if (d < 7) return t.validation.phoneTooShort;
    // Local subscriber numbers vary widely across the supported countries (e.g.
    // China is 11 digits). Cap at 15 (E.164 max) rather than 9 so valid numbers
    // aren't rejected. The dial code is stored separately.
    if (d > 15) return t.validation.phoneTooLong;
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
    return d == 0 || (d >= 7 && d <= 15);
  }
}
