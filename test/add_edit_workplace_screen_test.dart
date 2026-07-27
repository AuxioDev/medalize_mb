import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/network/dio_client.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/widgets/location_picker_field.dart';
import 'package:medalize_mb/features/doctor/presentation/screens/add_edit_workplace_screen.dart';
import 'package:medalize_mb/features/doctor/presentation/screens/workplace_map_picker_screen.dart';
import 'package:medalize_mb/features/locations/data/repository/location_repository.dart';
import 'package:medalize_mb/i18n/strings.g.dart';
import 'package:dio/dio.dart';

const _fakeRegions = <LocationRegion>[
  LocationRegion(key: 'baku', label: 'Baku', cities: [
    LocationOption(
      key: 'baku', type: 'city', label: 'Baku',
      lat: 40.4093, lng: 49.8671, regionKey: 'baku', regionLabel: 'Baku',
    ),
  ]),
  LocationRegion(key: 'ganja_dashkasan', label: 'Ganja-Dashkasan', cities: [
    LocationOption(
      key: 'ganja', type: 'city', label: 'Ganja',
      lat: 40.6828, lng: 46.3606, regionKey: 'ganja_dashkasan', regionLabel: 'Ganja-Dashkasan',
    ),
  ]),
];

Widget _wrap(Widget child, {List<Override> overrides = const []}) {
  return TranslationProvider(
    child: ProviderScope(
      overrides: [
        locationsProvider.overrideWith((ref) async => _fakeRegions),
        ...overrides,
      ],
      child: MaterialApp(theme: AppTheme.light, home: child),
    ),
  );
}

/// Like [_wrap] but with a real GoRouter so `context.push` to the map
/// picker route works — only needed by tests that tap "Pick on Map".
Widget _wrapWithRouter(Widget child, {List<Override> overrides = const []}) {
  final router = GoRouter(
    initialLocation: '/host',
    routes: [
      GoRoute(path: '/host', builder: (_, _) => child),
      GoRoute(
        path: '/doctor/pick-workplace-location',
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
  return TranslationProvider(
    child: ProviderScope(
      overrides: [
        locationsProvider.overrideWith((ref) async => _fakeRegions),
        ...overrides,
      ],
      child: MaterialApp.router(theme: AppTheme.light, routerConfig: router),
    ),
  );
}

class _RecordingDio with DioMixin implements Dio {
  final List<String> methods = [];
  Map<String, dynamic>? lastData;

  @override
  Future<Response<T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    methods.add('POST $path');
    lastData = data as Map<String, dynamic>?;
    return Response<T>(
      requestOptions: RequestOptions(path: path),
      statusCode: 201,
      data: {'id': 'new-id'} as T,
    );
  }

  @override
  Future<Response<T>> patch<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    methods.add('PATCH $path');
    lastData = data as Map<String, dynamic>?;
    return Response<T>(
      requestOptions: RequestOptions(path: path),
      statusCode: 200,
      data: {} as T,
    );
  }
}

void main() {
  testWidgets('create mode defaults to Mon-Fri 09:00-17:00 active',
      (tester) async {
    await tester.pumpWidget(_wrap(const AddEditWorkplaceScreen()));
    await tester.pump();

    final switches = tester.widgetList<Switch>(find.byType(Switch)).toList();
    expect(switches, hasLength(7));
    // Mon(0)..Fri(4) active, Sat(5)/Sun(6) off.
    for (var i = 0; i < 5; i++) {
      expect(switches[i].value, isTrue, reason: 'day $i should default active');
    }
    for (var i = 5; i < 7; i++) {
      expect(switches[i].value, isFalse, reason: 'day $i should default off');
    }
  });

  testWidgets('edit mode reflects the passed-in working_hours', (tester) async {
    final existing = <String, dynamic>{
      'id': 'w1',
      'name': 'City Clinic',
      'address': '12 Main St',
      'city': 'Baku',
      'type': 'clinic',
      'is_primary': true,
      'working_hours': [
        {
          'weekday': 1,
          'start_time': '10:00:00',
          'end_time': '12:00:00',
          'is_active': true,
        },
      ],
    };

    await tester.pumpWidget(_wrap(AddEditWorkplaceScreen(existing: existing)));
    await tester.pump();

    final switches = tester.widgetList<Switch>(find.byType(Switch)).toList();
    expect(switches, hasLength(7));
    // Only Tuesday (index 1) came back active; every other day falls back to
    // the inactive default since the map didn't include a row for them.
    for (var i = 0; i < 7; i++) {
      expect(switches[i].value, i == 1, reason: 'day $i active state');
    }
  });

  testWidgets('create flow sends working_hours in the POST body',
      (tester) async {
    final dio = _RecordingDio();
    await tester.pumpWidget(_wrap(
      const AddEditWorkplaceScreen(),
      overrides: [dioClientProvider.overrideWithValue(dio)],
    ));
    await tester.pump();

    await tester.enterText(find.byType(TextFormField).at(0), 'Test Clinic');
    await tester.enterText(find.byType(TextFormField).at(1), '1 Main St');

    await tester.tap(find.byType(LocationPickerField));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Baku').last);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Add Workplace').last);
    await tester.pump();

    expect(dio.methods, ['POST /doctor/workplaces/']);
    expect(dio.lastData?['city'], 'baku');
    // The map picker was never opened — must not send coordinates at all,
    // so the backend falls back to the city centroid (see WorkplaceSerializer).
    expect(dio.lastData?.containsKey('latitude'), isFalse);
    expect(dio.lastData?.containsKey('longitude'), isFalse);
    expect(dio.lastData?['working_hours'], hasLength(7));
    final monday = (dio.lastData?['working_hours'] as List).first as Map;
    expect(monday['is_active'], isTrue);
    expect(monday['start_time'], '09:00:00');
    expect(monday['end_time'], '17:00:00');
  });

  testWidgets(
      'opening the map with no pin yet centers on the selected city, not a hardcoded default',
      (tester) async {
    await tester.pumpWidget(_wrapWithRouter(const AddEditWorkplaceScreen()));
    await tester.pump();

    await tester.tap(find.byType(LocationPickerField));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ListTile, 'Ganja'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Pick on Map'));
    await tester.pumpAndSettle();

    final picker =
        tester.widget<WorkplaceMapPickerScreen>(find.byType(WorkplaceMapPickerScreen));
    expect(picker.initialLat, 40.6828);
    expect(picker.initialLng, 46.3606);
  });

  testWidgets('opening the map for an existing workplace centers on its saved point',
      (tester) async {
    final existing = <String, dynamic>{
      'id': 'w1',
      'name': 'City Clinic',
      'address': '12 Main St',
      'city': 'baku',
      'city_display': 'Baku',
      'type': 'clinic',
      'is_primary': true,
      'latitude': '38.750000',
      'longitude': '48.850000',
    };
    await tester.pumpWidget(
      _wrapWithRouter(AddEditWorkplaceScreen(existing: existing)),
    );
    await tester.pump();

    await tester.tap(find.text('Pick on Map'));
    await tester.pumpAndSettle();

    final picker =
        tester.widget<WorkplaceMapPickerScreen>(find.byType(WorkplaceMapPickerScreen));
    // The workplace's own saved point, not Ganja/Baku's city centroid.
    expect(picker.initialLat, 38.75);
    expect(picker.initialLng, 48.85);
  });
}
