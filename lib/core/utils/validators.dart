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

  // Unicode letters, spaces, hyphens, apostrophes — 2–150 chars
  static final _nameRe = RegExp(r"^[a-zA-ZÀ-ÖØ-öø-ÿ'\- ]{2,150}$");

  // Non-digit stripper for phone
  static final _nonDigit = RegExp(r'\D');

  // ── Form validators (return error string or null) ──────────────────────────

  static String? email(String? v) {
    if (v == null || v.trim().isEmpty) return 'Email is required';
    if (!_emailRe.hasMatch(v.trim())) return 'Enter a valid email address';
    return null;
  }

  static String? password(String? v) {
    if (v == null || v.isEmpty) return 'Password is required';
    if (v.length < 8) return 'At least 8 characters required';
    if (!v.contains(RegExp(r'[A-Za-z]'))) return 'Include at least one letter';
    if (!v.contains(RegExp(r'[0-9]'))) return 'Include at least one digit';
    return null;
  }

  static String? confirmPassword(String? v, String original) {
    if (v == null || v.isEmpty) return 'Please confirm your password';
    if (v != original) return 'Passwords do not match';
    return null;
  }

  static String? name(String? v, {String label = 'This field'}) {
    final s = v?.trim() ?? '';
    if (s.isEmpty) return '$label is required';
    if (s.length < 2) return '$label must be at least 2 characters';
    if (!_nameRe.hasMatch(s)) return '$label contains invalid characters';
    return null;
  }

  static String? phone(String? v) {
    if (v == null || v.trim().isEmpty) return 'Phone number is required';
    final digits = v.replaceAll(_nonDigit, '');
    if (digits.length < 7) return 'Number is too short';
    if (digits.length > 15) return 'Number is too long (E.164 max 15 digits)';
    return null;
  }

  // ── Live boolean helpers (for button enable/disable) ──────────────────────

  static bool emailOk(String v) => _emailRe.hasMatch(v.trim());
  static bool passwordOk(String v) => _passwordMinRe.hasMatch(v);
  static bool phoneOk(String v) {
    final d = v.replaceAll(_nonDigit, '');
    return d.isEmpty || (d.length >= 7 && d.length <= 15);
  }
}
