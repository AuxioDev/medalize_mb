import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medalize_mb/core/services/device_identity.dart';
import 'package:medalize_mb/core/storage/secure_storage.dart';

/// Matches an RFC 4122 version-4 UUID.
final _uuidV4 = RegExp(
  r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
);

void main() {
  setUp(() {
    // Installs an in-memory fake platform so SecureStorage (which wraps
    // FlutterSecureStorage) works under `flutter test` without a real device.
    FlutterSecureStorage.setMockInitialValues({});
  });

  group('generateUuidV4', () {
    test('produces well-formed, unique v4 UUIDs', () {
      final a = generateUuidV4();
      final b = generateUuidV4();
      expect(a, matches(_uuidV4));
      expect(b, matches(_uuidV4));
      expect(a, isNot(equals(b)));
    });
  });

  group('DeviceIdentity', () {
    test('getOrCreateId() generates a UUID once and persists it', () async {
      final identity = DeviceIdentity(
        SecureStorage(),
        nameResolver: () async => 'Test Device',
        platform: 'android',
      );

      final first = await identity.getOrCreateId();
      final second = await identity.getOrCreateId();

      expect(first, matches(_uuidV4));
      expect(second, first, reason: 'the id must not be regenerated');
    });

    test('a fresh DeviceIdentity reads back the same persisted id', () async {
      final storage = SecureStorage();
      final id = await DeviceIdentity(
        storage,
        nameResolver: () async => 'Test Device',
        platform: 'android',
      ).getOrCreateId();

      // A second instance (e.g. after an app restart) must see the same id —
      // it's backed by the same underlying secure storage.
      final again = await DeviceIdentity(
        storage,
        nameResolver: () async => 'Test Device',
        platform: 'android',
      ).getOrCreateId();

      expect(again, id);
    });

    test('device_id survives SecureStorage.clearAll() (logout)', () async {
      final storage = SecureStorage();
      final identity = DeviceIdentity(
        storage,
        nameResolver: () async => 'Test Device',
        platform: 'ios',
      );
      final id = await identity.getOrCreateId();

      await storage.saveTokens(
        accessToken: 'access',
        refreshToken: 'refresh',
        role: 'patient',
        userId: 'u1',
        email: 'x@test.com',
      );
      await storage.clearAll();

      // Session data is gone...
      expect(await storage.getAccessToken(), isNull);
      // ...but the device identity is device-level, not session-level, and
      // must survive logout so the backend keeps recognising this device.
      expect(await identity.getOrCreateId(), id);
    });

    test('describe() returns device_id/device_name/platform and caches them',
        () async {
      final storage = SecureStorage();
      final identity = DeviceIdentity(
        storage,
        nameResolver: () async => 'Pixel 9 (Android 15)',
        platform: 'android',
      );

      final map = await identity.describe();

      expect(map['device_id'], matches(_uuidV4));
      expect(map['device_name'], 'Pixel 9 (Android 15)');
      expect(map['platform'], 'android');
      // Cached so the auth interceptor can attach them to refresh calls
      // without re-invoking device_info_plus.
      expect(await storage.getDeviceName(), 'Pixel 9 (Android 15)');
      expect(await storage.getDevicePlatform(), 'android');
    });

    test('describe() falls back to the cached name if the resolver throws',
        () async {
      final storage = SecureStorage();
      await storage.saveDeviceName('Cached Name');

      final identity = DeviceIdentity(
        storage,
        nameResolver: () async => throw StateError('plugin unavailable'),
        platform: 'android',
      );

      final map = await identity.describe();
      expect(map['device_name'], 'Cached Name');
    });
  });
}
