import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medalize_mb/features/family/data/models/dependent_model.dart';
import 'package:medalize_mb/features/family/data/repository/family_repository.dart';

/// `autoDispose`: holds the signed-in patient's own dependents — must not
/// survive a logout/login as another patient on a shared device. Disposed
/// once nothing is watching it, which the auth redirect guarantees happens
/// on both logout and the next login (see `medicationsProvider` for the
/// full rationale).
final dependentsProvider = FutureProvider.autoDispose<List<DependentModel>>((ref) {
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
///
/// `autoDispose`: the same reset must also happen across a logout/login on a
/// shared device without an app restart — otherwise the next patient to sign
/// in could inherit the previous patient's selected dependent. Disposed once
/// nothing is watching it (the auth redirect tears down every screen on both
/// logout and login), so it's recreated with its `null` default for the new
/// session.
final activeProfileProvider = StateProvider.autoDispose<DependentModel?>((ref) => null);
