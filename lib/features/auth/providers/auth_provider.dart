import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/locale/language_sync.dart';
import 'package:medalize_mb/core/network/dio_client.dart';
import 'package:medalize_mb/core/security/biometric_service.dart';
import 'package:medalize_mb/core/services/device_identity.dart';
import 'package:medalize_mb/core/services/fcm_service.dart';
import 'package:medalize_mb/core/storage/secure_storage.dart';
import 'package:medalize_mb/features/auth/data/models/login_request.dart';
import 'package:medalize_mb/features/auth/data/models/login_response.dart';
import 'package:medalize_mb/features/auth/data/models/register_request.dart';
import 'package:medalize_mb/features/auth/data/repository/auth_repository.dart';
import 'package:medalize_mb/features/auth/data/social_auth_service.dart';
import 'package:medalize_mb/features/auth/providers/auth_state.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

final authProvider = NotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);

/// Session is only re-locked behind the biometric gate if the app spent at
/// least this long in the background — a quick app-switcher glance or an
/// incoming-call interruption shouldn't force a re-prompt every time.
const _biometricGateThreshold = Duration(minutes: 1);

class AuthNotifier extends Notifier<AuthState> {
  DateTime? _backgroundedAt;

  @override
  AuthState build() {
    Future(_init);
    return const AuthInitial();
  }

  SecureStorage get _storage => ref.read(secureStorageProvider);
  AuthRepository get _repo => ref.read(authRepositoryProvider);

  /// Records the moment the app is backgrounded; see [handleAppResumed].
  void handleAppPaused() {
    _backgroundedAt = DateTime.now();
  }

  /// Re-gates the already-restored session behind biometrics after a long
  /// enough time in the background. A failed/unavailable check locally locks
  /// the session (falls back to the regular login screen) — it never touches
  /// the server or the stored tokens, so a normal sign-in (or the next
  /// successful biometric check on relaunch) restores access.
  Future<void> handleAppResumed() async {
    final backgroundedAt = _backgroundedAt;
    _backgroundedAt = null;
    if (backgroundedAt == null) return;
    if (state is! AuthAuthenticated) return;
    if (DateTime.now().difference(backgroundedAt) < _biometricGateThreshold) {
      return;
    }
    if (await _biometricGateFails()) {
      state = const AuthUnauthenticated();
    }
  }

  /// Checks the client-side biometric gate before a stored session is used.
  /// Returns `false` when the gate is off or the user passed it; `true` when
  /// it's on and the user failed it or biometrics are unavailable — callers
  /// must treat that as "do not restore the session".
  Future<bool> _biometricGateFails() async {
    final enabled = await _storage.getBiometricEnabled() ?? false;
    if (!enabled) return false;
    final biometric = ref.read(biometricServiceProvider);
    if (!await biometric.isSupported()) return true;
    final ok = await biometric.authenticate(t.security.biometricPrompt);
    return !ok;
  }

  Future<void> _init() async {
    final storedAccess = await _storage.getAccessToken();
    if (storedAccess == null) {
      state = const AuthUnauthenticated();
      return;
    }
    if (await _biometricGateFails()) {
      // Tokens stay in storage — only the automatic restore is skipped, so a
      // regular sign-in (or the next successful biometric check) still works.
      state = const AuthUnauthenticated();
      return;
    }
    try {
      final user = await _repo.getMe();
      // Re-read after getMe() — the interceptor may have refreshed the token
      // behind the scenes and saved new values to storage.
      final access = await _storage.getAccessToken() ?? storedAccess;
      final refresh = await _storage.getRefreshToken() ?? '';
      final onboardingComplete = user.onboardingComplete ?? (user.role == 'patient');
      await _storage.saveProfile(
        onboardingComplete: onboardingComplete,
        isVerified: user.isVerified,
        firstName: user.firstName,
        lastName: user.lastName,
      );
      state = AuthAuthenticated(
        accessToken: access,
        refreshToken: refresh,
        role: user.role,
        userId: user.userId,
        email: user.email,
        onboardingComplete: onboardingComplete,
        isVerified: user.isVerified,
        firstName: user.firstName,
        lastName: user.lastName,
      );
      // FCM must also be initialised on cold-start restoration, not only on
      // explicit login() — otherwise push tokens are never registered after
      // the app is restarted while the user is already authenticated.
      ref.read(fcmServiceProvider).init();
    } on ApiException catch (e) {
      // Only a genuine auth failure should wipe the session. A network/server
      // error (e.g. launching offline) must NOT log the user out — restore the
      // session from the profile persisted at login instead.
      if (_isAuthFailure(e)) {
        await _storage.clearAll();
        state = const AuthUnauthenticated();
      } else {
        state = await _restoreFromStorage(storedAccess);
        if (state is AuthAuthenticated) ref.read(fcmServiceProvider).init();
      }
    } catch (_) {
      state = await _restoreFromStorage(storedAccess);
    }
  }

