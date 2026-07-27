import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/network/dio_client.dart';

/// A single selectable city/district returned by `GET /locations/`.
class LocationOption {
  const LocationOption({
    required this.key,
    required this.type,
    required this.label,
    required this.lat,
    required this.lng,
    required this.regionKey,
    required this.regionLabel,
  });

  final String key;
  final String type; // 'city' or 'district'
  final String label;
  final double lat;
  final double lng;
  final String regionKey;
  final String regionLabel;

  factory LocationOption.fromJson(
    Map<String, dynamic> json, {
    required String regionKey,
    required String regionLabel,
  }) =>
      LocationOption(
        key: json['key'] as String,
        type: json['type'] as String,
        label: json['label'] as String,
        lat: (json['lat'] as num).toDouble(),
        lng: (json['lng'] as num).toDouble(),
        regionKey: regionKey,
        regionLabel: regionLabel,
      );
}

/// An economic region with its cities/districts, in the order the backend
/// already sorts them (region label, then city label — see
/// apps.core.i18n.locations_payload).
class LocationRegion {
  const LocationRegion({
    required this.key,
    required this.label,
    required this.cities,
  });

  final String key;
  final String label;
  final List<LocationOption> cities;

  factory LocationRegion.fromJson(Map<String, dynamic> json) {
    final key = json['key'] as String;
    final label = json['label'] as String;
    final cities = (json['cities'] as List<dynamic>)
        .map((c) => LocationOption.fromJson(
              c as Map<String, dynamic>,
              regionKey: key,
              regionLabel: label,
            ))
        .toList();
    return LocationRegion(key: key, label: label, cities: cities);
  }
}

final locationRepositoryProvider = Provider<LocationRepository>(
  (ref) => LocationRepository(ref.read(dioClientProvider)),
);

/// All Azerbaijan cities/districts grouped by economic region, localized to
/// the signed-in user's language by the backend.
final locationsProvider = FutureProvider<List<LocationRegion>>((ref) {
  return ref.watch(locationRepositoryProvider).fetchLocations();
});

class LocationRepository {
  LocationRepository(this._dio);
  final Dio _dio;

  Future<List<LocationRegion>> fetchLocations() async {
    try {
      final res = await _dio.get('/locations/');
      final list = res.data as List<dynamic>;
      return list
          .map((e) => LocationRegion.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }
}
