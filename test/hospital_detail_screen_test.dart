import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/features/doctors/data/models/doctor_model.dart';
import 'package:medalize_mb/features/hospital/data/models/hospital_model.dart';
import 'package:medalize_mb/features/hospital/data/repository/hospital_repository.dart';
import 'package:medalize_mb/features/patient/presentation/screens/hospital_detail_screen.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

class _FakeHospitalRepository extends HospitalRepository {
  _FakeHospitalRepository(this._result, {List<DoctorModel> doctors = const []})
    : _doctors = doctors,
      super(Dio());
  final Object _result; // HospitalModel or an Exception to throw
  final List<DoctorModel> _doctors;

  @override
  Future<HospitalModel> getById(String id) async {
    final result = _result;
    if (result is Exception) throw result;
    return result as HospitalModel;
  }

  @override
  Future<List<DoctorModel>> getDoctors(String hospitalId) async => _doctors;
}

Widget _harness(HospitalRepository repo) => ProviderScope(
  overrides: [hospitalRepositoryProvider.overrideWithValue(repo)],
  child: TranslationProvider(
    child: MediaQuery(
      // Disables EmptyState's looping float animation — otherwise
      // pumpAndSettle never settles on the error-path test below.
      data: const MediaQueryData(disableAnimations: true),
      child: MaterialApp(
        theme: AppTheme.light,
        home: const HospitalDetailScreen(hospitalId: 'h1'),
      ),
    ),
  ),
);

/// Only for the navigation test below — HospitalDetailScreen's `_DoctorRow`
/// uses go_router's `context.push`, which needs a real GoRouter ancestor
/// (unlike the plain MaterialApp the other tests use). Mirrors the pattern
/// in test/write_prescription_screen_test.dart.
Widget _routerHarness(HospitalRepository repo) {
  final router = GoRouter(
    initialLocation: '/hospital-detail',
    routes: [
      GoRoute(
        path: '/hospital-detail',
        builder: (_, _) => const HospitalDetailScreen(hospitalId: 'h1'),
      ),
      GoRoute(
        path: '/patient/doctor-detail/:id',
        builder: (_, _) => const Scaffold(body: Text('doctor-detail-screen')),
      ),
    ],
  );
  return ProviderScope(
    overrides: [hospitalRepositoryProvider.overrideWithValue(repo)],
    child: TranslationProvider(
      child: MediaQuery(
        data: const MediaQueryData(disableAnimations: true),
        child: MaterialApp.router(theme: AppTheme.light, routerConfig: router),
      ),
    ),
  );
}

void main() {
  setUpAll(() => LocaleSettings.setLocale(AppLocale.en));

  testWidgets('renders the hospital\'s name, city and a share action', (
    tester,
  ) async {
    const hospital = HospitalModel(
      id: 'h1',
      name: 'City Hospital',
      address: '128 Nizami Street',
      city: 'baku',
      cityDisplay: 'Baku',
    );
    await tester.pumpWidget(_harness(_FakeHospitalRepository(hospital)));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    // Once in the AppBar title, once as the body heading.
    expect(find.text('City Hospital'), findsNWidgets(2));
    expect(find.text('128 Nizami Street, Baku'), findsOneWidget);
    expect(find.byIcon(Icons.ios_share_rounded), findsOneWidget);
  });

  testWidgets('renders the doctor roster and navigates to a doctor on tap', (
    tester,
  ) async {
    const hospital = HospitalModel(
      id: 'h1',
      name: 'City Hospital',
      city: 'baku',
      cityDisplay: 'Baku',
    );
    const doctor = DoctorModel(
      id: 'd1',
      firstName: 'Aysel',
      lastName: 'Mammadova',
      specialization: 'cardiology',
      specializationDisplay: 'Cardiology',
      slotDurationMin: 30,
    );
    await tester.pumpWidget(
      _routerHarness(
        _FakeHospitalRepository(hospital, doctors: const [doctor]),
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text(t.hospitalDetail.doctorsHeading), findsOneWidget);
    expect(find.text('Dr. Aysel Mammadova'), findsOneWidget);
    expect(find.text('Cardiology'), findsOneWidget);

    await tester.tap(find.text('Dr. Aysel Mammadova'));
    await tester.pumpAndSettle();

    expect(find.text('doctor-detail-screen'), findsOneWidget);
  });

  testWidgets('an empty roster renders no doctors section at all', (
    tester,
  ) async {
    const hospital = HospitalModel(
      id: 'h1',
      name: 'City Hospital',
      city: 'baku',
    );
    await tester.pumpWidget(_harness(_FakeHospitalRepository(hospital)));
    await tester.pumpAndSettle();

    expect(find.text(t.hospitalDetail.doctorsHeading), findsNothing);
  });

  testWidgets('shows a retry affordance when the fetch fails', (tester) async {
    await tester.pumpWidget(
      _harness(_FakeHospitalRepository(Exception('boom'))),
    );
    await tester.pumpAndSettle();

    expect(find.text(t.hospitalDetail.couldNotLoad), findsOneWidget);
    expect(find.text(t.common.retry), findsOneWidget);
    // No hospital loaded yet — the share action stays hidden rather than
    // pointing at nothing.
    expect(find.byIcon(Icons.ios_share_rounded), findsNothing);
  });
}
