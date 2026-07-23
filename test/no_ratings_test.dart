import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/features/assistant/data/models/assistant_models.dart';
import 'package:medalize_mb/features/assistant/presentation/widgets/suggested_doctor_card.dart';
import 'package:medalize_mb/features/doctors/data/models/doctor_model.dart';
import 'package:medalize_mb/features/doctors/data/repository/doctor_repository.dart';
import 'package:medalize_mb/features/doctors/providers/doctor_provider.dart';
import 'package:medalize_mb/features/patient/data/repository/favorites_repository.dart';
import 'package:medalize_mb/features/patient/presentation/screens/doctor_detail_screen.dart';
import 'package:medalize_mb/features/patient/presentation/screens/doctor_search_screen.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

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

const _unratedDoctor = DoctorModel(
  id: 'doc-1',
  firstName: 'Aysel',
  lastName: 'Mammadova',
  specialization: 'cardiology',
  specializationDisplay: 'Cardiology',
  slotDurationMin: 30,
);

void main() {
  setUp(() {
    FlutterSecureStorage.setMockInitialValues({});
  });

  testWidgets('doctor search card shows "No ratings yet" when unrated',
      (tester) async {
    tester.view.physicalSize = const Size(480, 960);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      TranslationProvider(
        child: ProviderScope(
          overrides: [
            favoritesRepositoryProvider
                .overrideWithValue(_OfflineFavoritesRepository()),
            doctorRepositoryProvider
                .overrideWithValue(_FakeDoctorRepository(const [_unratedDoctor])),
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
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('Dr. Aysel Mammadova'), findsOneWidget);
    expect(find.text('No ratings yet'), findsOneWidget);
  });

  testWidgets('doctor detail header shows "No ratings yet" when unrated',
      (tester) async {
    tester.view.physicalSize = const Size(480, 960);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    const detail = DoctorDetailModel(
      id: 'doc-1',
      firstName: 'Aysel',
      lastName: 'Mammadova',
      specialization: 'cardiology',
      specializationDisplay: 'Cardiology',
      slotDurationMin: 30,
      bio: '',
      workplaces: [],
    );

    await tester.pumpWidget(
      TranslationProvider(
        child: ProviderScope(
          overrides: [
            doctorDetailProvider.overrideWith((ref, id) async => detail),
            myWaitlistProvider.overrideWith((ref) async => []),
            favoritesRepositoryProvider
                .overrideWithValue(_OfflineFavoritesRepository()),
          ],
          child: MediaQuery(
            data: const MediaQueryData(disableAnimations: true),
            child: MaterialApp(
              theme: AppTheme.light,
              home: const DoctorDetailScreen(doctorId: 'doc-1'),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('No ratings yet'), findsOneWidget);
  });

  testWidgets('suggested doctor card shows "No ratings yet" when unrated',
      (tester) async {
    const doctor = SuggestedDoctor(
      id: 'doc-1',
      firstName: 'Aysel',
      lastName: 'Mammadova',
      specializationDisplay: 'Cardiology',
      city: 'Baku',
    );

    await tester.pumpWidget(
      TranslationProvider(
        child: MaterialApp(
          theme: AppTheme.light,
          home: const Scaffold(
            body: SuggestedDoctorCard(doctor: doctor),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('No ratings yet'), findsOneWidget);
    // Rated doctors keep the numeric badge instead.
    const rated = SuggestedDoctor(
      id: 'doc-2',
      firstName: 'Leyla',
      lastName: 'Aliyeva',
      specializationDisplay: 'Cardiology',
      averageRating: 4.6,
      city: 'Baku',
    );
    await tester.pumpWidget(
      TranslationProvider(
        child: MaterialApp(
          theme: AppTheme.light,
          home: const Scaffold(
            body: SuggestedDoctorCard(doctor: rated),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('No ratings yet'), findsNothing);
    expect(find.text('4.6'), findsOneWidget);
  });
}
