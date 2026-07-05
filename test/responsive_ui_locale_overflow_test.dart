// Phase-2 responsive-UI regression net: renders the riskiest screens under
// all six supported locales (en/az/fr/ru/tr/zh) on a phone-sized viewport and
// fails if Flutter reports a layout error (RenderFlex overflow etc.) in any
// of them. Catches translated-text-length regressions in CI without manually
// checking six languages by hand.
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/network/dio_client.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/features/appointments/data/models/appointment_model.dart';
import 'package:medalize_mb/features/appointments/providers/appointment_provider.dart';
import 'package:medalize_mb/features/assistant/data/models/assistant_models.dart';
import 'package:medalize_mb/features/assistant/presentation/widgets/suggested_doctor_card.dart';
import 'package:medalize_mb/features/auth/data/models/user_device_model.dart';
import 'package:medalize_mb/features/auth/data/repository/auth_repository.dart';
import 'package:medalize_mb/features/doctor/data/models/doctor_stats_model.dart';
import 'package:medalize_mb/features/doctor/presentation/screens/doctor_appointments_screen.dart';
import 'package:medalize_mb/features/doctor/presentation/screens/doctor_home_screen.dart';
import 'package:medalize_mb/features/doctor/presentation/screens/working_hours_editor_screen.dart';
import 'package:medalize_mb/features/doctors/data/models/doctor_model.dart';
import 'package:medalize_mb/features/doctors/providers/doctor_provider.dart';
import 'package:medalize_mb/features/notifications/data/models/notification_model.dart';
import 'package:medalize_mb/features/notifications/providers/notification_provider.dart';
import 'package:medalize_mb/features/patient/data/models/waitlist_model.dart';
import 'package:medalize_mb/features/patient/data/repository/favorites_repository.dart';
import 'package:medalize_mb/features/patient/presentation/screens/booking_confirm_screen.dart';
import 'package:medalize_mb/features/patient/presentation/screens/doctor_detail_screen.dart';
import 'package:medalize_mb/features/patient/presentation/screens/doctor_search_screen.dart';
import 'package:medalize_mb/features/patient/presentation/screens/my_appointments_screen.dart';
import 'package:medalize_mb/features/patient/presentation/screens/patient_home_screen.dart';
import 'package:medalize_mb/features/shared/presentation/screens/active_sessions_screen.dart';
import 'package:medalize_mb/features/shared/presentation/screens/security_screen.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

import 'support/locale_overflow_harness.dart';

// ---------------------------------------------------------------------------
// Fakes (mirroring the ones in the per-screen test files).
// ---------------------------------------------------------------------------

/// Favorites bootstrap must not hit the network in widget tests
/// (same as test/no_ratings_test.dart / test/doctor_search_geolocation_test.dart).
class _OfflineFavoritesRepository extends FavoritesRepository {
  _OfflineFavoritesRepository() : super(Dio());

  @override
  Future<List<DoctorModel>> getFavorites() async =>
      throw const NetworkException();
}

/// Stands in for AuthRepository's network calls (same as
/// test/security_screen_test.dart / test/active_sessions_screen_test.dart).
class _FakeAuthRepository extends AuthRepository {
  _FakeAuthRepository({this.devices = const []}) : super(Dio());

  final List<UserDeviceModel> devices;

  @override
  Future<List<UserDeviceModel>> getDevices() async => devices;

  @override
  Future<void> deactivateAccount({required String password}) async {}
}

/// Serves the working-hours GET without a live backend so the editor renders
/// all seven day rows (day name + switch + time buttons competing for width).
class _FakeWorkingHoursDio with DioMixin implements Dio {
  @override
  Future<Response<T>> get<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    final hours = List.generate(
      7,
      (i) => <String, dynamic>{
        'weekday': i,
        'is_active': true,
        'start_time': '09:00:00',
        'end_time': '17:30:00',
      },
    );
    return Response<T>(
      requestOptions: RequestOptions(path: path),
      statusCode: 200,
      data: hours as T,
    );
  }
}

