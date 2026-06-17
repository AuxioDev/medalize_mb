import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:medalize_mb/features/auth/presentation/screens/login_screen.dart';
import 'package:medalize_mb/features/auth/presentation/screens/register_screen.dart';
import 'package:medalize_mb/features/auth/presentation/screens/splash_screen.dart';
import 'package:medalize_mb/features/auth/providers/auth_provider.dart';
import 'package:medalize_mb/features/auth/providers/auth_state.dart';
import 'package:medalize_mb/features/doctor/presentation/screens/doctor_home_screen.dart';
import 'package:medalize_mb/features/doctor/presentation/screens/doctor_onboarding_screen.dart';
import 'package:medalize_mb/features/doctor/presentation/screens/doctor_pending_verification_screen.dart';
import 'package:medalize_mb/features/patient/presentation/screens/patient_home_screen.dart';

final _authListenableProvider = Provider<_AuthChangeNotifier>((ref) {
  return _AuthChangeNotifier(ref);
});

class _AuthChangeNotifier extends ChangeNotifier {
  _AuthChangeNotifier(Ref ref) {
    ref.listen(authProvider, (_, _) => notifyListeners());
  }
}

final routerProvider = Provider<GoRouter>((ref) {
  final notifier = ref.watch(_authListenableProvider);

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: notifier,
    redirect: (context, state) =>
        _redirect(ref.read(authProvider), state.matchedLocation),
    routes: [
      GoRoute(
        path: '/splash',
        builder: (_, _) => const SplashScreen(),
      ),
      GoRoute(
        path: '/auth/login',
        builder: (_, _) => const LoginScreen(),
      ),
      GoRoute(
        path: '/auth/register',
        builder: (_, _) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/auth/forgot-password',
        builder: (_, _) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: '/patient/home',
        builder: (_, _) => const PatientHomeScreen(),
      ),
      GoRoute(
        path: '/doctor/home',
        builder: (_, _) => const DoctorHomeScreen(),
      ),
      GoRoute(
        path: '/doctor/onboarding',
        builder: (_, _) => const DoctorOnboardingScreen(),
      ),
      GoRoute(
        path: '/doctor/pending-verification',
        builder: (_, _) => const DoctorPendingVerificationScreen(),
      ),
    ],
  );
});

String _homeFor(String role, bool onboardingComplete, bool? isVerified) {
  if (role == 'patient') return '/patient/home';
  if (!onboardingComplete) return '/doctor/onboarding';
  if (isVerified != true) return '/doctor/pending-verification';
  return '/doctor/home';
}

String? _redirect(AuthState auth, String location) {
  return switch (auth) {
    // Still initialising — stay on splash, push everything else there
    AuthInitial() || AuthLoading() =>
      location == '/splash' ? null : '/splash',

    // Not authenticated — /auth/* pages are fine, everything else goes to login.
    // /splash is NOT exempt here: after init resolves to unauthenticated we
    // must leave the splash screen.
    AuthUnauthenticated() || AuthError() =>
      location.startsWith('/auth') ? null : '/auth/login',

    // Authenticated — push away from both /splash and /auth/* to the home
    // for this role. All other destinations are allowed through.
    AuthAuthenticated(
      :final role,
      :final onboardingComplete,
      :final isVerified,
    ) =>
      (location == '/splash' || location.startsWith('/auth'))
          ? _homeFor(role, onboardingComplete, isVerified)
          : null,
  };
}
