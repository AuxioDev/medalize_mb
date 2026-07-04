import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

final locationServiceProvider =
    Provider<LocationService>((_) => LocationService());

enum LocationFailure {
  /// Location services are off, timed out, or the plugin threw.
  unavailable,

  /// The user refused (or previously refused) the permission prompt.
  denied,
}

sealed class LocationResult {
  const LocationResult();
}

class LocationSuccess extends LocationResult {
  const LocationSuccess({required this.lat, required this.lng});
  final double lat;
  final double lng;
}

class LocationError extends LocationResult {
  const LocationError(this.failure);
  final LocationFailure failure;
}

/// Thin wrapper around permission_handler + geolocator so callers (and tests)
/// never touch the plugins directly. Every failure maps to a [LocationError]
/// instead of an exception: the caller must degrade gracefully (keep the
/// previous sort, suggest the city filter), never crash.
class LocationService {
  Future<LocationResult> getCurrentPosition() async {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        return const LocationError(LocationFailure.unavailable);
      }
      final status = await Permission.locationWhenInUse.request();
      if (!status.isGranted) {
        return const LocationError(LocationFailure.denied);
      }
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          // City-block accuracy is plenty for sorting doctors by distance and
          // resolves much faster than a full GPS fix.
          accuracy: LocationAccuracy.low,
          timeLimit: Duration(seconds: 10),
        ),
      );
      return LocationSuccess(lat: position.latitude, lng: position.longitude);
    } catch (_) {
      return const LocationError(LocationFailure.unavailable);
    }
  }
}
