import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/widgets/app_date_field.dart';
import 'package:medalize_mb/core/widgets/phone_field.dart';
import 'package:medalize_mb/features/family/data/models/dependent_model.dart';
import 'package:medalize_mb/features/family/data/repository/family_repository.dart';
import 'package:medalize_mb/features/family/presentation/screens/add_edit_dependent_screen.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

class _FakeFamilyRepository extends FamilyRepository {
  _FakeFamilyRepository() : super(Dio());

  String? createdFirstName;
  String? createdRelationship;
  DateTime? createdDateOfBirth;
  String? createdContactPhone;
  String? updatedId;
  String? updatedContactPhone;

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
    String contactEmail = '',
    String contactPhone = '',
  }) async {
    createdFirstName = firstName;
    createdRelationship = relationship;
    createdDateOfBirth = dateOfBirth;
    createdContactPhone = contactPhone;
    return DependentModel(
      id: 'new-id',
      firstName: firstName,
      lastName: lastName,
      relationship: relationship,
      dateOfBirth: dateOfBirth,
      contactPhone: contactPhone,
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
    String? contactEmail,
    String? contactPhone,
  }) async {
    updatedId = id;
    updatedContactPhone = contactPhone;
    return DependentModel(
      id: id,
      firstName: firstName ?? '',
      relationship: relationship ?? DependentModel.relationshipChild,
      dateOfBirth: dateOfBirth,
      contactPhone: contactPhone ?? '',
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

/// Opens the date-of-birth picker and confirms without changing the
/// selection — `AppDateField`'s `_pickDateOfBirth` opens `showDatePicker`
/// with `initialDate: DateTime.now()`, so accepting immediately picks
/// "today" (age 0 — a minor, so this alone never trips the adult
/// contact-phone requirement below).
Future<void> _pickTodayAsDateOfBirth(WidgetTester tester) async {
  await tester.tap(find.byType(AppDateField));
  await tester.pumpAndSettle();
  await tester.tap(find.text('OK'));
  await tester.pumpAndSettle();
}

/// Enters 9 local digits into the PhoneField (mirrors how a real user types
/// into it — FilteringTextInputFormatter.digitsOnly + a 9-digit cap live
/// inside PhoneField itself).
Future<void> _enterPhoneDigits(WidgetTester tester, String digits) async {
  await tester.enterText(
    find.descendant(of: find.byType(PhoneField), matching: find.byType(TextField)),
    digits,
  );
}

DependentModel _adultDependent({
  String id = 'd-adult',
  String contactPhone = '',
  DateTime? consentNoticeSentAt,
}) =>
    DependentModel(
      id: id,
      firstName: 'Mark',
      relationship: DependentModel.relationshipSpouse,
      // Comfortably 18+ regardless of what day this runs.
      dateOfBirth: DateTime(DateTime.now().year - 30, 1, 1),
      contactPhone: contactPhone,
      consentNoticeSentAt: consentNoticeSentAt,
    );

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

  testWidgets(
      'shows a validation error and does not submit when date of birth is not picked',
      (tester) async {
    final repo = _FakeFamilyRepository();
    await _pump(tester, repo);

    await tester.enterText(find.widgetWithText(TextField, 'First Name'), 'Anna');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(find.text('Date of Birth is required'), findsOneWidget);
    expect(repo.createdFirstName, isNull);
  });

  testWidgets('filling the form and saving creates the family member',
      (tester) async {
    final repo = _FakeFamilyRepository();
    await _pump(tester, repo);

    await tester.enterText(find.widgetWithText(TextField, 'First Name'), 'Anna');
    await tester.tap(find.text('Spouse'));
    await tester.pumpAndSettle();
    await _pickTodayAsDateOfBirth(tester);

    await tester.tap(find.text('Save'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(repo.createdFirstName, 'Anna');
    expect(repo.createdRelationship, DependentModel.relationshipSpouse);
    expect(repo.createdDateOfBirth, isNotNull);
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

    // A pre-existing dependent with no date of birth on file (created
    // before it was required) must stay editable — the app must not force
    // a disruptive backfill onto every unrelated edit (Phase: adult-
    // dependent consent).
    expect(repo.updatedId, 'd1');
  });

  group('adult dependent contact phone (18+ consent notice)', () {
    testWidgets('does not show a contact phone field for a minor dependent',
        (tester) async {
      final repo = _FakeFamilyRepository();
      final existing = DependentModel(
        id: 'd-minor',
        firstName: 'Timmy',
        relationship: DependentModel.relationshipChild,
        dateOfBirth: DateTime(DateTime.now().year - 6, 1, 1),
      );
      await _pump(tester, repo, existing: existing);

      expect(find.byType(PhoneField), findsNothing);
    });

    testWidgets('shows a contact phone field for an 18+ dependent',
        (tester) async {
      final repo = _FakeFamilyRepository();
      await _pump(tester, repo, existing: _adultDependent());

      expect(find.byType(PhoneField), findsOneWidget);
      expect(find.text('Contact Phone'), findsOneWidget);
    });

    testWidgets(
        'blocks saving an adult dependent with no contact phone and shows why',
        (tester) async {
      final repo = _FakeFamilyRepository();
      await _pump(tester, repo, existing: _adultDependent());

      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      expect(
        find.text('A phone number is required so we can notify this family member'),
        findsOneWidget,
      );
      expect(repo.updatedId, isNull);
    });

    testWidgets('saves and sends the contact phone once one is filled in',
        (tester) async {
      final repo = _FakeFamilyRepository();
      await _pump(tester, repo, existing: _adultDependent());

      await _enterPhoneDigits(tester, '501112233');
      await tester.tap(find.text('Save'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(repo.updatedId, 'd-adult');
      expect(repo.updatedContactPhone, '+994501112233');
    });

    testWidgets(
        'shows a forward-looking notice before saving, and a past-tense one '
        'once the notice has already been sent', (tester) async {
      final repo = _FakeFamilyRepository();
      await _pump(tester, repo, existing: _adultDependent());
      expect(
        find.text(
          "Since they're 18 or older, we'll text them to let them know you "
          "added them — they don't need the app, and they can disconnect "
          'this connection at any time.',
        ),
        findsOneWidget,
      );

      final repo2 = _FakeFamilyRepository();
      await _pump(
        tester, repo2,
        existing: _adultDependent(
          id: 'd-adult-2', contactPhone: '+994501112233', consentNoticeSentAt: DateTime.now(),
        ),
      );
      expect(
        find.text(
          "We've let them know they were added. They can disconnect this "
          'connection at any time.',
        ),
        findsOneWidget,
      );
    });
  });
}
