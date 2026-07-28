import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/features/subscription/data/models/subscription_model.dart';
import 'package:medalize_mb/features/subscription/data/repository/subscription_repository.dart';
import 'package:medalize_mb/features/subscription/presentation/screens/subscription_screen.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

class _FakeSubscriptionRepository extends SubscriptionRepository {
  _FakeSubscriptionRepository({
    this.subscription = const SubscriptionModel(),
    this.plans = const [],
    this.checkoutUrl,
  }) : super(Dio());

  final SubscriptionModel subscription;
  final List<SubscriptionPlanModel> plans;

  /// `null` makes [checkout] throw `SubscriptionUnavailableException`,
  /// mirroring a 503 (Payriff not configured) — the one checkout outcome
  /// that's safe to exercise without a url_launcher platform mock, since it
  /// returns before ever reaching launchUrl. Same restraint as
  /// test/payment_screen_test.dart, which never taps its own "Pay Now".
  final String? checkoutUrl;

  int checkoutCallCount = 0;
  String? lastCheckoutPlan;

  @override
  Future<SubscriptionModel> getSubscription() async => subscription;

  @override
  Future<List<SubscriptionPlanModel>> getPlans() async => plans;

  @override
  Future<String> checkout(String plan) async {
    checkoutCallCount++;
    lastCheckoutPlan = plan;
    if (checkoutUrl == null) throw const SubscriptionUnavailableException();
    return checkoutUrl!;
  }
}

final _plans = [
  const SubscriptionPlanModel(
    plan: SubscriptionPlanModel.basic,
    name: 'Başlanğıc',
    price: '19.99',
    currency: 'AZN',
    limits: SubscriptionLimits(
      workplaces: 1, appointmentsPerMonth: 40, chat: false, promoted: false,
    ),
  ),
  const SubscriptionPlanModel(
    plan: SubscriptionPlanModel.pro,
    name: 'Peşəkar',
    price: '39.99',
    currency: 'AZN',
    limits: SubscriptionLimits(
      workplaces: 5, appointmentsPerMonth: null, chat: true, promoted: true,
    ),
  ),
];

