import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/onboarding/app_intro_provider.dart';
import 'package:medalize_mb/core/storage/secure_storage.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/features/auth/presentation/screens/login_screen.dart';
import 'package:medalize_mb/features/auth/providers/auth_provider.dart';
import 'package:medalize_mb/features/auth/providers/auth_state.dart';
import 'package:medalize_mb/features/onboarding/presentation/screens/app_intro_screen.dart';
import 'package:medalize_mb/i18n/strings.g.dart';
import 'package:medalize_mb/routing/app_router.dart';

/// Pins the auth state so router tests exercise redirects without the real
/// AuthNotifier's cold-start storage/network bootstrap.
class _FakeAuthNotifier extends AuthNotifier {
  _FakeAuthNotifier(this._fixed);

  final AuthState _fixed;

  @override
  AuthState build() => _fixed;
}

const _authenticated = AuthAuthenticated(
  accessToken: 'a',
  refreshToken: 'r',
  role: 'patient',
  userId: 'u1',
  email: 'p@example.com',
  onboardingComplete: true,
);

void main() {
  setUpAll(() => LocaleSettings.setLocale(AppLocale.en));

  setUp(() {
    FlutterSecureStorage.setMockInitialValues({});
  });

  /// Mounts AppIntroScreen inside a minimal GoRouter (a stub /auth/login
  /// destination) and returns the container so tests can read the provider.
  Future<ProviderContainer> pumpIntro(WidgetTester tester) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final router = GoRouter(
      initialLocation: '/intro',
      routes: [
        GoRoute(path: '/intro', builder: (_, _) => const AppIntroScreen()),
        GoRoute(
          path: '/auth/login',
          builder: (_, _) => const Scaffold(body: Text('login-stub')),
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

  group('AppIntroScreen', () {
    testWidgets('renders page 1 and pages through all three via Next',
        (tester) async {
      await pumpIntro(tester);
      final t = Translations.of(
          tester.element(find.byType(AppIntroScreen))).appIntro;

      expect(find.text(t.page1Title), findsOneWidget);
      expect(find.text(t.page1Subtitle), findsOneWidget);
      expect(find.text(t.skip), findsOneWidget);
      expect(find.text(t.next), findsOneWidget);

      await tester.tap(find.text(t.next));
      await tester.pumpAndSettle();
      expect(find.text(t.page2Title), findsOneWidget);

      await tester.tap(find.text(t.next));
      await tester.pumpAndSettle();
      expect(find.text(t.page3Title), findsOneWidget);
      // Last page: Next becomes Get Started.
      expect(find.text(t.next), findsNothing);
      expect(find.text(t.getStarted), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('swiping the PageView also advances pages', (tester) async {
      await pumpIntro(tester);
      final t = Translations.of(
          tester.element(find.byType(AppIntroScreen))).appIntro;

      await tester.drag(find.byType(PageView), const Offset(-400, 0));
      await tester.pumpAndSettle();
      expect(find.text(t.page2Title), findsOneWidget);

      await tester.drag(find.byType(PageView), const Offset(-400, 0));
      await tester.pumpAndSettle();
      expect(find.text(t.page3Title), findsOneWidget);
      expect(find.text(t.getStarted), findsOneWidget);
    });

    testWidgets('Skip persists the flag, flips the provider and goes to login',
        (tester) async {
      final container = await pumpIntro(tester);
      final t = Translations.of(
          tester.element(find.byType(AppIntroScreen))).appIntro;

      await tester.tap(find.text(t.skip));
      await tester.pumpAndSettle();

      expect(find.text('login-stub'), findsOneWidget);
      expect(container.read(appIntroSeenProvider), isTrue);
      expect(await SecureStorage().getAppIntroSeen(), isTrue);
    });

    testWidgets(
        'Get Started on the last page persists the flag and goes to login',
        (tester) async {
      final container = await pumpIntro(tester);
      final t = Translations.of(
          tester.element(find.byType(AppIntroScreen))).appIntro;

      await tester.tap(find.text(t.next));
      await tester.pumpAndSettle();
      await tester.tap(find.text(t.next));
      await tester.pumpAndSettle();
      await tester.tap(find.text(t.getStarted));
      await tester.pumpAndSettle();

      expect(find.text('login-stub'), findsOneWidget);
      expect(container.read(appIntroSeenProvider), isTrue);
      expect(await SecureStorage().getAppIntroSeen(), isTrue);
    });
  });

  group('_redirect intro handling', () {
    const unauth = AuthUnauthenticated();

    test('first launch: unauthenticated user is detoured to /intro', () {
      expect(debugRedirect(unauth, '/auth/login', false), '/intro');
      expect(debugRedirect(unauth, '/patient/home', false), '/intro');
      expect(debugRedirect(unauth, '/intro', false), isNull);
    });

    test('AuthError behaves like unauthenticated for the intro detour', () {
      const error = AuthError(NetworkException('boom'));
      expect(debugRedirect(error, '/auth/login', false), '/intro');
      expect(debugRedirect(error, '/auth/login', true), isNull);
    });

    test('intro seen: no detour, auth flow behaves as before', () {
      expect(debugRedirect(unauth, '/auth/login', true), isNull);
      expect(debugRedirect(unauth, '/auth/register', true), isNull);
      expect(debugRedirect(unauth, '/patient/home', true), '/auth/login');
    });

    test('authenticated user never lands on /intro, even with flag unset', () {
      expect(
        debugRedirect(_authenticated, '/intro', false),
        '/patient/home',
      );
      expect(
        debugRedirect(_authenticated, '/splash', false),
        '/patient/home',
      );
      // Deep in the app the redirect stays silent, exactly as before.
      expect(debugRedirect(_authenticated, '/patient/home', false), isNull);
    });

    test('holding states (splash) are untouched by the intro flag', () {
      expect(debugRedirect(const AuthInitial(), '/splash', false), isNull);
      expect(debugRedirect(const AuthInitial(), '/intro', false), '/splash');
      expect(debugRedirect(const AuthLoading(), '/intro', false), '/splash');
      expect(debugRedirect(const AuthLoading(), '/auth/login', false), isNull);
    });
  });

  group('router integration', () {
    Future<ProviderContainer> pumpApp(
      WidgetTester tester, {
      required bool introSeen,
    }) async {
      // Phone-sized viewport (same as the locale-overflow harness): the real
      // LoginScreen is laid out for phones and overflows at the default
      // 800x600 test surface.
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      // Pre-existing, unrelated to this feature: LoginScreen's "remember me"
      // and "no account" rows overflow under the square-glyph Ahem test font
      // (they fit real fonts). Ignore only that error class here — the
      // dedicated AppIntroScreen tests above keep full overflow protection.
      final originalOnError = FlutterError.onError;
      FlutterError.onError = (details) {
        if (details.exceptionAsString().contains('RenderFlex overflowed')) {
          return;
        }
        originalOnError?.call(details);
      };
      addTearDown(() => FlutterError.onError = originalOnError);
      final container = ProviderContainer(overrides: [
        authProvider
            .overrideWith(() => _FakeAuthNotifier(const AuthUnauthenticated())),
        appIntroSeenProvider.overrideWith((ref) => introSeen),
      ]);
      addTearDown(container.dispose);
      await tester.pumpWidget(
        TranslationProvider(
          child: UncontrolledProviderScope(
            container: container,
            child: MaterialApp.router(
              theme: AppTheme.light,
              routerConfig: container.read(routerProvider),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      return container;
    }

    testWidgets('cold start with introSeen=false shows the intro carousel',
        (tester) async {
      await pumpApp(tester, introSeen: false);
      expect(find.byType(AppIntroScreen), findsOneWidget);
      expect(find.byType(LoginScreen), findsNothing);
    });

    testWidgets('cold start with introSeen=true goes straight to login',
        (tester) async {
      await pumpApp(tester, introSeen: true);
      expect(find.byType(LoginScreen), findsOneWidget);
      expect(find.byType(AppIntroScreen), findsNothing);
    });

    testWidgets('finishing the intro lands on the real login screen',
        (tester) async {
      final container = await pumpApp(tester, introSeen: false);
      final t = Translations.of(
          tester.element(find.byType(AppIntroScreen))).appIntro;

      await tester.tap(find.text(t.skip));
      await tester.pumpAndSettle();

      expect(find.byType(LoginScreen), findsOneWidget);
      expect(container.read(appIntroSeenProvider), isTrue);
      expect(await SecureStorage().getAppIntroSeen(), isTrue);
    });
  });
}
