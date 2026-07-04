import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medalize_mb/core/security/biometric_service.dart';
import 'package:medalize_mb/features/auth/providers/biometric_provider.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

/// Stands in for BiometricService so tests control hardware support and
/// prompt outcome without touching the real local_auth plugin.
class _FakeBiometricService extends BiometricService {
  _FakeBiometricService({required this.supported, required this.authResult});

  final bool supported;
  final bool authResult;

  @override
  Future<bool> isSupported() async => supported;

  @override
  Future<bool> authenticate(String reason) async => authResult;
}

/// Reads the notifier and waits out its `Future(_load)` bootstrap (mirrors
/// AuthNotifier's own cold-start pattern) so tests don't race the initial
/// read of the persisted value.
Future<BiometricEnabledNotifier> _readSettled(ProviderContainer container) async {
  container.read(biometricEnabledProvider);
  await Future<void>.delayed(Duration.zero);
  return container.read(biometricEnabledProvider.notifier);
}

void main() {
  // t.security.biometricPrompt is read by setEnabled(true); slang needs a
  // locale loaded before that getter works.
  setUpAll(() => LocaleSettings.setLocale(AppLocale.en));

  setUp(() {
    FlutterSecureStorage.setMockInitialValues({});
  });

  test('starts disabled when nothing is persisted', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    await _readSettled(container);
    expect(container.read(biometricEnabledProvider), isFalse);
  });

  test('setEnabled(true) turns the gate on when biometrics pass', () async {
    final container = ProviderContainer(overrides: [
      biometricServiceProvider.overrideWithValue(
        _FakeBiometricService(supported: true, authResult: true),
      ),
    ]);
    addTearDown(container.dispose);
    final notifier = await _readSettled(container);

    final applied = await notifier.setEnabled(true);

    expect(applied, isTrue);
    expect(container.read(biometricEnabledProvider), isTrue);
  });

  test('setEnabled(true) is refused when the device has no usable biometrics',
      () async {
    final container = ProviderContainer(overrides: [
      biometricServiceProvider.overrideWithValue(
        _FakeBiometricService(supported: false, authResult: true),
      ),
    ]);
    addTearDown(container.dispose);
    final notifier = await _readSettled(container);

    final applied = await notifier.setEnabled(true);

    expect(applied, isFalse);
    expect(container.read(biometricEnabledProvider), isFalse);
  });

  test('setEnabled(true) is refused when the live biometric check fails',
      () async {
    final container = ProviderContainer(overrides: [
      biometricServiceProvider.overrideWithValue(
        _FakeBiometricService(supported: true, authResult: false),
      ),
    ]);
    addTearDown(container.dispose);
    final notifier = await _readSettled(container);

    final applied = await notifier.setEnabled(true);

    expect(applied, isFalse);
    expect(container.read(biometricEnabledProvider), isFalse);
  });

  test('setEnabled(false) always succeeds without checking biometrics',
      () async {
    final container = ProviderContainer(overrides: [
      biometricServiceProvider.overrideWithValue(
        _FakeBiometricService(supported: false, authResult: false),
      ),
    ]);
    addTearDown(container.dispose);
    final notifier = await _readSettled(container);

    final applied = await notifier.setEnabled(false);

    expect(applied, isTrue);
    expect(container.read(biometricEnabledProvider), isFalse);
  });

  test('the toggle persists across a fresh provider container (app restart)',
      () async {
    final container1 = ProviderContainer(overrides: [
      biometricServiceProvider.overrideWithValue(
        _FakeBiometricService(supported: true, authResult: true),
      ),
    ]);
    final notifier1 = await _readSettled(container1);
    await notifier1.setEnabled(true);
    container1.dispose();

    final container2 = ProviderContainer();
    addTearDown(container2.dispose);
    await _readSettled(container2);

    expect(container2.read(biometricEnabledProvider), isTrue);
  });
}
