import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/features/appointments/data/models/appointment_model.dart';
import 'package:medalize_mb/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:medalize_mb/features/auth/presentation/screens/login_screen.dart';
import 'package:medalize_mb/features/auth/presentation/screens/register_screen.dart';
import 'package:medalize_mb/features/auth/presentation/screens/reset_password_screen.dart';
import 'package:medalize_mb/features/auth/presentation/screens/splash_screen.dart';
import 'package:medalize_mb/features/auth/providers/auth_provider.dart';
import 'package:medalize_mb/features/auth/providers/auth_state.dart';
import 'package:medalize_mb/features/doctor/presentation/screens/add_edit_workplace_screen.dart';
import 'package:medalize_mb/features/doctor/presentation/screens/block_time_screen.dart';
import 'package:medalize_mb/features/doctor/presentation/screens/doctor_appointments_screen.dart';
import 'package:medalize_mb/features/doctor/presentation/screens/doctor_home_screen.dart';
import 'package:medalize_mb/features/doctor/presentation/screens/doctor_onboarding_screen.dart';
import 'package:medalize_mb/features/doctor/presentation/screens/doctor_pending_verification_screen.dart';
import 'package:medalize_mb/features/doctor/presentation/screens/working_hours_editor_screen.dart';
import 'package:medalize_mb/features/doctor/presentation/screens/workplace_list_screen.dart';
import 'package:medalize_mb/features/doctors/data/models/doctor_model.dart';
import 'package:medalize_mb/features/patient/presentation/screens/appointment_detail_screen.dart';
import 'package:medalize_mb/features/patient/presentation/screens/booking_calendar_screen.dart';
import 'package:medalize_mb/features/patient/presentation/screens/booking_confirm_screen.dart';
import 'package:medalize_mb/features/patient/presentation/screens/doctor_detail_screen.dart';
import 'package:medalize_mb/features/patient/presentation/screens/doctor_search_screen.dart';
import 'package:medalize_mb/features/patient/presentation/screens/my_appointments_screen.dart';
import 'package:medalize_mb/features/patient/presentation/screens/patient_home_screen.dart';
import 'package:medalize_mb/features/shared/presentation/screens/notifications_screen.dart';
import 'package:medalize_mb/features/shared/presentation/screens/profile_screen.dart';
import 'package:medalize_mb/features/shared/presentation/screens/settings_screen.dart';

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
        pageBuilder: (_, _) => _fadePage(const SplashScreen()),
      ),
      GoRoute(
        path: '/auth/login',
        pageBuilder: (_, _) => _authPage(const LoginScreen()),
      ),
      GoRoute(
        path: '/auth/register',
        pageBuilder: (_, _) => _authPage(const RegisterScreen()),
      ),
      GoRoute(
        path: '/auth/forgot-password',
        pageBuilder: (_, _) => _authPage(const ForgotPasswordScreen()),
      ),
      GoRoute(
        path: '/auth/reset-password',
        pageBuilder: (_, state) {
          final email = state.extra as String? ?? '';
          return _authPage(ResetPasswordScreen(email: email));
        },
      ),

      // Patient routes
      GoRoute(
        path: '/patient/home',
        builder: (_, _) => const PatientHomeScreen(),
      ),
      GoRoute(
        path: '/patient/appointments',
        builder: (_, _) => const MyAppointmentsScreen(),
      ),
      GoRoute(
        path: '/patient/appointment-detail/:id',
        builder: (_, state) {
          final appt = state.extra as AppointmentModel;
          return AppointmentDetailScreen(appointment: appt);
        },
      ),
      GoRoute(
        path: '/patient/doctor-search',
        builder: (_, _) => const DoctorSearchScreen(),
      ),
      GoRoute(
        path: '/patient/doctor-detail/:id',
        builder: (_, state) {
          final extra = state.extra as DoctorModel?;
          return DoctorDetailScreen(
            doctorId: state.pathParameters['id']!,
            doctor: extra,
          );
        },
      ),
      GoRoute(
        path: '/patient/booking-calendar/:id',
        builder: (_, state) {
          final doctor = state.extra as DoctorDetailModel;
          return BookingCalendarScreen(doctor: doctor);
        },
      ),
      GoRoute(
        path: '/patient/booking-confirm',
        builder: (_, state) {
          final extra = state.extra as Map<String, dynamic>;
          return BookingConfirmScreen(
            doctor: extra['doctor'] as DoctorDetailModel,
            slot: extra['slot'] as SlotModel,
            workplaceId: extra['workplaceId'] as String,
          );
        },
      ),

      // Doctor routes
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
      GoRoute(
        path: '/doctor/appointments',
        builder: (_, _) => const DoctorAppointmentsScreen(),
      ),
      GoRoute(
        path: '/doctor/workplaces',
        builder: (_, _) => const WorkplaceListScreen(),
      ),
      GoRoute(
        path: '/doctor/add-workplace',
        builder: (_, _) => const AddEditWorkplaceScreen(),
      ),
      GoRoute(
        path: '/doctor/edit-workplace/:id',
        builder: (_, state) {
          final existing = state.extra as Map<String, dynamic>;
          return AddEditWorkplaceScreen(existing: existing);
        },
      ),
      GoRoute(
        path: '/doctor/working-hours/:workplaceId',
        builder: (_, state) =>
            WorkingHoursEditorScreen(workplaceId: state.pathParameters['workplaceId']!),
      ),
      GoRoute(
        path: '/doctor/block-time',
        builder: (_, _) => const BlockTimeScreen(),
      ),

      // Shared routes
      GoRoute(
        path: '/shared/profile',
        builder: (_, _) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/shared/notifications',
        builder: (_, _) => const NotificationsScreen(),
      ),
      GoRoute(
        path: '/shared/settings',
        builder: (_, _) => const SettingsScreen(),
      ),
    ],
  );
});

/// Auth pages: fade + subtle upward slide (matches the card entrance animation).
CustomTransitionPage<void> _authPage(Widget child) {
  return CustomTransitionPage<void>(
    child: child,
    transitionDuration: const Duration(milliseconds: 380),
    reverseTransitionDuration: const Duration(milliseconds: 280),
    transitionsBuilder: (_, animation, _, child) {
      final curved = CurvedAnimation(parent: animation, curve: Curves.easeOut);
      return FadeTransition(
        opacity: curved,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.04),
            end: Offset.zero,
          ).animate(curved),
          child: child,
        ),
      );
    },
  );
}

/// Splash: plain fade (no slide — it's the root page).
CustomTransitionPage<void> _fadePage(Widget child) {
  return CustomTransitionPage<void>(
    child: child,
    transitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (_, animation, _, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}

String _homeFor(String role, bool onboardingComplete, bool? isVerified) {
  if (role == 'patient') return '/patient/home';
  if (!onboardingComplete) return '/doctor/onboarding';
  if (isVerified != true) return '/doctor/pending-verification';
  return '/doctor/home';
}

String? _redirect(AuthState auth, String location) {
  return switch (auth) {
    // Still initialising — stay on splash, push everything else there
    AuthInitial() => location == '/splash' ? null : '/splash',

    // User-triggered auth in progress — stay on current screen (login/register)
    // so ref.listen callbacks fire correctly on the same widget instance
    AuthLoading() => null,

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