  bool _isAuthFailure(ApiException e) =>
      e is TokenInvalidException ||
      e is TokenExpiredException ||
      e is TokenBlacklistedException ||
      e is InvalidCredentialsException ||
      e is PermissionDeniedException;

  /// Rebuilds an authenticated state from securely-stored identity + profile,
  /// used when the server is unreachable on cold start.
  Future<AuthState> _restoreFromStorage(String accessToken) async {
    final role = await _storage.getUserRole() ?? '';
    if (role.isEmpty) {
      await _storage.clearAll();
      return const AuthUnauthenticated();
    }
    return AuthAuthenticated(
      accessToken: accessToken,
      refreshToken: await _storage.getRefreshToken() ?? '',
      role: role,
      userId: await _storage.getUserId() ?? '',
      email: await _storage.getUserEmail() ?? '',
      onboardingComplete:
          await _storage.getOnboardingComplete() ?? (role == 'patient'),
      isVerified: await _storage.getIsVerified(),
      firstName: await _storage.getFirstName(),
      lastName: await _storage.getLastName(),
    );
  }

  /// Re-fetches the current user from the server and rebuilds the
  /// authenticated state. Used after a doctor completes onboarding so the
  /// updated `onboardingComplete` / `isVerified` flags drive routing.
  Future<void> refreshProfile() async {
    final s = state;
    if (s is! AuthAuthenticated) return;
    try {
      final user = await _repo.getMe();
      final access = await _storage.getAccessToken() ?? s.accessToken;
      final refresh = await _storage.getRefreshToken() ?? s.refreshToken;
      final onboardingComplete = user.onboardingComplete ?? (user.role == 'patient');
      await _storage.saveProfile(
        onboardingComplete: onboardingComplete,
        isVerified: user.isVerified,
        firstName: user.firstName,
        lastName: user.lastName,
      );
      state = AuthAuthenticated(
        accessToken: access,
        refreshToken: refresh,
        role: user.role,
        userId: user.userId,
        email: user.email,
        onboardingComplete: onboardingComplete,
        isVerified: user.isVerified,
        firstName: user.firstName,
        lastName: user.lastName,
      );
    } catch (_) {
      // Keep the existing state if the refresh fails.
    }
  }

  Future<void> login(
    String email,
    String password, {
    bool rememberMe = false,
  }) async {
    state = const AuthLoading();
    try {
      final device = await ref.read(deviceIdentityProvider).describe();
      final response = await _repo.login(
        LoginRequest(
          email: email,
          password: password,
          rememberMe: rememberMe,
          deviceId: device['device_id'],
          deviceName: device['device_name'],
          platform: device['platform'],
        ),
      );
      await _applyAuthResponse(response);
      ref.read(fcmServiceProvider).init();
    } on ApiException catch (e) {
      state = AuthError(e);
    }
  }

  /// Exchanges a Google id_token for our JWT pair. `null` from the SDK means
  /// the user cancelled the flow — that's not an error, so the screen simply
  /// returns to the sign-in form rather than showing a message.
  Future<void> loginWithGoogle() =>
      _socialLogin('google', () => ref.read(socialAuthServiceProvider).getGoogleIdToken());

