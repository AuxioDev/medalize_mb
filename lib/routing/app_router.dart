import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/constants/user_roles.dart';
import 'package:medalize_mb/core/onboarding/app_intro_provider.dart';
import 'package:medalize_mb/features/appointments/data/models/appointment_model.dart';
import 'package:medalize_mb/features/assistant/data/models/assistant_models.dart';
import 'package:medalize_mb/features/assistant/presentation/screens/assistant_chat_screen.dart';
import 'package:medalize_mb/features/assistant/presentation/screens/assistant_conversations_screen.dart';
import 'package:medalize_mb/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:medalize_mb/features/auth/presentation/screens/login_screen.dart';
import 'package:medalize_mb/features/auth/presentation/screens/register_screen.dart';
import 'package:medalize_mb/features/auth/presentation/screens/reset_password_screen.dart';
import 'package:medalize_mb/features/auth/presentation/screens/social_complete_screen.dart';
import 'package:medalize_mb/features/auth/presentation/screens/splash_screen.dart';
import 'package:medalize_mb/features/auth/presentation/screens/verify_phone_screen.dart';
import 'package:medalize_mb/features/auth/providers/auth_provider.dart';
import 'package:medalize_mb/features/auth/providers/auth_state.dart';
import 'package:medalize_mb/features/doctor/presentation/screens/add_edit_workplace_screen.dart';
import 'package:medalize_mb/features/doctor/presentation/screens/block_time_screen.dart';
import 'package:medalize_mb/features/doctor/presentation/screens/doctor_agenda_screen.dart';
import 'package:medalize_mb/features/doctor/presentation/screens/doctor_appointments_screen.dart';
import 'package:medalize_mb/features/doctor/presentation/screens/doctor_home_screen.dart';
import 'package:medalize_mb/features/doctor/presentation/screens/doctor_onboarding_screen.dart';
import 'package:medalize_mb/features/doctor/presentation/screens/doctor_pending_verification_screen.dart';
import 'package:medalize_mb/features/doctor/presentation/screens/working_hours_editor_screen.dart';
import 'package:medalize_mb/features/doctor/presentation/screens/workplace_list_screen.dart';
import 'package:medalize_mb/features/doctor/presentation/screens/workplace_map_picker_screen.dart';
import 'package:medalize_mb/features/doctors/data/models/doctor_model.dart';
import 'package:medalize_mb/features/family/data/models/dependent_model.dart';
import 'package:medalize_mb/features/family/presentation/screens/add_edit_dependent_screen.dart';
import 'package:medalize_mb/features/family/presentation/screens/family_list_screen.dart';
import 'package:medalize_mb/features/hospital/data/models/hospital_link_model.dart';
import 'package:medalize_mb/features/hospital/presentation/screens/doctor_hospital_links_screen.dart';
import 'package:medalize_mb/features/hospital/presentation/screens/hospital_appointments_screen.dart';
import 'package:medalize_mb/features/hospital/presentation/screens/hospital_doctor_hours_screen.dart';
import 'package:medalize_mb/features/hospital/presentation/screens/hospital_doctors_screen.dart';
import 'package:medalize_mb/features/hospital/presentation/screens/hospital_home_screen.dart';
import 'package:medalize_mb/features/hospital/presentation/screens/hospital_invite_doctor_screen.dart';
import 'package:medalize_mb/features/hospital/presentation/screens/hospital_pending_approval_screen.dart';
import 'package:medalize_mb/features/hospital/presentation/screens/hospital_profile_screen.dart';
import 'package:medalize_mb/features/hospital/presentation/screens/hospital_registration_screen.dart';
import 'package:medalize_mb/features/medications/data/models/medication_model.dart';
import 'package:medalize_mb/features/medications/presentation/screens/add_edit_medication_screen.dart';
import 'package:medalize_mb/features/medications/presentation/screens/medication_list_screen.dart';
import 'package:medalize_mb/features/messaging/data/models/messaging_models.dart';
import 'package:medalize_mb/features/messaging/presentation/screens/thread_chat_screen.dart';
import 'package:medalize_mb/features/messaging/presentation/screens/thread_list_screen.dart';
import 'package:medalize_mb/features/onboarding/presentation/screens/app_intro_screen.dart';
import 'package:medalize_mb/features/payments/presentation/screens/payment_screen.dart';
import 'package:medalize_mb/features/prescriptions/presentation/screens/prescription_detail_screen.dart';
import 'package:medalize_mb/features/prescriptions/presentation/screens/prescription_list_screen.dart';
import 'package:medalize_mb/features/prescriptions/presentation/screens/write_prescription_screen.dart';
import 'package:medalize_mb/features/patient/presentation/screens/appointment_detail_screen.dart';
import 'package:medalize_mb/features/records/presentation/screens/records_list_screen.dart';
import 'package:medalize_mb/features/records/presentation/screens/upload_record_screen.dart';
import 'package:medalize_mb/features/patient/presentation/screens/booking_calendar_screen.dart';
import 'package:medalize_mb/features/patient/presentation/screens/booking_confirm_screen.dart';
import 'package:medalize_mb/features/patient/presentation/screens/doctor_detail_screen.dart';
import 'package:medalize_mb/features/patient/presentation/screens/doctor_search_screen.dart';
import 'package:medalize_mb/features/patient/presentation/screens/favorites_screen.dart';
import 'package:medalize_mb/features/patient/presentation/screens/my_appointments_screen.dart';
import 'package:medalize_mb/features/patient/presentation/screens/patient_home_screen.dart';
import 'package:medalize_mb/features/patient/presentation/screens/reschedule_calendar_screen.dart';
import 'package:medalize_mb/features/shared/presentation/screens/active_sessions_screen.dart';
import 'package:medalize_mb/features/shared/presentation/screens/change_phone_screen.dart';
import 'package:medalize_mb/features/shared/presentation/screens/legal_screen.dart';
import 'package:medalize_mb/features/shared/presentation/screens/notification_settings_screen.dart';
import 'package:medalize_mb/features/shared/presentation/screens/notifications_screen.dart';
import 'package:medalize_mb/features/shared/presentation/screens/profile_screen.dart';
import 'package:medalize_mb/features/shared/presentation/screens/security_screen.dart';
import 'package:medalize_mb/core/services/navigator_key.dart';
import 'package:medalize_mb/features/shared/presentation/screens/settings_screen.dart';
import 'package:medalize_mb/features/subscription/presentation/screens/subscription_screen.dart';

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
    navigatorKey: navigatorKey,
    initialLocation: '/splash',
    refreshListenable: notifier,
    redirect: (context, state) => _redirect(
      ref.read(authProvider),
      state.matchedLocation,
      ref.read(appIntroSeenProvider),
    ),
    routes: [
      GoRoute(
        path: '/splash',
        pageBuilder: (_, _) => _fadePage(const SplashScreen()),
      ),
      GoRoute(
        path: '/intro',
        pageBuilder: (_, _) => _fadePage(const AppIntroScreen()),
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
          final phone = state.extra as String? ?? '';
          return _authPage(ResetPasswordScreen(phone: phone));
        },
      ),
      GoRoute(
        path: '/auth/verify-phone',
        pageBuilder: (_, state) {
          final phone = state.extra as String? ?? '';
          return _authPage(VerifyPhoneScreen(phone: phone));
        },
      ),
      GoRoute(
        path: '/auth/social-complete',
        pageBuilder: (_, state) {
          final token = state.extra as String? ?? '';
          return _authPage(SocialCompleteScreen(pendingSocialToken: token));
        },
      ),
      GoRoute(
        path: '/hospital/registration',
        pageBuilder: (_, state) {
          final fields = state.extra as Map<String, dynamic>? ?? const {};
          return _authPage(HospitalRegistrationScreen(accountFields: fields));
        },
      ),
      GoRoute(
        path: '/hospital/pending-approval',
        pageBuilder: (_, _) => _fadePage(const HospitalPendingApprovalScreen()),
      ),
      GoRoute(
        path: '/hospital/subscription',
        pageBuilder: (_, state) {
          // Same fromGate convention as /doctor/subscription above.
          final fromGate = state.extra == null;
          return fromGate
              ? _fadePage(const SubscriptionScreen(fromGate: true))
              : _modalPage(const SubscriptionScreen(fromGate: false));
        },
      ),
      GoRoute(
        path: '/hospital/home',
        pageBuilder: (_, _) => _fadePage(const HospitalHomeScreen()),
      ),
      GoRoute(
        path: '/hospital/doctors',
        pageBuilder: (_, _) => _pushPage(const HospitalDoctorsScreen()),
      ),
      GoRoute(
        path: '/hospital/invite-doctor',
        pageBuilder: (_, _) => _modalPage(const HospitalInviteDoctorScreen()),
      ),
      GoRoute(
        path: '/hospital/doctors/:doctorId/hours',
        pageBuilder: (_, state) {
          final doctor = state.extra as DoctorBriefModel?;
          // Only reachable from the confirmed-doctors list, which always
          // passes the doctor via `extra`.
          if (doctor == null) {
            return _fadePage(const HospitalHomeScreen());
          }
          return _pushPage(HospitalDoctorHoursScreen(doctor: doctor));
        },
      ),
      GoRoute(
        path: '/hospital/appointments',
        pageBuilder: (_, _) => _pushPage(const HospitalAppointmentsScreen()),
      ),
      GoRoute(
        path: '/hospital/profile',
        pageBuilder: (_, _) => _pushPage(const HospitalProfileScreen()),
      ),

      // Patient routes
      GoRoute(
        path: '/patient/home',
        pageBuilder: (_, _) => _fadePage(const PatientHomeScreen()),
      ),
      GoRoute(
        path: '/patient/appointments',
        pageBuilder: (_, _) => _pushPage(const MyAppointmentsScreen()),
      ),
      GoRoute(
        path: '/patient/appointment-detail/:id',
        pageBuilder: (_, state) {
          final appt = state.extra as AppointmentModel?;
          final id = state.pathParameters['id']!;
          return _pushPage(AppointmentDetailLoader(
            appointmentId: id,
            appointment: appt,
          ));
        },
      ),
      GoRoute(
        path: '/patient/doctor-search',
        pageBuilder: (_, _) => _pushPage(const DoctorSearchScreen()),
      ),
      GoRoute(
        path: '/patient/favorites',
        pageBuilder: (_, _) => _pushPage(const FavoritesScreen()),
      ),
      GoRoute(
        path: '/patient/doctor-detail/:id',
        pageBuilder: (_, state) {
          final extra = state.extra as DoctorModel?;
          return _pushPage(DoctorDetailScreen(
            doctorId: state.pathParameters['id']!,
            doctor: extra,
          ));
        },
      ),
      GoRoute(
        path: '/patient/booking-calendar/:id',
        pageBuilder: (_, state) {
          final doctor = state.extra as DoctorDetailModel?;
          return _modalPage(BookingCalendarLoader(
            doctorId: state.pathParameters['id']!,
            doctor: doctor,
          ));
        },
      ),
      GoRoute(
        path: '/patient/booking-confirm',
        pageBuilder: (_, state) {
          final extra = state.extra as Map<String, dynamic>?;
          // extra is unavailable after app restoration — can't reconstruct
          // the booking slot, so redirect home instead of crashing.
          if (extra == null) {
            return _fadePage(const PatientHomeScreen());
          }
          return _modalPage(BookingConfirmScreen(
            doctor: extra['doctor'] as DoctorDetailModel,
            slot: extra['slot'] as SlotModel,
            workplaceId: extra['workplaceId'] as String,
          ));
        },
      ),

      GoRoute(
        path: '/patient/assistant',
        pageBuilder: (_, _) => _pushPage(const AssistantConversationsScreen()),
      ),
      GoRoute(
        path: '/patient/assistant/:id',
        pageBuilder: (_, state) {
          final convo = state.extra as ConversationModel?;
          return _pushPage(AssistantChatScreen(
            conversationId: state.pathParameters['id']!,
            conversation: convo,
          ));
        },
      ),
      GoRoute(
        path: '/patient/reschedule/:id',
        pageBuilder: (_, state) {
          final appt = state.extra as AppointmentModel?;
          return _modalPage(RescheduleCalendarLoader(
            appointmentId: state.pathParameters['id']!,
            appointment: appt,
          ));
        },
      ),

      // Medications (Phase 1, Section 1)
      GoRoute(
        path: '/patient/medications',
        pageBuilder: (_, _) => _pushPage(const MedicationListScreen()),
      ),
      GoRoute(
        path: '/patient/medications/:id/edit',
        pageBuilder: (_, state) {
          final existing = state.extra as MedicationModel?;
          // Only reachable from the medication list, which always passes the
          // model via `extra` — without it there's nothing to edit.
          if (existing == null) {
            return _pushPage(const MedicationListScreen());
          }
          return _modalPage(AddEditMedicationScreen(existing: existing));
        },
      ),

      // Prescriptions (Phase 1, Section 2)
      GoRoute(
        path: '/patient/prescriptions',
        pageBuilder: (_, _) => _pushPage(const PrescriptionListScreen()),
      ),
      GoRoute(
        path: '/patient/prescriptions/:id',
        pageBuilder: (_, state) => _pushPage(
          PrescriptionDetailScreen(prescriptionId: state.pathParameters['id']!),
        ),
      ),

      // Health records (Phase 1, Section 3)
      GoRoute(
        path: '/patient/records',
        pageBuilder: (_, _) => _pushPage(const RecordsListScreen()),
      ),
      GoRoute(
        path: '/patient/records/upload',
        pageBuilder: (_, _) => _modalPage(const UploadRecordScreen()),
      ),

      // Family profiles (Phase 4)
      GoRoute(
        path: '/patient/family',
        pageBuilder: (_, _) => _pushPage(const FamilyListScreen()),
      ),
      GoRoute(
        path: '/patient/family/add',
        pageBuilder: (_, _) => _modalPage(const AddEditDependentScreen()),
      ),
      GoRoute(
        path: '/patient/family/:id/edit',
        pageBuilder: (_, state) {
          final existing = state.extra as DependentModel?;
          // Only reachable from the family list, which always passes the
          // model via `extra` — without it there's nothing to edit.
          if (existing == null) {
            return _pushPage(const FamilyListScreen());
          }
          return _modalPage(AddEditDependentScreen(existing: existing));
        },
      ),

      // Messaging (Phase 2, Section 1)
      GoRoute(
        path: '/patient/messages',
        pageBuilder: (_, _) => _pushPage(const ThreadListScreen()),
      ),
      GoRoute(
        path: '/patient/messages/:id',
        pageBuilder: (_, state) {
          final thread = state.extra as ThreadModel?;
          return _pushPage(ThreadChatScreen(
            threadId: state.pathParameters['id']!,
            thread: thread,
          ));
        },
      ),

      // Payments (Phase 3, Section 1)
      GoRoute(
        path: '/patient/appointments/:id/payment',
        pageBuilder: (_, state) => _pushPage(
          PaymentScreen(appointmentId: state.pathParameters['id']!),
        ),
      ),

      // Doctor routes
      GoRoute(
        path: '/doctor/home',
        pageBuilder: (_, _) => _fadePage(const DoctorHomeScreen()),
      ),
      GoRoute(
        path: '/doctor/onboarding',
        pageBuilder: (_, _) => _fadePage(const DoctorOnboardingScreen()),
      ),
      GoRoute(
        path: '/doctor/pending-verification',
        pageBuilder: (_, _) => _fadePage(const DoctorPendingVerificationScreen()),
      ),
      GoRoute(
        path: '/doctor/subscription',
        pageBuilder: (_, state) {
          // The paywall gate (_homeFor) always pushes here with no `extra`;
          // a doctor opening it voluntarily from the profile screen passes
          // `fromGate: false` so the back button is shown instead of sign-out.
          final fromGate = state.extra == null;
          return fromGate
              ? _fadePage(const SubscriptionScreen(fromGate: true))
              : _modalPage(const SubscriptionScreen(fromGate: false));
        },
      ),
      GoRoute(
        path: '/doctor/appointments',
        pageBuilder: (_, _) => _pushPage(const DoctorAppointmentsScreen()),
      ),
      GoRoute(
        path: '/doctor/agenda',
        pageBuilder: (_, _) => _pushPage(const DoctorAgendaScreen()),
      ),
      GoRoute(
        path: '/doctor/appointment-detail/:id',
        pageBuilder: (_, state) {
          final appt = state.extra as AppointmentModel?;
          final id = state.pathParameters['id']!;
          return _pushPage(AppointmentDetailLoader(
            appointmentId: id,
            appointment: appt,
            asDoctor: true,
          ));
        },
      ),
      GoRoute(
        path: '/doctor/workplaces',
        pageBuilder: (_, _) => _pushPage(const WorkplaceListScreen()),
      ),
      GoRoute(
        path: '/doctor/hospital-links',
        pageBuilder: (_, _) => _pushPage(const DoctorHospitalLinksScreen()),
      ),
      GoRoute(
        path: '/doctor/add-workplace',
        pageBuilder: (_, _) => _modalPage(const AddEditWorkplaceScreen()),
      ),
      GoRoute(
        path: '/doctor/edit-workplace/:id',
        pageBuilder: (_, state) {
          final existing = state.extra as Map<String, dynamic>?;
          return _modalPage(EditWorkplaceLoader(
            workplaceId: state.pathParameters['id']!,
            existing: existing,
          ));
        },
      ),
      GoRoute(
        path: '/doctor/pick-workplace-location',
        pageBuilder: (_, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return _modalPage(WorkplaceMapPickerScreen(
            initialLat: extra?['lat'] as double?,
            initialLng: extra?['lng'] as double?,
          ));
        },
      ),
      GoRoute(
        path: '/doctor/working-hours/:workplaceId',
        pageBuilder: (_, state) => _pushPage(
          WorkingHoursEditorScreen(
              workplaceId: state.pathParameters['workplaceId']!),
        ),
      ),
      GoRoute(
        path: '/doctor/block-time',
        pageBuilder: (_, _) => _modalPage(const BlockTimeScreen()),
      ),
      GoRoute(
        path: '/doctor/write-prescription/:id',
        pageBuilder: (_, state) {
          final appt = state.extra as AppointmentModel?;
          // Only reachable from the appointment-detail screen, which always
          // passes the appointment via `extra`.
          if (appt == null) {
            return _fadePage(const DoctorHomeScreen());
          }
          return _modalPage(WritePrescriptionScreen(
            appointmentId: state.pathParameters['id']!,
            patientName: appt.patient.fullName,
          ));
        },
      ),

      // Messaging (Phase 2, Section 1)
      GoRoute(
        path: '/doctor/messages',
        pageBuilder: (_, _) => _pushPage(const ThreadListScreen()),
      ),
      GoRoute(
        path: '/doctor/messages/:id',
        pageBuilder: (_, state) {
          final thread = state.extra as ThreadModel?;
          return _pushPage(ThreadChatScreen(
            threadId: state.pathParameters['id']!,
            thread: thread,
          ));
        },
      ),

      // Shared routes
      GoRoute(
        path: '/shared/profile',
        pageBuilder: (_, _) => _pushPage(const ProfileScreen()),
      ),
      GoRoute(
        path: '/shared/security',
        pageBuilder: (_, _) => _pushPage(const SecurityScreen()),
      ),
      GoRoute(
        path: '/shared/active-sessions',
        pageBuilder: (_, _) => _pushPage(const ActiveSessionsScreen()),
      ),
      GoRoute(
        path: '/shared/change-phone',
        pageBuilder: (_, _) => _pushPage(const ChangePhoneScreen()),
      ),
      GoRoute(
        path: '/shared/notifications',
        pageBuilder: (_, _) => _pushPage(const NotificationsScreen()),
      ),
      GoRoute(
        path: '/shared/notification-settings',
        pageBuilder: (_, _) => _pushPage(const NotificationSettingsScreen()),
      ),
      GoRoute(
        path: '/shared/legal',
        pageBuilder: (_, _) => _pushPage(const LegalScreen()),
      ),
      GoRoute(
        path: '/shared/settings',
        pageBuilder: (_, _) => _pushPage(const SettingsScreen()),
      ),
    ],
  );
});