// ---------------------------------------------------------------------------
// Test data — deliberately long names so chips/badges and their neighbours
// genuinely compete for horizontal space.
// ---------------------------------------------------------------------------

AppointmentModel _appointment({
  required String id,
  required String status,
  String reason = '',
}) {
  final start = DateTime.now().add(const Duration(days: 3));
  return AppointmentModel(
    id: id,
    doctor: const AppointmentDoctor(
      id: 'doc-1',
      firstName: 'Aleksandr',
      lastName: 'Konstantinopolsky',
      specialization: 'cardiology',
      specializationDisplay: 'Cardiology and Cardiovascular Surgery',
    ),
    patient: const AppointmentPatient(
      id: 'pat-1',
      firstName: 'Aleksandra',
      lastName: 'Konstantinopolskaya',
    ),
    workplace: const AppointmentWorkplace(
      id: 'w1',
      name: 'Central Diagnostic and Rehabilitation Medical Centre',
      address: '128 Nizami Street',
      city: 'Baku',
    ),
    startsAt: start,
    endsAt: start.add(const Duration(minutes: 30)),
    status: status,
    reason: reason,
    notes: '',
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
  );
}

const _doctorDetail = DoctorDetailModel(
  id: 'doc-1',
  firstName: 'Aleksandr',
  lastName: 'Konstantinopolsky',
  specialization: 'cardiology',
  specializationDisplay: 'Cardiology and Cardiovascular Surgery',
  slotDurationMin: 30,
  consultationFee: '150.00',
  averageRating: 4.8,
  reviewCount: 127,
  primaryWorkplaceName: 'Central Diagnostic and Rehabilitation Medical Centre',
  primaryWorkplaceCity: 'Baku',
  bio: 'Experienced cardiologist focusing on preventive care.',
  workplaces: [
    DoctorWorkplace(
      id: 'w1',
      name: 'Central Diagnostic and Rehabilitation Medical Centre',
      city: 'Baku',
      address: '128 Nizami Street, Sabail district',
      type: 'clinic',
      isPrimary: true,
    ),
  ],
);

DoctorModel _searchDoctor() => DoctorModel(
      id: 'doc-1',
      firstName: 'Aleksandr',
      lastName: 'Konstantinopolsky',
      specialization: 'cardiology',
      specializationDisplay: 'Cardiology and Cardiovascular Surgery',
      slotDurationMin: 30,
      consultationFee: '150.00',
      averageRating: 4.8,
      reviewCount: 127,
      primaryWorkplaceName:
          'Central Diagnostic and Rehabilitation Medical Centre',
      primaryWorkplaceCity: 'Baku',
      primaryWorkplaceId: 'w1',
      nextSlotAt: DateTime.now().add(const Duration(days: 2)),
      distanceKm: 2.4,
    );

// ---------------------------------------------------------------------------
// Shared pump plumbing.
// ---------------------------------------------------------------------------

/// iPhone-14-class logical viewport — narrow enough to stress long
/// translations, matching what most real devices give the layout.
void _usePhoneViewport(WidgetTester tester) {
  tester.view.physicalSize = const Size(390, 844);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
}

/// Standard app wrapper used by the per-screen widget tests. Animations are
/// disabled so infinitely repeating effects (EmptyState float, entrance
/// staggers) don't hang `pumpAndSettle`.
Widget _wrap(Widget screen, {List<Override> overrides = const []}) {
  return TranslationProvider(
    child: ProviderScope(
      overrides: overrides,
      child: MediaQuery(
        data: const MediaQueryData(disableAnimations: true),
        child: MaterialApp(theme: AppTheme.light, home: screen),
      ),
    ),
  );
}

/// Overrides shared by the two home screens (auth stays unauthenticated via
/// the empty secure-storage mock; notifications resolve without the periodic
/// refresh timer).
List<Override> _homeOverrides() => [
      notificationsProvider
          .overrideWith((ref) async => const <NotificationModel>[]),
    ];

