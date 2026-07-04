import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';

final biometricServiceProvider =
    Provider<BiometricService>((_) => BiometricService());

/// Thin wrapper around local_auth so callers (and tests) never touch the
/// plugin directly. All failures — including "biometrics unavailable" — map
/// to `false`: the caller must fall back to the regular login screen, never
/// silently skip the check.
class BiometricService {
  BiometricService({LocalAuthentication? auth})
      : _auth = auth ?? LocalAuthentication();

  final LocalAuthentication _auth;

  Future<bool> isSupported() async {
    try {
      return await _auth.isDeviceSupported();
    } catch (_) {
      return false;
    }
  }

  Future<bool> authenticate(String reason) async {
    try {
      return await _auth.authenticate(
        localizedReason: reason,
        // Retry automatically if the OS interrupts the prompt by
        // backgrounding the app mid-authentication.
        persistAcrossBackgrounding: true,
      );
    } catch (_) {
      // LocalAuthException (not enrolled, locked out, no hardware…) — fail
      // closed rather than crash.
      return false;
    }
  }
}
