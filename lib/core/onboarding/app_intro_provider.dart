import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Whether the first-install welcome carousel has already been seen.
///
/// The real value is loaded from [SecureStorage] in `main()` *before*
/// `runApp` (same preload pattern as `initLocale()`) and injected via a
/// `ProviderScope` override, so the router's redirect can rely on it from the
/// very first frame — no async race between flag loading and the first
/// navigation decision. The `false` here is only a fallback for containers
/// created without the override (e.g. tests).
///
/// Not to be confused with the doctor-profile `onboardingComplete` flag —
/// that is an unrelated feature.
final appIntroSeenProvider = StateProvider<bool>((ref) => false);
