import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medalize_mb/features/family/data/models/dependent_model.dart';
import 'package:medalize_mb/features/family/data/repository/family_repository.dart';

final dependentsProvider = FutureProvider<List<DependentModel>>((ref) {
  return ref.watch(familyRepositoryProvider).getDependents();
});

/// Which profile new bookings/medications/records are created for.
/// `null` = "myself" (the signed-in account holder, the default); non-null =
/// the selected family member.
///
/// Deliberately a plain `StateProvider` with a `null` default and nothing
/// else — this is **session-only** state, not persisted to `SecureStorage`
/// and never overridden in `main.dart` (contrast with `appIntroSeenProvider`
/// in `core/onboarding/app_intro_provider.dart`, which *is* preloaded from
/// storage and injected via an override — that pattern intentionally does
/// NOT apply here). Every app restart resets the active profile back to
/// "myself", by design: a patient should never be silently left mid-session
/// on a family member's profile after reopening the app.
final activeProfileProvider = StateProvider<DependentModel?>((ref) => null);
