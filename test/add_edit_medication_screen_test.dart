import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/features/medications/data/models/medication_model.dart';
import 'package:medalize_mb/features/medications/data/repository/medication_repository.dart';
import 'package:medalize_mb/features/medications/presentation/screens/add_edit_medication_screen.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

class _FakeMedicationRepository extends MedicationRepository {
  _FakeMedicationRepository() : super(Dio());

  String? updatedId;
  List<MedicationScheduleModel>? updatedSchedules;

  @override
  Future<List<MedicationModel>> getMedications() async => const [];

  @override
  Future<MedicationModel> updateMedication(
    String id, {
    required List<MedicationScheduleModel> schedules,
  }) async {
    updatedId = id;
    updatedSchedules = schedules;
    return MedicationModel(
      id: id,
      name: 'Ibuprofen',
      schedules: schedules,
      createdAt: DateTime(2026, 1, 1),
    );
  }
}

/// Pumps the screen behind a minimal GoRouter (with a route to pop back to)
/// so `context.pop()` on save works, matching how it's reached in the app
/// (pushed as a modal from the medication list).
Future<void> _pump(
  WidgetTester tester,
  _FakeMedicationRepository repo, {
  required MedicationModel existing,
}) async {
  // Tall viewport so the Save button (below the schedule builder) is always
  // on-screen without needing to scroll to it in every test.
  tester.view.physicalSize = const Size(480, 1800);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);

  final router = GoRouter(
    initialLocation: '/list',
    routes: [
      GoRoute(path: '/list', builder: (_, _) => const Scaffold(body: Text('list-screen'))),
      GoRoute(
        path: '/edit',
        builder: (_, _) => AddEditMedicationScreen(existing: existing),
      ),
    ],
  );
  await tester.pumpWidget(
    TranslationProvider(
      child: ProviderScope(
        overrides: [medicationRepositoryProvider.overrideWithValue(repo)],
        child: MaterialApp.router(theme: AppTheme.light, routerConfig: router),
      ),
    ),
  );
  router.push('/edit');
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('shows the prescribed drug read-only and prefills its schedule',
      (tester) async {
    final existing = MedicationModel(
      id: 'm1',
      name: 'Ibuprofen',
      dosage: '200mg',
      source: MedicationModel.sourcePrescription,
      schedules: [
        MedicationScheduleModel(
          id: 's1',
          times: const ['08:00'],
          daysOfWeek: const [],
          startDate: DateTime(2026, 1, 1),
        ),
      ],
      createdAt: DateTime(2026, 1, 1),
    );
    final repo = _FakeMedicationRepository();
    await _pump(tester, repo, existing: existing);

    expect(find.text('Ibuprofen'), findsOneWidget);
    expect(find.text('08:00'), findsOneWidget);
    expect(find.text('Edit Medication'), findsOneWidget);
    // The drug identity is shown, not an editable field.
    expect(find.widgetWithText(TextField, 'Name'), findsNothing);
    expect(find.widgetWithText(TextField, 'Dosage'), findsNothing);
  });

  testWidgets('saving without changes resubmits the existing schedule as-is',
      (tester) async {
    final existing = MedicationModel(
      id: 'm1',
      name: 'Ibuprofen',
      schedules: [
        MedicationScheduleModel(
          id: 's1',
          times: const ['08:00'],
          daysOfWeek: const [],
          startDate: DateTime(2026, 1, 1),
        ),
      ],
      createdAt: DateTime(2026, 1, 1),
    );
    final repo = _FakeMedicationRepository();
    await _pump(tester, repo, existing: existing);

    await tester.tap(find.text('Save'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(repo.updatedId, 'm1');
    expect(repo.updatedSchedules, hasLength(1));
    expect(repo.updatedSchedules!.single.times, ['08:00']);
  });

  testWidgets('adding a reminder time updates the schedule on save', (tester) async {
    final existing = MedicationModel(
      id: 'm2',
      name: 'Metformin',
      createdAt: DateTime(2026, 1, 1),
    );
    final repo = _FakeMedicationRepository();
    await _pump(tester, repo, existing: existing);

    await tester.tap(find.text('Add Time'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Save'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(repo.updatedId, 'm2');
    expect(repo.updatedSchedules, hasLength(1));
    expect(repo.updatedSchedules!.single.times, hasLength(1));
  });
}
