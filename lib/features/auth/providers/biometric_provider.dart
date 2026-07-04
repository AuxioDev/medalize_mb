import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medalize_mb/core/network/dio_client.dart';
import 'package:medalize_mb/core/security/biometric_service.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

/// Whether this device supports biometric authentication at all — drives
/// whether the toggle in Profile > Security is enabled or shown as
/// unavailable.
final biometricSupportedProvider = FutureProvider<bool>(
  (ref) => ref.read(biometricServiceProvider).isSupported(),
);

/// Whether the "unlock with biometrics" gate is enabled. Persisted in secure
/// storage (mirrors the `app_language` pattern) and preserved across logouts.
final biometricEnabledProvider =
    NotifierProvider<BiometricEnabledNotifier, bool>(
        BiometricEnabledNotifier.new);

class BiometricEnabledNotifier extends Notifier<bool> {
  @override
  bool build() {
    Future(_load);
    return false;
  }

  Future<void> _load() async {
    state =
        await ref.read(secureStorageProvider).getBiometricEnabled() ?? false;
  }

  /// Enables/disables the biometric gate. Enabling requires the device to
  /// support biometrics AND a successful authentication right now — otherwise
  /// the toggle stays off. Returns whether the change was applied.
  Future<bool> setEnabled(bool value) async {
    if (value) {
      final biometric = ref.read(biometricServiceProvider);
      if (!await biometric.isSupported()) return false;
      if (!await biometric.authenticate(t.security.biometricPrompt)) {
        return false;
      }
    }
    await ref.read(secureStorageProvider).saveBiometricEnabled(value);
    state = value;
    return true;
  }
}
