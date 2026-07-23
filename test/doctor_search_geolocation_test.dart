import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/services/location_service.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/features/doctors/data/models/doctor_model.dart';
import 'package:medalize_mb/features/doctors/data/repository/doctor_repository.dart';
import 'package:medalize_mb/features/doctors/providers/doctor_provider.dart';
import 'package:medalize_mb/features/patient/data/repository/favorites_repository.dart';
import 'package:medalize_mb/features/patient/presentation/screens/doctor_search_screen.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

/// Stands in for LocationService so tests decide the permission outcome
/// without touching the geolocator/permission_handler plugins.
class _FakeLocationService extends LocationService {
  _FakeLocationService(this.result);
  final LocationResult result;

  @override
  Future<LocationResult> getCurrentPosition() async => result;
}

/// Favorites bootstrap must not hit the network in widget tests.
class _OfflineFavoritesRepository extends FavoritesRepository {
  _OfflineFavoritesRepository() : super(Dio());

  @override
  Future<List<DoctorModel>> getFavorites() async =>
      throw const NetworkException();
}

class _FakeDoctorRepository extends DoctorRepository {
  _FakeDoctorRepository(this._doctors) : super(Dio());
  final List<DoctorModel> _doctors;

  @override
  Future<DoctorSearchPage> searchDoctors({
    String? name,
    String? specialization,
    String? city,
    int? minRating,
    String? ordering,
    double? lat,
    double? lng,
    int page = 1,
  }) async =>
      DoctorSearchPage(doctors: _doctors, hasMore: false);
}

const _doctor = DoctorModel(
  id: 'doc-1',
  firstName: 'Aysel',
  lastName: 'Mammadova',
  specialization: 'cardiology',
  specializationDisplay: 'Cardiology',
  slotDurationMin: 30,
);

Widget _app(LocationResult locationResult) => TranslationProvider(
      child: ProviderScope(
        overrides: [
          locationServiceProvider
              .overrideWithValue(_FakeLocationService(locationResult)),
          favoritesRepositoryProvider
              .overrideWithValue(_OfflineFavoritesRepository()),
          doctorRepositoryProvider
              .overrideWithValue(_FakeDoctorRepository(const [_doctor])),
          nextAvailableDateProvider.overrideWith((ref, id) async => null),
        ],
        child: MediaQuery(
          data: const MediaQueryData(disableAnimations: true),
          child: MaterialApp(
            theme: AppTheme.light,
            home: const DoctorSearchScreen(),
          ),
        ),
      ),
    );

Future<void> _selectDistanceSort(WidgetTester tester) async {
  await tester.tap(find.text('Relevance'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Nearest to me').last);
  await tester.pumpAndSettle();
}

void main() {
  setUp(() {
    FlutterSecureStorage.setMockInitialValues({});
  });

  Future<void> pumpApp(WidgetTester tester, LocationResult result) async {
    // The filter header (search + city + chips) needs a phone-height surface;
    // the default 800x600 test window overflows vertically.
    tester.view.physicalSize = const Size(480, 960);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(_app(result));
    await tester.pumpAndSettle();
  }

  testWidgets(
      'denied location keeps the previous sort and explains instead of crashing',
      (tester) async {
    await pumpApp(tester, const LocationError(LocationFailure.denied));

    await _selectDistanceSort(tester);

    expect(tester.takeException(), isNull);
    expect(
      find.textContaining('Location permission is needed'),
      findsOneWidget,
    );
    // Sort selection rolled back — the dropdown still shows Relevance.
    expect(find.text('Relevance'), findsOneWidget);
    expect(find.text('Dr. Aysel Mammadova'), findsOneWidget);
  });

  testWidgets('unavailable location services show their own message',
      (tester) async {
    await pumpApp(tester, const LocationError(LocationFailure.unavailable));

    await _selectDistanceSort(tester);

    expect(tester.takeException(), isNull);
    expect(
      find.textContaining("Couldn't get your location"),
      findsOneWidget,
    );
    expect(find.text('Relevance'), findsOneWidget);
  });

  testWidgets('granted location applies the distance sort', (tester) async {
    await pumpApp(tester, const LocationSuccess(lat: 40.4, lng: 49.87));

    await _selectDistanceSort(tester);

    expect(tester.takeException(), isNull);
    expect(find.text('Nearest to me'), findsOneWidget);
    expect(find.text('Relevance'), findsNothing);
  });
}
