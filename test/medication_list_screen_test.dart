import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/widgets/app_badge.dart';
import 'package:medalize_mb/features/family/data/models/dependent_model.dart';
import 'package:medalize_mb/features/medications/data/models/medication_model.dart';
import 'package:medalize_mb/features/medications/data/repository/medication_repository.dart';
import 'package:medalize_mb/features/medications/presentation/screens/medication_list_screen.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

class _FakeMedicationRepository extends MedicationRepository {
  _FakeMedicationRepository(this.medications) : super(Dio());
  final List<MedicationModel> medications;
  String? deletedId;

  @override
  Future<List<MedicationModel>> getMedications() async => medications;

  @override
  Future<void> deleteMedication(String id) async {
    deletedId = id;
  }
}

MedicationModel _med({
  required String id,
  required String name,
  bool isActive = true,
  List<MedicationScheduleModel> schedules = const [],
  DependentModel? dependent,
}) =>
    MedicationModel(
      id: id,
      name: name,
      dosage: '500mg',
      isActive: isActive,
      schedules: schedules,
      createdAt: DateTime(2026, 1, 1),
      dependent: dependent,
    );

Widget _app(_FakeMedicationRepository repo) => TranslationProvider(
      child: ProviderScope(
        overrides: [medicationRepositoryProvider.overrideWithValue(repo)],
        // EmptyState runs a repeating float animation that would otherwise
        // keep pumpAndSettle() spinning forever.
        child: MediaQuery(
          data: const MediaQueryData(disableAnimations: true),
          child: MaterialApp(
            theme: AppTheme.light,
            home: const MedicationListScreen(),
          ),
        ),
      ),
    );

void main() {
  testWidgets('renders active medications on the Active tab with schedule times',
      (tester) async {
    final repo = _FakeMedicationRepository([
      _med(id: 'm1', name: 'Metformin', schedules: [
        MedicationScheduleModel(
          id: 's1',
          times: const ['08:00', '20:00'],
          daysOfWeek: const [],
          startDate: DateTime(2026, 1, 1),
        ),
      ]),
      _med(id: 'm2', name: 'Old Pill', isActive: false),
    ]);

    await tester.pumpWidget(_app(repo));
    await tester.pumpAndSettle();

    expect(find.text('Metformin'), findsOneWidget);
    expect(find.text('08:00 · 20:00'), findsOneWidget);
    // Archived medication only shows on the Archive tab.
    expect(find.text('Old Pill'), findsNothing);
  });

  testWidgets('switching to the Archive tab shows inactive medications',
      (tester) async {
    final repo = _FakeMedicationRepository([
      _med(id: 'm1', name: 'Metformin'),
      _med(id: 'm2', name: 'Old Pill', isActive: false),
    ]);

    await tester.pumpWidget(_app(repo));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Archive'));
    await tester.pumpAndSettle();

    expect(find.text('Old Pill'), findsOneWidget);
    expect(find.text('Metformin'), findsNothing);
  });

  testWidgets('shows the empty state when there are no medications',
      (tester) async {
    final repo = _FakeMedicationRepository(const []);
    await tester.pumpWidget(_app(repo));
    await tester.pumpAndSettle();

    expect(find.text('No medications yet'), findsOneWidget);
  });

  testWidgets('deleting a medication asks for confirmation then calls the repo',
      (tester) async {
    final repo = _FakeMedicationRepository([_med(id: 'm1', name: 'Metformin')]);
    await tester.pumpWidget(_app(repo));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.delete_outline));
    await tester.pumpAndSettle();
    expect(find.text('Delete Medication'), findsOneWidget);

    await tester.tap(find.text('Delete').last);
    await tester.pumpAndSettle();

    expect(repo.deletedId, 'm1');
  });

  testWidgets(
      'shows a "for" badge only on medications that belong to a family member '
      '(Phase 4)', (tester) async {
    const daughter = DependentModel(
      id: 'dep-1',
      firstName: 'Anna',
      relationship: DependentModel.relationshipChild,
    );
    final repo = _FakeMedicationRepository([
      _med(id: 'm1', name: 'Metformin'),
      _med(id: 'm2', name: 'Amoxicillin', dependent: daughter),
    ]);
    await tester.pumpWidget(_app(repo));
    await tester.pumpAndSettle();

    expect(find.byType(AppBadge), findsOneWidget);
    expect(find.text('for Anna'), findsOneWidget);
  });

  testWidgets('shows no "for" badge when no medication has a dependent',
      (tester) async {
    final repo = _FakeMedicationRepository([_med(id: 'm1', name: 'Metformin')]);
    await tester.pumpWidget(_app(repo));
    await tester.pumpAndSettle();

    expect(find.byType(AppBadge), findsNothing);
  });
}
