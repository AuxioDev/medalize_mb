import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:medalize_mb/core/network/dio_client.dart';
import 'package:medalize_mb/core/services/location_service.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/widgets/primary_button.dart';
import 'package:medalize_mb/features/shared/presentation/widgets/app_bar_title.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

/// Result of confirming a pin on [WorkplaceMapPickerScreen].
/// `address` is null when reverse geocoding failed — the caller must keep
/// whatever the doctor already typed, never clear it.
class PickedLocation {
  const PickedLocation({required this.lat, required this.lng, this.address});
  final double lat;
  final double lng;
  final String? address;
}

/// Lets a doctor pin their workplace's exact location on a map instead of
/// relying on the city centroid. The pin is fixed at the screen center and
/// the map pans underneath it (the same pattern as Google Maps/Uber pickup
/// pickers) — simpler and more reliable than drag-a-marker gestures.
class WorkplaceMapPickerScreen extends ConsumerStatefulWidget {
  const WorkplaceMapPickerScreen({super.key, this.initialLat, this.initialLng});

  final double? initialLat;
  final double? initialLng;

  @override
  ConsumerState<WorkplaceMapPickerScreen> createState() =>
      _WorkplaceMapPickerScreenState();
}

class _WorkplaceMapPickerScreenState
    extends ConsumerState<WorkplaceMapPickerScreen> {
  // Baku — used only when the form has no city/coordinates selected yet.
  static const _fallbackCenter = LatLng(40.4093, 49.8671);

  late final MapController _mapController;
  late LatLng _center;
  bool _locating = false;
  bool _confirming = false;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _center = widget.initialLat != null && widget.initialLng != null
        ? LatLng(widget.initialLat!, widget.initialLng!)
        : _fallbackCenter;
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  Future<void> _useMyLocation() async {
    setState(() => _locating = true);
    final result = await ref.read(locationServiceProvider).getCurrentPosition();
    if (!mounted) return;
    setState(() => _locating = false);
    switch (result) {
      case LocationSuccess(:final lat, :final lng):
        final target = LatLng(lat, lng);
        setState(() => _center = target);
        _mapController.move(target, 16);
      case LocationError(:final failure):
        final message = failure == LocationFailure.denied
            ? context.t.addWorkplace.locationPermissionDenied
            : context.t.addWorkplace.locationUnavailable;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(message)));
    }
  }

  Future<void> _confirm() async {
    setState(() => _confirming = true);
    // The map camera's lat/lng carry far more precision than a double can
    // cleanly hold (e.g. 40.40930000000004 from pan/zoom arithmetic) — the
    // backend's DecimalField(max_digits=9, decimal_places=6) rejects that
    // with a 400. Round to 6 decimal places (~11 cm) before it ever leaves
    // this screen, so both the geocode lookup and the saved point agree.
    final center = _mapController.camera.center;
    final lat = double.parse(center.latitude.toStringAsFixed(6));
    final lng = double.parse(center.longitude.toStringAsFixed(6));
    String? address;
    try {
      final res = await ref
          .read(dioClientProvider)
          .get('/geocode/reverse/', queryParameters: {'lat': lat, 'lng': lng});
      address = res.data['address'] as String?;
    } catch (_) {
      // Reverse geocoding is best-effort — the doctor keeps typing the
      // address by hand when it fails, the pin is still saved either way.
      address = null;
    }
    if (!mounted) return;
    context.pop(PickedLocation(lat: lat, lng: lng, address: address));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: AppBarTitle(context.t.addWorkplace.mapPickerTitle,
              icon: Icons.map_outlined)),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _center,
              initialZoom: 15,
              onPositionChanged: (camera, hasGesture) =>
                  setState(() => _center = camera.center),
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png',
                subdomains: const ['a', 'b', 'c', 'd'],
                userAgentPackageName: 'az.medalize.app',
              ),
              const RichAttributionWidget(attributions: [
                TextSourceAttribution('OpenStreetMap contributors'),
                TextSourceAttribution('CARTO'),
              ]),
            ],
          ),
          const IgnorePointer(
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 34),
                child: Icon(Icons.location_pin,
                    size: 44, color: AppColors.primary),
              ),
            ),
          ),
          Positioned(
            right: 16,
            bottom: 16,
            child: FloatingActionButton.small(
              heroTag: 'workplace-map-my-location',
              tooltip: context.t.addWorkplace.useMyLocation,
              onPressed: _locating ? null : _useMyLocation,
              child: _locating
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.my_location),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomActionBar(
        child: LoadingFilledButton(
          label: context.t.addWorkplace.confirmLocation,
          loading: _confirming,
          onPressed: _confirm,
        ),
      ),
    );
  }
}
