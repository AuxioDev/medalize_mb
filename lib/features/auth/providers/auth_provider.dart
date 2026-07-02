import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/network/dio_client.dart';
import 'package:medalize_mb/core/services/fcm_service.dart';
import 'package:medalize_mb/core/storage/secure_storage.dart';
import 'package:medalize_mb/features/auth/data/models/login_request.dart';
import 'package:medalize_mb/features/auth/data/models/register_request.dart';
import 'package:medalize_mb/features/auth/data/repository/auth_repository.dart';
import 'package:medalize_mb/features/auth/providers/auth_state.dart';

final authProvider = NotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    Future(_init);
    return const AuthInitial();
  }

  SecureStorage get _storage => ref.read(secureStorageProvider);
  AuthRepository get _repo => ref.read(authRepositoryProvider);

  Future<void> _init() async {
    final storedAccess = await _storage.getAccessToken();
    if (storedAccess == null) {
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
      final response = await _repo.login(
        LoginRequest(email: email, password: password, rememberMe: rememberMe),
      );
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
      ref.read(fcmServiceProvider).init();
    } on ApiException catch (e) {
      state = AuthError(e);
    }
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
