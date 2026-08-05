import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/features/family/data/models/dependent_model.dart';
import 'package:medalize_mb/features/family/data/repository/family_repository.dart';
import 'package:medalize_mb/features/family/presentation/screens/family_list_screen.dart';
import 'package:medalize_mb/features/family/providers/family_provider.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

class _FakeFamilyRepository extends FamilyRepository {
  _FakeFamilyRepository(this.dependents) : super(Dio());
  final List<DependentModel> dependents;
  String? deletedId;

  @override
  Future<List<DependentModel>> getDependents() async => dependents;

  @override
  Future<void> deleteDependent(String id) async {
    deletedId = id;
  }
}

DependentModel _dependent({
  required String id,
  required String firstName,
  String relationship = DependentModel.relationshipChild,
  DateTime? consentNoticeSentAt,
}) =>
    DependentModel(
      id: id,
      firstName: firstName,
      relationship: relationship,
      consentNoticeSentAt: consentNoticeSentAt,
    );

Widget _app(_FakeFamilyRepository repo) => TranslationProvider(
      child: ProviderScope(
        overrides: [familyRepositoryProvider.overrideWithValue(repo)],
        // EmptyState runs a repeating float animation that would otherwise
        // keep pumpAndSettle() spinning forever.
        child: MediaQuery(
          data: const MediaQueryData(disableAnimations: true),
          child: MaterialApp(theme: AppTheme.light, home: const FamilyListScreen()),
        ),
      ),
    );

void main() {
  testWidgets('renders each family member with their name and relationship',
      (tester) async {
    final repo = _FakeFamilyRepository([
      _dependent(id: 'd1', firstName: 'Anna', relationship: DependentModel.relationshipChild),
      _dependent(id: 'd2', firstName: 'Mark', relationship: DependentModel.relationshipSpouse),
    ]);
    await tester.pumpWidget(_app(repo));
    await tester.pumpAndSettle();

    expect(find.text('Anna'), findsOneWidget);
    expect(find.text('Child'), findsOneWidget);
    expect(find.text('Mark'), findsOneWidget);
    expect(find.text('Spouse'), findsOneWidget);
  });

  testWidgets(
      'shows a "notice sent" badge only for a dependent whose consent notice has gone out',
      (tester) async {
    final repo = _FakeFamilyRepository([
      _dependent(id: 'd1', firstName: 'Anna', relationship: DependentModel.relationshipChild),
      _dependent(
        id: 'd2', firstName: 'Mark', relationship: DependentModel.relationshipSpouse,
        consentNoticeSentAt: DateTime.now(),
      ),
    ]);
    await tester.pumpWidget(_app(repo));
    await tester.pumpAndSettle();

    expect(find.text('Notice sent'), findsOneWidget);
  });

  testWidgets('shows the empty state when there are no family members',
      (tester) async {
    final repo = _FakeFamilyRepository(const []);
    await tester.pumpWidget(_app(repo));
    await tester.pumpAndSettle();

    expect(find.text('No family members yet'), findsOneWidget);
  });

  testWidgets('deleting a family member asks for confirmation then calls the repo',
      (tester) async {
    final repo = _FakeFamilyRepository([_dependent(id: 'd1', firstName: 'Anna')]);
    await tester.pumpWidget(_app(repo));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.delete_outline));
    await tester.pumpAndSettle();
    expect(find.text('Remove Family Member'), findsOneWidget);

    await tester.tap(find.text('Delete').last);
    await tester.pumpAndSettle();

    expect(repo.deletedId, 'd1');
  });

  testWidgets(
      'deleting the currently active profile resets activeProfileProvider back '
      'to "myself" so a stale reference never lingers (Phase 4)', (tester) async {
    final anna = _dependent(id: 'd1', firstName: 'Anna');
    final repo = _FakeFamilyRepository([anna]);
    final container = ProviderContainer(overrides: [
      familyRepositoryProvider.overrideWithValue(repo),
    ]);
    addTearDown(container.dispose);
    container.read(activeProfileProvider.notifier).state = anna;

    await tester.pumpWidget(
      TranslationProvider(
        child: UncontrolledProviderScope(
          container: container,
          child: MediaQuery(
            data: const MediaQueryData(disableAnimations: true),
            child: MaterialApp(theme: AppTheme.light, home: const FamilyListScreen()),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.delete_outline));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete').last);
    await tester.pumpAndSettle();

    expect(container.read(activeProfileProvider), isNull);
  });
}
