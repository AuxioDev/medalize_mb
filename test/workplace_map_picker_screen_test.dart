import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/network/dio_client.dart';
import 'package:medalize_mb/core/services/location_service.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/features/doctor/presentation/screens/workplace_map_picker_screen.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

class _FakeLocationService extends LocationService {
  _FakeLocationService(this.result);
  final LocationResult result;

  @override
  Future<LocationResult> getCurrentPosition() async => result;
}

class _StubDio with DioMixin implements Dio {
  _StubDio({this.address});
  final String? address;
  final List<String> paths = [];

  @override
  Future<Response<T>> get<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    paths.add(path);
    return Response<T>(
      requestOptions: RequestOptions(path: path),
      statusCode: 200,
      data: {'address': address} as T,
    );
  }
}

PickedLocation? _result;

Future<void> _pump(
  WidgetTester tester, {
  required Dio dio,
  double? initialLat,
  double? initialLng,
  LocationService? locationService,
}) async {
  _result = null;
  late final GoRouter router;
  router = GoRouter(
    initialLocation: '/host',
    routes: [
      GoRoute(
        path: '/host',
        builder: (_, _) => Scaffold(
          body: TextButton(
            onPressed: () async {
              _result = await router.push<PickedLocation?>(
                '/pick',
                extra: {'lat': initialLat, 'lng': initialLng},
              );
            },
            child: const Text('open-picker'),
          ),
        ),
      ),
      GoRoute(
        path: '/pick',
        builder: (_, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return WorkplaceMapPickerScreen(
            initialLat: extra?['lat'] as double?,
            initialLng: extra?['lng'] as double?,
          );
        },
      ),
    ],
  );
  await tester.pumpWidget(
    TranslationProvider(
      child: ProviderScope(
        overrides: [
          dioClientProvider.overrideWithValue(dio),
          if (locationService != null)
            locationServiceProvider.overrideWithValue(locationService),
        ],
        child: MaterialApp.router(theme: AppTheme.light, routerConfig: router),
      ),
    ),
  );
  await tester.tap(find.text('open-picker'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('confirming returns the map center and the geocoded address',
      (tester) async {
    final dio = _StubDio(address: '123 Test St, Baku');
    await _pump(tester, dio: dio, initialLat: 40.1, initialLng: 49.1);

    expect(find.byType(WorkplaceMapPickerScreen), findsOneWidget);

    await tester.tap(find.text('Confirm Location'));
    await tester.pumpAndSettle();

    expect(find.byType(WorkplaceMapPickerScreen), findsNothing);
    expect(dio.paths, contains('/geocode/reverse/'));
    expect(_result, isNotNull);
    expect(_result!.lat, closeTo(40.1, 0.0001));
    expect(_result!.lng, closeTo(49.1, 0.0001));
    expect(_result!.address, '123 Test St, Baku');
  });

  testWidgets('confirming still returns coordinates when geocoding fails',
      (tester) async {
    final dio = _StubDio(address: null);
    await _pump(tester, dio: dio, initialLat: 38.75, initialLng: 48.85);

    await tester.tap(find.text('Confirm Location'));
    await tester.pumpAndSettle();

    expect(_result, isNotNull);
    expect(_result!.address, isNull);
    expect(_result!.lat, closeTo(38.75, 0.0001));
  });

  testWidgets('use-my-location moves the map to the device position',
      (tester) async {
    final dio = _StubDio(address: 'My Location St');
    await _pump(
      tester,
      dio: dio,
      locationService:
          _FakeLocationService(const LocationSuccess(lat: 41.0, lng: 47.0)),
    );

    await tester.tap(find.byTooltip('Use my location'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Confirm Location'));
    await tester.pumpAndSettle();

    expect(_result!.lat, closeTo(41.0, 0.0001));
    expect(_result!.lng, closeTo(47.0, 0.0001));
  });

  testWidgets('denied location permission shows a snackbar, does not crash',
      (tester) async {
    final dio = _StubDio(address: null);
    await _pump(
      tester,
      dio: dio,
      locationService: _FakeLocationService(
        const LocationError(LocationFailure.denied),
      ),
    );

    await tester.tap(find.byTooltip('Use my location'));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(
      find.text(
        "Location permission is needed to use your current position. You can still move the map manually.",
      ),
      findsOneWidget,
    );
  });
}