/// Root-level destination switch: fade + subtle scale-up.
CustomTransitionPage<void> _fadePage(Widget child) {
  return CustomTransitionPage<void>(
    child: child,
    transitionDuration: const Duration(milliseconds: 320),
    reverseTransitionDuration: const Duration(milliseconds: 220),
    transitionsBuilder: (_, animation, _, child) {
      final curved =
          CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
      return FadeTransition(
        opacity: curved,
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.96, end: 1.0).animate(curved),
          child: child,
        ),
      );
    },
  );
}

/// Auth screens: gentle fade + 4 % upward drift.
CustomTransitionPage<void> _authPage(Widget child) {
  return CustomTransitionPage<void>(
    child: child,
    transitionDuration: const Duration(milliseconds: 380),
    reverseTransitionDuration: const Duration(milliseconds: 280),
    transitionsBuilder: (_, animation, _, child) {
      final curved =
          CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
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

/// Drill-down navigation (list → detail): horizontal slide from right.
CustomTransitionPage<void> _pushPage(Widget child) {
  return CustomTransitionPage<void>(
    child: child,
    transitionDuration: const Duration(milliseconds: 300),
    reverseTransitionDuration: const Duration(milliseconds: 220),
    transitionsBuilder: (_, animation, _, child) {
      final curved =
          CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
      return FadeTransition(
        opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
              parent: animation, curve: const Interval(0.0, 0.5)),
        ),
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.06, 0),
            end: Offset.zero,
          ).animate(curved),
          child: child,
        ),
      );
    },
  );
}

