import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/locale/language_sync.dart';
import 'package:medalize_mb/core/locale/locale_provider.dart';
import 'package:medalize_mb/core/storage/secure_storage.dart';
import 'package:medalize_mb/features/auth/data/repository/auth_repository.dart';
import 'package:medalize_mb/features/auth/providers/auth_provider.dart';
import 'package:medalize_mb/features/auth/providers/auth_state.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

/// Captures `updateLanguage` calls (the `PATCH /auth/me/ {language}` sync)
/// and can simulate a network failure.
class _FakeAuthRepository extends AuthRepository {
  _FakeAuthRepository({this.failing = false}) : super(Dio());

  bool failing;
  final languageUpdates = <String>[];

  @override
  Future<void> updateLanguage(String code) async {
    if (failing) throw const NetworkException();
    languageUpdates.add(code);
  }
}

/// Pins the auth state without AuthNotifier's cold-start `_init` side effects.
class _FakeAuthNotifier extends AuthNotifier {
  _FakeAuthNotifier(this._fixed);

  final AuthState _fixed;

  @override
  AuthState build() => _fixed;
}

const _authed = AuthAuthenticated(
  accessToken: 'access',
  refreshToken: 'refresh',
  role: 'patient',
  userId: 'u-1',
  email: 'user@example.com',
  onboardingComplete: true,
);

/// Exposes a [Ref] so the standalone sync helpers can be exercised directly.
final _refProvider = Provider<Ref>((ref) => ref);

ProviderContainer _container({
  required AuthState auth,
  required _FakeAuthRepository repo,
}) {
  final container = ProviderContainer(overrides: [
    authProvider.overrideWith(() => _FakeAuthNotifier(auth)),
    authRepositoryProvider.overrideWithValue(repo),
  ]);
  addTearDown(container.dispose);
  return container;
}

/// Waits out the fire-and-forget backend sync scheduled by [setLocale].
Future<void> _settle() => pumpEventQueue();

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    FlutterSecureStorage.setMockInitialValues({});
  });

  group('resolveBackendLanguageCode', () {
    test('passes a concrete saved code through unchanged', () {
      expect(resolveBackendLanguageCode('ru'), 'ru');
      expect(resolveBackendLanguageCode('az'), 'az');
    });

    test('resolves "system" and null to the device locale, never "system"',
        () {
      final device = AppLocaleUtils.findDeviceLocale().languageCode;
      expect(resolveBackendLanguageCode(systemLanguageSentinel), device);
      expect(resolveBackendLanguageCode(null), device);
      expect(resolveBackendLanguageCode(systemLanguageSentinel),
          isNot(systemLanguageSentinel));
      expect(AppLocale.values.map((l) => l.languageCode),
          contains(resolveBackendLanguageCode(null)));
    });
  });

  group('LocaleNotifier.setLocale backend sync', () {
    test('an explicit choice PATCHes the language code when signed in',
        () async {
      final repo = _FakeAuthRepository();
      final container = _container(auth: _authed, repo: repo);

      await container.read(localeProvider.notifier).setLocale(AppLocale.ru);
      await _settle();

      expect(repo.languageUpdates, ['ru']);
      expect(container.read(localeProvider), AppLocale.ru);
      expect(await SecureStorage().getLanguage(), 'ru');
    });

    test('choosing "system" sends the resolved device code, not "system"',
        () async {
      final repo = _FakeAuthRepository();
      final container = _container(auth: _authed, repo: repo);

      await container.read(localeProvider.notifier).setLocale(null);
      await _settle();

      expect(repo.languageUpdates,
          [AppLocaleUtils.findDeviceLocale().languageCode]);
      expect(repo.languageUpdates.single, isNot(systemLanguageSentinel));
      expect(await SecureStorage().getLanguage(), systemLanguageSentinel);
    });

    test('no PATCH (and no crash) when the user is not signed in', () async {
      final repo = _FakeAuthRepository();
      final container =
          _container(auth: const AuthUnauthenticated(), repo: repo);

      await container.read(localeProvider.notifier).setLocale(AppLocale.fr);
      await _settle();

      expect(repo.languageUpdates, isEmpty);
      // The local switch still went through.
      expect(container.read(localeProvider), AppLocale.fr);
      expect(await SecureStorage().getLanguage(), 'fr');
    });

    test('a network failure does not block or roll back the local switch',
        () async {
      final repo = _FakeAuthRepository(failing: true);
      final container = _container(auth: _authed, repo: repo);

      await container.read(localeProvider.notifier).setLocale(AppLocale.tr);
      await _settle();

      expect(repo.languageUpdates, isEmpty);
      expect(container.read(localeProvider), AppLocale.tr);
      expect(await SecureStorage().getLanguage(), 'tr');
    });

    test('restoring the saved language at startup does not PATCH', () async {
      FlutterSecureStorage.setMockInitialValues({'app_language': 'ru'});
      final repo = _FakeAuthRepository();
      final container = _container(auth: _authed, repo: repo);

      container.read(localeProvider); // triggers the async _load()
      await _settle();

      expect(container.read(localeProvider), AppLocale.ru);
      expect(repo.languageUpdates, isEmpty);
    });
  });

  group('syncStoredLanguageToBackend (post-login sync)', () {
    test('sends the locally saved code after sign-in', () async {
      FlutterSecureStorage.setMockInitialValues({'app_language': 'az'});
      final repo = _FakeAuthRepository();
      final container = _container(auth: _authed, repo: repo);

      await syncStoredLanguageToBackend(container.read(_refProvider));

      expect(repo.languageUpdates, ['az']);
    });

    test('resolves a saved "system" preference to the device code', () async {
      FlutterSecureStorage.setMockInitialValues(
          {'app_language': systemLanguageSentinel});
      final repo = _FakeAuthRepository();
      final container = _container(auth: _authed, repo: repo);

      await syncStoredLanguageToBackend(container.read(_refProvider));

      expect(repo.languageUpdates,
          [AppLocaleUtils.findDeviceLocale().languageCode]);
    });

    test('swallows network failures instead of throwing', () async {
      final repo = _FakeAuthRepository(failing: true);
      final container = _container(auth: _authed, repo: repo);

      await expectLater(
        syncStoredLanguageToBackend(container.read(_refProvider)),
        completes,
      );
      expect(repo.languageUpdates, isEmpty);
    });
  });
}