Future<void> _pump(
  WidgetTester tester,
  _FakeSubscriptionRepository repo, {
  bool fromGate = false,
}) async {
  final router = GoRouter(
    initialLocation: '/behind',
    routes: [
      GoRoute(
        path: '/behind',
        builder: (_, _) => Builder(
          builder: (context) => Scaffold(
            body: Center(
              child: TextButton(
                onPressed: () => context.push('/doctor/subscription'),
                child: const Text('open-subscription'),
              ),
            ),
          ),
        ),
      ),
      GoRoute(
        path: '/doctor/subscription',
        builder: (_, _) => SubscriptionScreen(fromGate: fromGate),
      ),
    ],
  );
  await tester.pumpWidget(
    TranslationProvider(
      child: ProviderScope(
        overrides: [subscriptionRepositoryProvider.overrideWithValue(repo)],
        // EmptyState (the error-state view) runs an infinitely-repeating
        // float animation unless disableAnimations is set, which would hang
        // pumpAndSettle() — same fix as test/active_sessions_screen_test.dart.
        child: MediaQuery(
          data: const MediaQueryData(disableAnimations: true),
          child: MaterialApp.router(theme: AppTheme.light, routerConfig: router),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
  await tester.tap(find.text('open-subscription'));
  await tester.pumpAndSettle();
}

void main() {
  setUp(() {
    // AuthNotifier.build() reads secure storage on construction — the
    // screen's pull-to-refresh path touches authProvider.refreshProfile(),
    // which no-ops safely once this resolves to AuthUnauthenticated.
    FlutterSecureStorage.setMockInitialValues({});
  });

  testWidgets('trialing doctor sees the trial banner and both plan cards',
      (tester) async {
    final repo = _FakeSubscriptionRepository(
      subscription: SubscriptionModel(
        status: SubscriptionModel.statusTrialing,
        trialEndsAt: DateTime.now().add(const Duration(days: 4)),
        limits: const SubscriptionLimits(
          workplaces: 5, appointmentsPerMonth: null, chat: true, promoted: true,
        ),
      ),
      plans: _plans,
    );
    await _pump(tester, repo);

    expect(tester.takeException(), isNull);
    // Plan names are localized client-side (Starter/Professional in the
    // default test locale), not the raw Azerbaijani brand name the backend
    // sends in `plan.name` — see _planDisplayName in subscription_screen.dart.
    expect(find.text('Starter'), findsOneWidget);
    expect(find.text('Professional'), findsOneWidget);
    expect(find.text('19.99 AZN'), findsOneWidget);
    expect(find.text('39.99 AZN'), findsOneWidget);
    expect(find.textContaining('Free trial'), findsOneWidget);
    // Neither plan is active yet, so no "Current Plan" badge anywhere.
    expect(find.text('Current Plan'), findsNothing);
    expect(find.text('Most Popular'), findsOneWidget);
  });

  testWidgets('active Başlanğıc subscriber sees the Current Plan badge on that card',
      (tester) async {
    final repo = _FakeSubscriptionRepository(
      subscription: const SubscriptionModel(
        status: SubscriptionModel.statusActive,
        plan: SubscriptionPlanModel.basic,
        limits: SubscriptionLimits(
          workplaces: 1, appointmentsPerMonth: 40, chat: false, promoted: false,
        ),
      ),
      plans: _plans,
    );
    await _pump(tester, repo);

    expect(find.text('Current Plan'), findsOneWidget);
    expect(find.textContaining('subscription is active'), findsOneWidget);
  });

  testWidgets('past_due doctor sees the grace-period warning banner',
      (tester) async {
    final repo = _FakeSubscriptionRepository(
      subscription: SubscriptionModel(
        status: SubscriptionModel.statusPastDue,
        graceEndsAt: DateTime.now().add(const Duration(days: 9)),
      ),
      plans: _plans,
    );
    await _pump(tester, repo);

    expect(find.textContaining('Grace period'), findsOneWidget);
  });

  testWidgets('expired doctor sees the hidden-from-search notice',
      (tester) async {
    final repo = _FakeSubscriptionRepository(
      subscription: const SubscriptionModel(status: SubscriptionModel.statusExpired),
      plans: _plans,
    );
    await _pump(tester, repo);

    expect(find.textContaining('expired'), findsOneWidget);
  });

  testWidgets('fromGate=true shows a sign-out action instead of a back button',
      (tester) async {
    final repo = _FakeSubscriptionRepository(
      subscription: const SubscriptionModel(status: SubscriptionModel.statusExpired),
      plans: _plans,
    );
    await _pump(tester, repo, fromGate: true);

    expect(find.text('Sign Out'), findsOneWidget);
    expect(find.byType(BackButton), findsNothing);
  });

  testWidgets('fromGate=false shows a normal back button, no sign-out action',
      (tester) async {
    final repo = _FakeSubscriptionRepository(
      subscription: const SubscriptionModel(status: SubscriptionModel.statusExpired),
      plans: _plans,
    );
    await _pump(tester, repo, fromGate: false);

    expect(find.text('Sign Out'), findsNothing);
  });

  testWidgets(
      'tapping Subscribe when checkout is unavailable shows an error snackbar '
      'without crashing (no url_launcher platform call reached)', (tester) async {
    final repo = _FakeSubscriptionRepository(
      subscription: const SubscriptionModel(status: SubscriptionModel.statusTrialing),
      plans: _plans,
      checkoutUrl: null,
    );
    await _pump(tester, repo);

    await tester.tap(find.text('Subscribe').first);
    // Deliberately not pumpAndSettle(): AppSnackBar uses the default
    // SnackBar auto-dismiss timer, and settling would pump straight through
    // its whole show-then-hide cycle. Same bounded-pump pattern as
    // test/payment_screen_test.dart's snackbar assertions.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(tester.takeException(), isNull);
    expect(repo.checkoutCallCount, 1);
    expect(repo.lastCheckoutPlan, SubscriptionPlanModel.basic);
    expect(find.textContaining('available'), findsWidgets);
  });

  testWidgets('error loading subscription shows a retry state', (tester) async {
    final repo = _ThrowingSubscriptionRepository();
    await _pump(tester, repo);

    expect(find.text('Retry'), findsOneWidget);
  });
}

class _ThrowingSubscriptionRepository extends _FakeSubscriptionRepository {
  @override
  Future<SubscriptionModel> getSubscription() async {
    throw const ServerException(500);
  }
}