/// Task / form flows: slides up from below with a subtle scale-in.
CustomTransitionPage<void> _modalPage(Widget child) {
  return CustomTransitionPage<void>(
    child: child,
    transitionDuration: const Duration(milliseconds: 380),
    reverseTransitionDuration: const Duration(milliseconds: 260),
    transitionsBuilder: (_, animation, _, child) {
      final curved =
          CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
      return FadeTransition(
        opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
              parent: animation, curve: const Interval(0.0, 0.5)),
        ),
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.08),
            end: Offset.zero,
          ).animate(curved),
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.96, end: 1.0).animate(curved),
            child: child,
          ),
        ),
      );
    },
  );
}

/// Hospital plans have no trial (see apps.subscriptions.plans.TRIAL_ROLES
/// on the backend) — approval goes straight to the paywall. So unlike the
/// doctor gate below (a deny-list: only `expired` blocks entry), this is
/// an allow-list: `pending` (approved but never checked out) must gate a
/// hospital, but must NOT gate a doctor, whose `pending` case is already
/// handled by the verification-screen branch above it.
bool _hospitalEntitled(String? status) =>
    status == 'trialing' || status == 'active' || status == 'past_due';

String _homeFor(
  String role,
  bool onboardingComplete,
  bool? isVerified,
  String? subscriptionStatus,
) {
  if (role == UserRole.patient) return '/patient/home';
  if (role == UserRole.hospital) {
    // Backend overloads is_verified with the hospital's claim-approval
    // state (claim_status == 'approved') specifically so this gate can
    // reuse the exact same field/branch shape as the doctor one below —
    // see apps.users.serializers.build_login_payload's hospital branch.
    if (isVerified != true) return '/hospital/pending-approval';
    if (!_hospitalEntitled(subscriptionStatus)) return '/hospital/subscription';
    return '/hospital/home';
  }
  if (!onboardingComplete) return '/doctor/onboarding';
  if (isVerified != true) return '/doctor/pending-verification';
  // Only `expired` (grace period exhausted) gates entry — `past_due` (still
  // in the 14-day grace window) and `trialing`/`active` all reach the normal
  // home screen, matching the backend's ENTITLED_STATUSES.
  if (subscriptionStatus == 'expired') return '/doctor/subscription';
  return '/doctor/home';
}

