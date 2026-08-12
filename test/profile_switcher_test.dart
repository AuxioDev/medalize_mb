import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/widgets/profile_switcher.dart';
import 'package:medalize_mb/features/auth/providers/auth_provider.dart';
import 'package:medalize_mb/features/auth/providers/auth_state.dart';
import 'package:medalize_mb/features/family/data/models/dependent_model.dart';
import 'package:medalize_mb/features/family/data/repository/family_repository.dart';
import 'package:medalize_mb/features/family/providers/family_provider.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

/// Pins the auth state so this widget test doesn't exercise the real
/// AuthNotifier's cold-start storage/network bootstrap — same pattern as
/// `test/app_intro_test.dart::_FakeAuthNotifier`.
class _FakeAuthNotifier extends AuthNotifier {
  _FakeAuthNotifier(this._fixed);
  final AuthState _fixed;
  @override
  AuthState build() => _fixed;
}

class _FakeFamilyRepository extends FamilyRepository {
  _FakeFamilyRepository(this.dependents) : super(Dio());
  final List<DependentModel> dependents;

  @override
  Future<List<DependentModel>> getDependents() async => dependents;
}

const _auth = AuthAuthenticated(
  accessToken: 'a',
  refreshToken: 'r',
  role: 'patient',
  userId: 'u1',
  phone: '+994501234567',
  onboardingComplete: true,
  firstName: 'Jane',
  lastName: 'Doe',
);

const _daughter = DependentModel(
  id: 'dep-1',
  firstName: 'Anna',
  lastName: 'Doe',
  relationship: DependentModel.relationshipChild,
);

Future<ProviderContainer> _pump(WidgetTester tester) async {
  final container = ProviderContainer(overrides: [
    authProvider.overrideWith(() => _FakeAuthNotifier(_auth)),
    familyRepositoryProvider.overrideWithValue(_FakeFamilyRepository([_daughter])),
  ]);
  addTearDown(container.dispose);

  final router = GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(
        path: '/home',
        builder: (_, _) => const Scaffold(body: ProfileSwitcher()),
      ),
      GoRoute(
        path: '/patient/family/add',
        builder: (_, _) => const Scaffold(body: Text('add-family-member-screen')),
      ),
    ],
  );

  await tester.pumpWidget(
    TranslationProvider(
      child: UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(theme: AppTheme.light, routerConfig: router),
      ),
    ),
  );
  await tester.pumpAndSettle();
  return container;
}

void main() {
  testWidgets('renders "Myself" first, then each dependent, then "+ Add"',
      (tester) async {
    await _pump(tester);

    expect(find.text('Myself'), findsOneWidget);
    expect(find.text('Anna'), findsOneWidget);
    expect(find.text('Add Family Member'), findsOneWidget);
  });

  testWidgets('defaults to "myself" (null) as the active profile', (tester) async {
    final container = await _pump(tester);
    expect(container.read(activeProfileProvider), isNull);
  });

  testWidgets('tapping a dependent chip flips activeProfileProvider to that dependent',
      (tester) async {
    final container = await _pump(tester);

    await tester.tap(find.text('Anna'));
    await tester.pumpAndSettle();

    expect(container.read(activeProfileProvider)?.id, 'dep-1');
  });

  testWidgets('tapping "Myself" after selecting a dependent resets it back to null',
      (tester) async {
    final container = await _pump(tester);

    await tester.tap(find.text('Anna'));
    await tester.pumpAndSettle();
    expect(container.read(activeProfileProvider), isNotNull);

    await tester.tap(find.text('Myself'));
    await tester.pumpAndSettle();

    expect(container.read(activeProfileProvider), isNull);
  });

  testWidgets('tapping "+ Add" navigates to the add-family-member screen',
      (tester) async {
    await _pump(tester);

    await tester.tap(find.text('Add Family Member'));
    await tester.pumpAndSettle();

    expect(find.text('add-family-member-screen'), findsOneWidget);
  });
}
