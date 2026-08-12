// Router redirect coverage for the hospital account type — _homeFor's
// allow-list gate (no trial: only trialing/active/past_due count as
// entitled, unlike the doctor branch's deny-list) and the pre-auth
// reachability of /hospital/registration. Mirrors the pattern in
// test/app_intro_test.dart's `_redirect intro handling` group.
import 'package:flutter_test/flutter_test.dart';
import 'package:medalize_mb/features/auth/providers/auth_state.dart';
import 'package:medalize_mb/routing/app_router.dart';

AuthAuthenticated _hospital({bool? isVerified, String? subscriptionStatus}) => AuthAuthenticated(
      accessToken: 'a',
      refreshToken: 'r',
      role: 'hospital',
      userId: 'h1',
      phone: '+994991234567',
      onboardingComplete: true,
      isVerified: isVerified,
      subscriptionStatus: subscriptionStatus,
    );

void main() {
  group('_homeFor hospital gate', () {
    test('unapproved (isVerified not true) always goes to pending-approval, '
        'regardless of subscription status', () {
      expect(
        debugRedirect(_hospital(isVerified: null), '/splash', true),
        '/hospital/pending-approval',
      );
      expect(
        debugRedirect(_hospital(isVerified: false), '/splash', true),
        '/hospital/pending-approval',
      );
      expect(
        debugRedirect(
          _hospital(isVerified: false, subscriptionStatus: 'active'),
          '/splash',
          true,
        ),
        '/hospital/pending-approval',
      );
    });

    test('approved but never subscribed (pending — no trial) goes to the paywall', () {
      expect(
        debugRedirect(
          _hospital(isVerified: true, subscriptionStatus: 'pending'),
          '/splash',
          true,
        ),
        '/hospital/subscription',
      );
      expect(
        debugRedirect(_hospital(isVerified: true, subscriptionStatus: null), '/splash', true),
        '/hospital/subscription',
      );
    });

    test('a (never-actually-occurring) trialing status is still treated as entitled', () {
      expect(
        debugRedirect(
          _hospital(isVerified: true, subscriptionStatus: 'trialing'),
          '/splash',
          true,
        ),
        '/hospital/home',
        reason: 'a hospital subscription can never actually be "trialing" in '
            'practice (see plans.TRIAL_ROLES — hospitals get no trial), but '
            'the allow-list includes it defensively/for symmetry with the '
            'doctor gate\'s own entitlement check — this pins that shape.',
      );
    });

    test('approved + active reaches the dashboard', () {
      expect(
        debugRedirect(_hospital(isVerified: true, subscriptionStatus: 'active'), '/splash', true),
        '/hospital/home',
      );
    });

    test('approved + past_due (grace window) still reaches the dashboard', () {
      expect(
        debugRedirect(
          _hospital(isVerified: true, subscriptionStatus: 'past_due'),
          '/splash',
          true,
        ),
        '/hospital/home',
      );
    });

    test('approved + expired is sent back to the paywall', () {
      expect(
        debugRedirect(
          _hospital(isVerified: true, subscriptionStatus: 'expired'),
          '/splash',
          true,
        ),
        '/hospital/subscription',
      );
    });

    test('deep in the dashboard, an already-entitled hospital is left alone', () {
      expect(
        debugRedirect(
          _hospital(isVerified: true, subscriptionStatus: 'active'),
          '/hospital/doctors',
          true,
        ),
        isNull,
      );
    });
  });

  group('/hospital/registration pre-auth reachability', () {
    const unauth = AuthUnauthenticated();

    test('unauthenticated: reachable, no redirect (unlike other non-auth paths)', () {
      expect(debugRedirect(unauth, '/hospital/registration', true), isNull);
      // Contrast: an arbitrary non-auth path still bounces to login.
      expect(debugRedirect(unauth, '/patient/home', true), '/auth/login');
    });

    test('AuthLoading (register() in flight) stays put instead of bouncing to splash', () {
      expect(debugRedirect(const AuthLoading(), '/hospital/registration', true), isNull);
    });

    test('first launch (intro not seen) still detours to /intro first', () {
      expect(debugRedirect(unauth, '/hospital/registration', false), '/intro');
    });

    test('successful registration+login redirects away to the right gate '
        'destination instead of leaving the user stranded on the form', () {
      expect(
        debugRedirect(_hospital(isVerified: null), '/hospital/registration', true),
        '/hospital/pending-approval',
      );
    });
  });
}
