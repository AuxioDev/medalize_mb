import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/features/family/data/models/dependent_model.dart';
import 'package:medalize_mb/features/family/providers/family_provider.dart';
import 'package:medalize_mb/features/medications/data/models/medication_model.dart';
import 'package:medalize_mb/features/medications/data/repository/medication_repository.dart';
import 'package:medalize_mb/features/medications/presentation/screens/add_edit_medication_screen.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

class _FakeMedicationRepository extends MedicationRepository {
  _FakeMedicationRepository() : super(Dio());

  String? createdName;
  String? createdDosage;
  List<MedicationScheduleModel>? createdSchedules;
  String? createdDependentId;
  String? updatedId;

  @override
  Future<List<MedicationModel>> getMedications() async => const [];

  @override
  Future<MedicationModel> createMedication({
    required String name,
    String dosage = '',
    String form = '',
    String notes = '',
    List<MedicationScheduleModel> schedules = const [],
    String? dependentId,
  }) async {
    createdName = name;
    createdDosage = dosage;
    createdSchedules = schedules;
    createdDependentId = dependentId;
    return MedicationModel(
      id: 'new-id',
      name: name,
      dosage: dosage,
      form: form,
      notes: notes,
      schedules: schedules,
      createdAt: DateTime(2026, 1, 1),
    );
  }

  @override
  Future<MedicationModel> updateMedication(
    String id, {
    String? name,
    String? dosage,
    String? form,
    String? notes,
    bool? isActive,
    List<MedicationScheduleModel>? schedules,
  }) async {
    updatedId = id;
    return MedicationModel(
      id: id,
      name: name ?? '',
      dosage: dosage ?? '',
      schedules: schedules ?? const [],
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
  MedicationModel? existing,
  DependentModel? activeProfile,
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
        path: '/add',
        builder: (_, _) => AddEditMedicationScreen(existing: existing),
      ),
    ],
  );
  await tester.pumpWidget(
    TranslationProvider(
      child: ProviderScope(
        overrides: [
          medicationRepositoryProvider.overrideWithValue(repo),
          if (activeProfile != null)
            activeProfileProvider.overrideWith((ref) => activeProfile),
        ],
        child: MaterialApp.router(theme: AppTheme.light, routerConfig: router),
      ),
    ),
  );
  router.push('/add');
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('shows a validation error and does not submit when name is empty',
      (tester) async {
    final repo = _FakeMedicationRepository();
    await _pump(tester, repo);

    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(find.text('Name is required'), findsOneWidget);
    expect(repo.createdName, isNull);
  });

  testWidgets('adding a reminder time and saving creates the medication with a schedule',
      (tester) async {
    final repo = _FakeMedicationRepository();
    await _pump(tester, repo);

    await tester.enterText(find.widgetWithText(TextField, 'Name'), 'Metformin');
    await tester.enterText(find.widgetWithText(TextField, 'Dosage'), '500mg');

    // Add a reminder time via the time picker (defaults to "now" — we only
    // need to confirm the dialog, not pick a specific time).
    await tester.tap(find.text('Add Time'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Save'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(repo.createdName, 'Metformin');
    expect(repo.createdDosage, '500mg');
    expect(repo.createdSchedules, hasLength(1));
    expect(repo.createdSchedules!.single.times, hasLength(1));
  });

  testWidgets('editing prefills the existing medication and updates on save',
      (tester) async {
    final existing = MedicationModel(
      id: 'm1',
      name: 'Ibuprofen',
      dosage: '200mg',
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

    await tester.tap(find.text('Save'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(repo.updatedId, 'm1');
  });

  testWidgets(
      'creating a medication while a family member is the active profile '
      'passes her id as dependentId (Phase 4)', (tester) async {
    const daughter = DependentModel(
      id: 'dep-1',
      firstName: 'Anna',
      relationship: DependentModel.relationshipChild,
    );
    final repo = _FakeMedicationRepository();
    await _pump(tester, repo, activeProfile: daughter);

    await tester.enterText(find.widgetWithText(TextField, 'Name'), 'Paracetamol');
    await tester.tap(find.text('Save'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(repo.createdName, 'Paracetamol');
    expect(repo.createdDependentId, 'dep-1');
  });

  testWidgets(
      'creating a medication for "myself" (the default active profile) sends '
      'no dependentId (Phase 4)', (tester) async {
    final repo = _FakeMedicationRepository();
    await _pump(tester, repo);

    await tester.enterText(find.widgetWithText(TextField, 'Name'), 'Paracetamol');
    await tester.tap(find.text('Save'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(repo.createdDependentId, isNull);
  });
}
