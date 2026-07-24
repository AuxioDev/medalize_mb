import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/features/medications/data/models/medication_model.dart';
import 'package:medalize_mb/features/prescriptions/data/models/prescription_model.dart';
import 'package:medalize_mb/features/prescriptions/data/repository/prescription_repository.dart';
import 'package:medalize_mb/features/prescriptions/presentation/screens/prescription_detail_screen.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

class _FakePrescriptionRepository extends PrescriptionRepository {
  _FakePrescriptionRepository(this.prescription) : super(Dio());
  final PrescriptionModel prescription;

  String? appliedId;
  int applyCallCount = 0;

  @override
  Future<PrescriptionModel> getPrescription(String id) async => prescription;

  @override
  Future<List<MedicationModel>> applyPrescription(String id) async {
    appliedId = id;
    applyCallCount++;
    return [
      MedicationModel(
        id: 'm1',
        name: 'Amoxicillin',
        source: MedicationModel.sourcePrescription,
        createdAt: DateTime(2026, 1, 1),
      ),
    ];
  }
}

PrescriptionModel _prescription() => PrescriptionModel(
      id: 'p1',
      doctorName: 'Jane Doe',
      issuedAt: DateTime(2026, 6, 1),
      items: const [
        PrescriptionItemModel(
          drugName: 'Amoxicillin',
          dosage: '500mg',
          frequency: 'Twice a day',
        ),
      ],
    );

Widget _app(_FakePrescriptionRepository repo) {
  final router = GoRouter(
    initialLocation: '/detail',
    routes: [
      GoRoute(
        path: '/detail',
        builder: (_, _) => const PrescriptionDetailScreen(prescriptionId: 'p1'),
      ),
      GoRoute(
        path: '/patient/medications',
        builder: (_, _) => const Scaffold(body: Text('medications-screen')),
      ),
    ],
  );
  return TranslationProvider(
    child: ProviderScope(
      overrides: [prescriptionRepositoryProvider.overrideWithValue(repo)],
      child: MaterialApp.router(theme: AppTheme.light, routerConfig: router),
    ),
  );
}

void main() {
  testWidgets('renders the prescription items and doctor', (tester) async {
    final repo = _FakePrescriptionRepository(_prescription());
    await tester.pumpWidget(_app(repo));
    await tester.pumpAndSettle();

    expect(find.text('Issued by Dr. Jane Doe'), findsOneWidget);
    expect(find.text('Amoxicillin'), findsOneWidget);
    expect(find.text('500mg · Twice a day'), findsOneWidget);
  });

  testWidgets('tapping "Add to My Medications" calls applyPrescription', (tester) async {
    final repo = _FakePrescriptionRepository(_prescription());
    await tester.pumpWidget(_app(repo));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Add to My Medications'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(repo.appliedId, 'p1');
    expect(repo.applyCallCount, 1);
  });
}
