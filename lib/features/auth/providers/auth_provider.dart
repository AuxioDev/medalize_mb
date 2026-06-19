import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/network/dio_client.dart';
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
      state = AuthAuthenticated(
        accessToken: access,
        refreshToken: refresh,
        role: user.role,
        userId: user.userId,
        email: user.email,
        onboardingComplete: user.onboardingComplete ?? (user.role == 'patient'),
        isVerified: user.isVerified,
      );
    } catch (_) {
      await _storage.clearAll();
      state = const AuthUnauthenticated();
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
      state = AuthAuthenticated(
        accessToken: response.access,
        refreshToken: response.refresh,
        role: response.role,
        userId: response.userId,
        email: response.email,
        onboardingComplete: response.onboardingComplete,
        isVerified: response.isVerified,
      );
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
    // The refresh token is now blacklisted on the server — force local logout
    await _storage.clearAll();
    state = const AuthUnauthenticated();
  }

  void forceLogout() {
    _storage.clearAll();
    state = const AuthUnauthenticated();
  }

  void clearError() {
    if (state is AuthError) state = const AuthUnauthenticated();
  }
}
