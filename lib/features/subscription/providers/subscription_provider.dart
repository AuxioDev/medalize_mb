import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medalize_mb/features/subscription/data/models/subscription_model.dart';
import 'package:medalize_mb/features/subscription/data/repository/subscription_repository.dart';

/// Backs the subscription screen and the home-screen trial/grace banner.
/// `autoDispose`: a short-lived, per-screen read rather than an app-wide
/// cache — same rationale as `paymentProvider`.
final subscriptionProvider = FutureProvider.autoDispose<SubscriptionModel>((ref) {
  return ref.watch(subscriptionRepositoryProvider).getSubscription();
});

final subscriptionPlansProvider =
    FutureProvider.autoDispose<List<SubscriptionPlanModel>>((ref) {
  return ref.watch(subscriptionRepositoryProvider).getPlans();
});

/// Re-fetches subscription status on demand — e.g. after the doctor returns
/// from the external Payriff checkout page in the browser.
void refreshSubscriptionStatus(WidgetRef ref) {
  ref.invalidate(subscriptionProvider);
}