void main() {
  // The non-base locales live in deferred libraries; load them on the real
  // event loop once so the harness can switch locales synchronously inside
  // the FakeAsync test zone.
  setUpAll(loadAllLocalesForTest);

  setUp(() {
    FlutterSecureStorage.setMockInitialValues({});
  });

  testWidgets('PatientHomeScreen fits all six locales', (tester) async {
    _usePhoneViewport(tester);
    await expectNoOverflowAcrossLocales(
      tester,
      () => _wrap(
        const PatientHomeScreen(),
        overrides: [
          ..._homeOverrides(),
          patientAppointmentsProvider.overrideWith((ref, status) async => [
                _appointment(id: 'a1', status: 'requires_rescheduling'),
                _appointment(id: 'a2', status: 'confirmed'),
                _appointment(id: 'a3', status: 'pending'),
              ]),
          myWaitlistProvider.overrideWith((ref) async => [
                WaitlistModel(
                  id: 'wl1',
                  doctorId: 'doc-1',
                  doctorName: 'Dr. Aleksandr Konstantinopolsky',
                  joinedAt: DateTime(2026, 7, 1),
                ),
              ]),
        ],
      ),
    );
  });

  testWidgets('DoctorHomeScreen fits all six locales', (tester) async {
    _usePhoneViewport(tester);
    await expectNoOverflowAcrossLocales(
      tester,
      () => _wrap(
        const DoctorHomeScreen(),
        overrides: [
          ..._homeOverrides(),
          doctorStatsProvider.overrideWith(
            (ref) async => const DoctorStatsModel(
              appointmentsThisMonth: 42,
              appointmentsLastMonth: 38,
              pendingCount: 7,
              totalPatients: 315,
              acceptanceRate: 87,
            ),
          ),
          doctorAppointmentsProvider.overrideWith((ref, status) async => [
                _appointment(
                  id: 'a1',
                  status: 'pending',
                  reason: 'Recurring chest pain during exercise',
                ),
                _appointment(id: 'a2', status: 'pending'),
              ]),
        ],
      ),
    );
  });

  testWidgets('BookingConfirmScreen fits all six locales', (tester) async {
    _usePhoneViewport(tester);
    final start = DateTime(2026, 7, 20, 10, 30);
    await expectNoOverflowAcrossLocales(
      tester,
      () => _wrap(
        BookingConfirmScreen(
          doctor: _doctorDetail,
          slot: SlotModel(
            startsAt: start,
            endsAt: start.add(const Duration(minutes: 30)),
          ),
          workplaceId: 'w1',
        ),
      ),
    );
  });

  testWidgets(
      'WorkingHoursEditorScreen fits all six locales '
      '(AZ/TR day names are the longest)', (tester) async {
    _usePhoneViewport(tester);
    await expectNoOverflowAcrossLocales(
      tester,
      () => _wrap(
        const WorkingHoursEditorScreen(workplaceId: 'w1'),
        overrides: [
          dioClientProvider.overrideWithValue(_FakeWorkingHoursDio()),
        ],
      ),
    );
  });

  testWidgets('DoctorSearchScreen fits all six locales', (tester) async {
    _usePhoneViewport(tester);
    await expectNoOverflowAcrossLocales(
      tester,
      () => _wrap(
        const DoctorSearchScreen(),
        overrides: [
          favoritesRepositoryProvider
              .overrideWithValue(_OfflineFavoritesRepository()),
          doctorSearchProvider
              .overrideWith((ref, params) async => [_searchDoctor()]),
          nextAvailableDateProvider.overrideWith(
              (ref, id) async => DateTime.now().add(const Duration(days: 2))),
        ],
      ),
    );
  });

  testWidgets('DoctorDetailScreen fits all six locales', (tester) async {
    _usePhoneViewport(tester);
    await expectNoOverflowAcrossLocales(
      tester,
      () => _wrap(
        const DoctorDetailScreen(doctorId: 'doc-1'),
        overrides: [
          doctorDetailProvider.overrideWith((ref, id) async => _doctorDetail),
          myWaitlistProvider.overrideWith((ref) async => []),
          favoritesRepositoryProvider
              .overrideWithValue(_OfflineFavoritesRepository()),
        ],
      ),
    );
  });

  testWidgets(
      'MyAppointmentsScreen fits all six locales '
      '(requires_rescheduling chip beside a long doctor name)',
      (tester) async {
    _usePhoneViewport(tester);
    await expectNoOverflowAcrossLocales(
      tester,
      () => _wrap(
        const MyAppointmentsScreen(),
        overrides: [
          patientAppointmentsProvider.overrideWith((ref, status) async => [
                _appointment(id: 'a1', status: 'requires_rescheduling'),
                _appointment(id: 'a2', status: 'confirmed'),
                _appointment(id: 'a3', status: 'pending'),
              ]),
        ],
      ),
    );
  });

  testWidgets(
      'DoctorAppointmentsScreen fits all six locales '
      '(requires_rescheduling chip beside a long patient name)',
      (tester) async {
    _usePhoneViewport(tester);
    await expectNoOverflowAcrossLocales(
      tester,
      () => _wrap(
        const DoctorAppointmentsScreen(),
        overrides: [
          doctorAppointmentsProvider.overrideWith((ref, status) async => [
                _appointment(
                  id: 'a1',
                  status: 'pending',
                  reason: 'Recurring chest pain during exercise',
                ),
                _appointment(id: 'a2', status: 'requires_rescheduling'),
                _appointment(id: 'a3', status: 'confirmed'),
              ]),
        ],
      ),
      // The first tab only shows pending requests; the "all" tab is where the
      // requires_rescheduling chip renders, so lay it out too.
      afterPump: (tester) async {
        await tester.tap(find.byType(Tab).at(1));
        // Bounded pumps (tab transition is ~300ms) so an unexpected repeat
        // animation can't hang the harness.
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 400));
      },
    );
  });

  testWidgets('SecurityScreen fits all six locales', (tester) async {
    _usePhoneViewport(tester);
    await expectNoOverflowAcrossLocales(
      tester,
      () => _wrap(
        const SecurityScreen(),
        overrides: [
          authRepositoryProvider.overrideWithValue(_FakeAuthRepository()),
        ],
      ),
    );
  });

  testWidgets('ActiveSessionsScreen fits all six locales', (tester) async {
    _usePhoneViewport(tester);
    final repo = _FakeAuthRepository(devices: [
      UserDeviceModel(
        id: '1',
        deviceId: 'device-1',
        deviceName: 'iPhone 15 Pro Max of Aleksandr',
        platform: 'ios',
        isCurrent: true,
        lastSeenAt: DateTime(2026, 7, 1, 10, 30),
      ),
      UserDeviceModel(
        id: '2',
        deviceId: 'device-2',
        deviceName: 'Samsung Galaxy S24 Ultra',
        platform: 'android',
        lastSeenAt: DateTime(2026, 6, 28, 22, 15),
      ),
    ]);
    await expectNoOverflowAcrossLocales(
      tester,
      () => _wrap(
        const ActiveSessionsScreen(),
        overrides: [authRepositoryProvider.overrideWithValue(repo)],
      ),
    );
  });

  testWidgets('SuggestedDoctorCard fits all six locales', (tester) async {
    _usePhoneViewport(tester);
    const doctor = SuggestedDoctor(
      id: 'doc-1',
      firstName: 'Aleksandr',
      lastName: 'Konstantinopolsky',
      specializationDisplay: 'Cardiology and Cardiovascular Surgery',
      averageRating: 4.8,
      city: 'Baku',
    );
    await expectNoOverflowAcrossLocales(
      tester,
      () => _wrap(
        const Scaffold(body: SuggestedDoctorCard(doctor: doctor)),
      ),
    );
  });
}