  /// Same as [loginWithGoogle] but for Sign in with Apple (required by App
  /// Store guideline 4.8 alongside any third-party login).
  Future<void> loginWithApple() =>
      _socialLogin('apple', () => ref.read(socialAuthServiceProvider).getAppleIdToken());

  Future<void> _socialLogin(
    String provider,
    Future<String?> Function() getIdToken,
  ) async {
    state = const AuthLoading();
    try {
      final idToken = await getIdToken();
      if (idToken == null) {
        // User backed out of the native sheet — quietly return to the form.
        state = const AuthUnauthenticated();
        return;
      }
      final device = await ref.read(deviceIdentityProvider).describe();
      final response = await _repo.socialLogin(
        provider,
        idToken: idToken,
        device: device,
      );
      await _applyAuthResponse(response);
      ref.read(fcmServiceProvider).init();
    } on SocialAuthException {
      state = const AuthError(SocialAuthFailedException());
    } on ApiException catch (e) {
      state = AuthError(e);
    }
  }

  Future<void> _applyAuthResponse(LoginResponse response) async {
    await _storage.saveTokens(
      accessToken: response.access,
      refreshToken: response.refresh,
      role: response.role,
      userId: response.userId,
      email: response.email,
    );
    await _storage.saveProfile(
      onboardingComplete: response.onboardingComplete,
      isVerified: response.isVerified,
      firstName: response.firstName,
      lastName: response.lastName,
    );
    state = AuthAuthenticated(
      accessToken: response.access,
      refreshToken: response.refresh,
      role: response.role,
      userId: response.userId,
      email: response.email,
      onboardingComplete: response.onboardingComplete,
      isVerified: response.isVerified,
      firstName: response.firstName,
      lastName: response.lastName,
    );
    // Fire-and-forget: push the locally selected UI language to the backend
    // so a language chosen before signing in (stored only on-device until
    // now) is reflected in server-sent emails/notifications. Best-effort —
    // errors are logged inside and never affect the login flow.
    unawaited(syncStoredLanguageToBackend(ref));
  }

  Future<void> register({
    required String email,
    required String password,
    required String passwordConfirm,
    required String role,
    required String firstName,
    required String lastName,
    String phone = '',
  }) async {
    if (state is AuthLoading) return;
    state = const AuthLoading();
    try {
      await _repo.register(RegisterRequest(
        email: email,
        password: password,
        passwordConfirm: passwordConfirm,
        role: role,
        firstName: firstName,
        lastName: lastName,
        phone: phone,
      ));
      // API does not return tokens — auto-login after registration
      await login(email, password);
    } on ApiException catch (e) {
      state = AuthError(e);
    }
  }

  Future<void> logout() async {
    final s = state;
    if (s is! AuthAuthenticated) return;
    // Remove this device's push token first, while the access token is valid,
    // so notifications stop and don't leak to the next user of the device.
    await ref.read(fcmServiceProvider).deregisterToken();
    try {
      await _repo.logout(
        accessToken: s.accessToken,
        refreshToken: s.refreshToken,
      );
    } catch (_) {
      // Proceed with local logout even on API failure
    }
    await _storage.clearAll();
    state = const AuthUnauthenticated();
  }

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    if (state is! AuthAuthenticated) return;
    // Read from storage rather than state — the interceptor may have rotated
    // the refresh token since last login, making state.refreshToken stale.
    final refreshToken = await _storage.getRefreshToken() ?? '';
    await _repo.changePassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
      refreshToken: refreshToken,
    );
    // The server has now revoked all sessions — drop this device's push token
    // before wiping local state, then force local logout.
    await ref.read(fcmServiceProvider).deregisterToken();
    await _storage.clearAll();
    state = const AuthUnauthenticated();
  }

  Future<void> forceLogout() async {
    await _storage.clearAll();
    state = const AuthUnauthenticated();
  }

  void clearError() {
    if (state is AuthError) state = const AuthUnauthenticated();
  }
}
