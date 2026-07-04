import 'dart:io';
import 'dart:math';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medalize_mb/core/network/dio_client.dart';
import 'package:medalize_mb/core/storage/secure_storage.dart';

final deviceIdentityProvider = Provider<DeviceIdentity>(
  (ref) => DeviceIdentity(ref.read(secureStorageProvider)),
);

/// Identifies this installation to the backend: a stable UUID (generated once,
/// survives logout — see [SecureStorage.clearAll]), a human-readable device
/// name and the platform. Sent with login / social-login / token-refresh so
/// the server can maintain the "active sessions" device list.
class DeviceIdentity {
  DeviceIdentity(
    this._storage, {
    Future<String> Function()? nameResolver,
    String? platform,
  })  : _resolveName = nameResolver ?? _deviceInfoName,
        _platform = platform ?? (Platform.isIOS ? 'ios' : 'android');

  final SecureStorage _storage;
  final Future<String> Function() _resolveName;
  final String _platform;

  Future<String> getOrCreateId() async {
    final existing = await _storage.getDeviceId();
    if (existing != null && existing.isNotEmpty) return existing;
    final id = generateUuidV4();
    await _storage.saveDeviceId(id);
    return id;
  }

  /// Returns `{device_id, device_name, platform}` ready to merge into a
  /// request body. Name/platform are re-resolved and cached in secure storage
  /// so the auth interceptor can attach them to refreshes without a plugin
  /// call.
  Future<Map<String, String>> describe() async {
    final id = await getOrCreateId();
    String name;
    try {
      name = await _resolveName();
    } catch (_) {
      // device_info_plus failure must never block login.
      name = await _storage.getDeviceName() ?? 'Unknown device';
    }
    await _storage.saveDeviceName(name);
    await _storage.saveDevicePlatform(_platform);
    return {
      'device_id': id,
      'device_name': name,
      'platform': _platform,
    };
  }

  static Future<String> _deviceInfoName() async {
    final plugin = DeviceInfoPlugin();
    if (Platform.isIOS) {
      final info = await plugin.iosInfo;
      // e.g. "iPhone 15 Pro (iOS 18.1)" — modelName is the marketing name.
      return '${info.modelName} (iOS ${info.systemVersion})';
    }
    final info = await plugin.androidInfo;
    return '${info.manufacturer} ${info.model} (Android ${info.version.release})';
  }
}

/// RFC 4122 version-4 UUID from a cryptographically secure RNG. Kept local to
/// avoid pulling in a package for a single function.
String generateUuidV4({Random? random}) {
  final rng = random ?? Random.secure();
  final bytes = List<int>.generate(16, (_) => rng.nextInt(256));
  bytes[6] = (bytes[6] & 0x0f) | 0x40; // version 4
  bytes[8] = (bytes[8] & 0x3f) | 0x80; // variant 10xx
  final hex =
      bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  return '${hex.substring(0, 8)}-${hex.substring(8, 12)}-'
      '${hex.substring(12, 16)}-${hex.substring(16, 20)}-${hex.substring(20)}';
}
