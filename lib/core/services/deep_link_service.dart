import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medalize_mb/features/auth/providers/auth_provider.dart';
import 'package:medalize_mb/features/auth/providers/auth_state.dart';
import 'package:medalize_mb/routing/app_router.dart';

/// Handles incoming Universal Links (iOS) / App Links (Android) for shared
/// doctor/hospital profiles — QR_SHARE_PROFILE_PLAN.md Phase 3. Link shape:
/// `https://<domain>/<locale>/doctor/<id>` or `.../hospital/<id>` (see
/// medalize_web's `/[locale]/doctor/[id]` and `/[locale]/hospital/[id]`
/// pages, and medalize_mb's `ShareUrls`). The locale segment is the web
/// page's own concern — the app already renders in whichever language the
/// user picked, so it's simply skipped here.
///
/// Unrelated to the existing `medalize://` custom scheme (payment-browser
/// bounce-back only, see AndroidManifest.xml/Info.plist) — that one needs
/// no Dart-side handling at all.
class DeepLinkService {
  DeepLinkService(this._ref);

  final WidgetRef _ref;
  final _appLinks = AppLinks();
  StreamSubscription<Uri>? _subscription;

  Future<void> init() async {
    final initial = await _appLinks.getInitialLink();
    if (initial != null) _handle(initial);
    _subscription = _appLinks.uriLinkStream.listen(_handle);
  }

  void dispose() {
    _subscription?.cancel();
  }

  void _handle(Uri uri) {
    final target = targetRouteFor(uri);
    if (target == null) return;

    final router = _ref.read(routerProvider);
    if (_ref.read(authProvider) is AuthAuthenticated) {
      router.push(target);
    } else {
      // Not signed in yet: the router's own redirect already sends this
      // location to /auth/login (or /intro on first launch) on its own —
      // pushing now would just be immediately redirected away. Instead,
      // remember where to land once that gate clears.
      _ref.read(pendingDeepLinkProvider.notifier).state = target;
    }
  }

  /// The in-app route for an incoming link, or null if it doesn't match a
  /// shared doctor/hospital profile shape. Public (and static) purely so
  /// tests can pin the parsing rules without going through Riverpod/AppLinks.
  @visibleForTesting
  static String? targetRouteFor(Uri uri) {
    final segments = uri.pathSegments;
    if (segments.length < 3) return null;
    final kind = segments[segments.length - 2];
    final id = segments.last;
    if (id.isEmpty) return null;
    return switch (kind) {
      'doctor' => '/patient/doctor-detail/$id',
      'hospital' => '/patient/hospital-detail/$id',
      _ => null,
    };
  }
}
