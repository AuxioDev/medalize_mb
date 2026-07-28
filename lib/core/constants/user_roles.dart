/// Account role strings — the wire format stays a plain `String` throughout
/// the app (matches `User.role` on the backend), but call sites should use
/// these constants instead of repeating string literals so a typo shows up
/// as a compile error instead of a silent no-match.
abstract final class UserRole {
  static const patient = 'patient';
  static const doctor = 'doctor';
  static const hospital = 'hospital';
}