// Reachable while unauthenticated, alongside every '/auth/*' screen — the
// hospital registration flow's second step (picking/adding the hospital)
// runs entirely before any account or token exists, same as the register
// screen itself. See _redirect below.
bool _isPreAuthScreen(String location) =>
    location.startsWith('/auth') || location == '/hospital/registration';

String? _redirect(AuthState auth, String location, bool introSeen) {
  return switch (auth) {
    // Cold-start only: hold on splash until _init resolves.
    AuthInitial() => location == '/splash' ? null : '/splash',
    // In-flight login/register: stay on the current auth screen so the button
    // shows its spinner, the typed inputs are kept, and any resulting AuthError
    // renders inline instead of bouncing through splash to a fresh screen.
    AuthLoading() => _isPreAuthScreen(location) ? null : '/splash',
    // First install only: detour to the welcome carousel before login. Signed
    // in users never see it — the intro check lives in this branch alone.
    AuthUnauthenticated() || AuthError() => !introSeen && location != '/intro'
        ? '/intro'
        : (_isPreAuthScreen(location) || location == '/intro'
            ? null
            : '/auth/login'),
    AuthAuthenticated(
      :final role,
      :final onboardingComplete,
      :final isVerified,
      :final subscriptionStatus,
    ) =>
      (location == '/splash' || _isPreAuthScreen(location) || location == '/intro')
          ? _homeFor(role, onboardingComplete, isVerified, subscriptionStatus)
          : null,
  };
}

/// Test-only window onto the private [_redirect] decision table.
@visibleForTesting
String? debugRedirect(AuthState auth, String location, bool introSeen) =>
    _redirect(auth, location, introSeen);
