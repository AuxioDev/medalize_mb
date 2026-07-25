import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/features/family/data/models/dependent_model.dart';
import 'package:medalize_mb/features/family/data/repository/family_repository.dart';
import 'package:medalize_mb/features/family/presentation/screens/add_edit_dependent_screen.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

class _FakeFamilyRepository extends FamilyRepository {
  _FakeFamilyRepository() : super(Dio());

  String? createdFirstName;
  String? createdRelationship;
  String? updatedId;

  @override
  Future<List<DependentModel>> getDependents() async => const [];

  @override
  Future<DependentModel> createDependent({
    required String firstName,
    String lastName = '',
    required String relationship,
    DateTime? dateOfBirth,
    String bloodType = '',
    String allergies = '',
    String chronicConditions = '',
    String medications = '',
  }) async {
    createdFirstName = firstName;
    createdRelationship = relationship;
    return DependentModel(
      id: 'new-id',
      firstName: firstName,
      lastName: lastName,
      relationship: relationship,
    );
  }

  @override
  Future<DependentModel> updateDependent(
    String id, {
    String? firstName,
    String? lastName,
    String? relationship,
    DateTime? dateOfBirth,
    String? bloodType,
    String? allergies,
    String? chronicConditions,
    String? medications,
  }) async {
    updatedId = id;
    return DependentModel(
      id: id,
      firstName: firstName ?? '',
      relationship: relationship ?? DependentModel.relationshipChild,
    );
  }
}

/// Pumps the screen behind a minimal GoRouter (with a route to pop back to)
/// so `context.pop()` on save works, matching how it's reached in the app
/// (pushed as a modal from the family list).
Future<void> _pump(
  WidgetTester tester,
  _FakeFamilyRepository repo, {
  DependentModel? existing,
}) async {
  tester.view.physicalSize = const Size(480, 1800);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);

  final router = GoRouter(
    initialLocation: '/list',
    routes: [
      GoRoute(path: '/list', builder: (_, _) => const Scaffold(body: Text('list-screen'))),
      GoRoute(
        path: '/add',
        builder: (_, _) => AddEditDependentScreen(existing: existing),
      ),
    ],
  );
  await tester.pumpWidget(
    TranslationProvider(
      child: ProviderScope(
        overrides: [familyRepositoryProvider.overrideWithValue(repo)],
        child: MaterialApp.router(theme: AppTheme.light, routerConfig: router),
      ),
    ),
  );
  router.push('/add');
  await tester.pumpAndSettle();
}

void main() {
  testWidgets(
      'shows a validation error and does not submit when first name is empty',
      (tester) async {
    final repo = _FakeFamilyRepository();
    await _pump(tester, repo);

    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(find.text('First Name is required'), findsOneWidget);
    expect(repo.createdFirstName, isNull);
  });

  testWidgets('filling the form and saving creates the family member',
      (tester) async {
    final repo = _FakeFamilyRepository();
    await _pump(tester, repo);

    await tester.enterText(find.widgetWithText(TextField, 'First Name'), 'Anna');
    await tester.tap(find.text('Spouse'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Save'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(repo.createdFirstName, 'Anna');
    expect(repo.createdRelationship, DependentModel.relationshipSpouse);
  });

  testWidgets('editing prefills the existing family member and updates on save',
      (tester) async {
    const existing = DependentModel(
      id: 'd1',
      firstName: 'Anna',
      relationship: DependentModel.relationshipChild,
    );
    final repo = _FakeFamilyRepository();
    await _pump(tester, repo, existing: existing);

    expect(find.text('Anna'), findsOneWidget);
    expect(find.text('Edit Family Member'), findsOneWidget);

    await tester.tap(find.text('Save'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(repo.updatedId, 'd1');
  });
}
