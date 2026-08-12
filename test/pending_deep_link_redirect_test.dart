// _redirect's pendingLink branch (QR_SHARE_PROFILE_PLAN.md Phase 3) — a
// Universal/App Link that arrived while signed out must not be dropped once
// the user finishes logging in. Mirrors the pattern in
// test/hospital_router_redirect_test.dart.
import 'package:flutter_test/flutter_test.dart';
import 'package:medalize_mb/features/auth/providers/auth_state.dart';
import 'package:medalize_mb/routing/app_router.dart';

const _patient = AuthAuthenticated(
  accessToken: 'a',
  refreshToken: 'r',
  role: 'patient',
  userId: 'p1',
  phone: '+994501234567',
  onboardingComplete: true,
);

void main() {
  group('pending deep link redirect', () {
    test('authenticated user landing on splash with a pending link goes '
        'there instead of the normal home screen', () {
      expect(
        debugRedirect(_patient, '/splash', true, '/patient/doctor-detail/d1'),
        '/patient/doctor-detail/d1',
      );
    });

    test('with no pending link, falls back to the normal home destination', () {
      expect(debugRedirect(_patient, '/splash', true), '/patient/home');
    });

    test('a pending link is only honored at the splash/pre-auth handoff, '
        'not for an arbitrary already-in-app location', () {
      expect(
        debugRedirect(
          _patient,
          '/patient/appointments',
          true,
          '/patient/doctor-detail/d1',
        ),
        isNull,
      );
    });

    test('unauthenticated: the pending link is remembered but the normal '
        'login gate still applies (no early bypass)', () {
      expect(
        debugRedirect(
          const AuthUnauthenticated(),
          '/patient/home',
          true,
          '/patient/doctor-detail/d1',
        ),
        '/auth/login',
      );
    });
  });
}
