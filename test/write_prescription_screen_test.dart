import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/features/prescriptions/data/models/prescription_model.dart';
import 'package:medalize_mb/features/prescriptions/data/repository/prescription_repository.dart';
import 'package:medalize_mb/features/prescriptions/presentation/screens/write_prescription_screen.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

class _FakePrescriptionRepository extends PrescriptionRepository {
  _FakePrescriptionRepository() : super(Dio());

  String? createdAppointmentId;
  String? createdNotes;
  List<PrescriptionItemModel>? createdItems;

  @override
  Future<PrescriptionModel> createPrescription(
    String appointmentId, {
    String notes = '',
    required List<PrescriptionItemModel> items,
  }) async {
    createdAppointmentId = appointmentId;
    createdNotes = notes;
    createdItems = items;
    return PrescriptionModel(id: 'new-p', issuedAt: DateTime(2026, 1, 1), items: items);
  }
}

Future<void> _pump(WidgetTester tester, _FakePrescriptionRepository repo) async {
  tester.view.physicalSize = const Size(480, 1800);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);

  final router = GoRouter(
    initialLocation: '/detail',
    routes: [
      GoRoute(path: '/detail', builder: (_, _) => const Scaffold(body: Text('detail-screen'))),
      GoRoute(
        path: '/write',
        builder: (_, _) => const WritePrescriptionScreen(
          appointmentId: 'appt-1',
          patientName: 'John Smith',
        ),
      ),
    ],
  );
  await tester.pumpWidget(
    TranslationProvider(
      child: ProviderScope(
        overrides: [prescriptionRepositoryProvider.overrideWithValue(repo)],
        child: MaterialApp.router(theme: AppTheme.light, routerConfig: router),
      ),
    ),
  );
  router.push('/write');
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('shows a validation error when no drug name is entered', (tester) async {
    final repo = _FakePrescriptionRepository();
    await _pump(tester, repo);

    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(find.text('Add at least one drug'), findsOneWidget);
    expect(repo.createdAppointmentId, isNull);
  });

  testWidgets('filling one drug row and saving creates the prescription', (tester) async {
    final repo = _FakePrescriptionRepository();
    await _pump(tester, repo);

    await tester.enterText(find.widgetWithText(TextField, 'Drug Name'), 'Amoxicillin');
    await tester.enterText(find.widgetWithText(TextField, 'Dosage'), '500mg');
    await tester.enterText(find.widgetWithText(TextField, 'Notes'), 'Follow up in 2 weeks');

    await tester.tap(find.text('Save'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(repo.createdAppointmentId, 'appt-1');
    expect(repo.createdNotes, 'Follow up in 2 weeks');
    expect(repo.createdItems, hasLength(1));
    expect(repo.createdItems!.single.drugName, 'Amoxicillin');
    expect(repo.createdItems!.single.dosage, '500mg');
  });

  testWidgets('Add Drug adds another row and Remove removes it', (tester) async {
    final repo = _FakePrescriptionRepository();
    await _pump(tester, repo);

    expect(find.text('#1'), findsOneWidget);
    expect(find.text('#2'), findsNothing);

    await tester.tap(find.text('Add Drug'));
    await tester.pumpAndSettle();
    expect(find.text('#2'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.close).first);
    await tester.pumpAndSettle();
    expect(find.text('#2'), findsNothing);
  });
}
