import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medalize_mb/features/payments/data/models/payment_model.dart';
import 'package:medalize_mb/features/payments/data/repository/payment_repository.dart';

/// `null` (not an error) means the appointment has no payment yet. Backs both
/// the payment screen's initial load and the small status badge on the
/// appointment detail screen. `autoDispose`: a short-lived, per-screen read
/// rather than an app-wide cache — there's no value in keeping a payment
/// fetch alive once nothing is watching it.
final paymentProvider =
    FutureProvider.autoDispose.family<PaymentModel?, String>((ref, appointmentId) {
  return ref.watch(paymentRepositoryProvider).getPayment(appointmentId);
});

/// Re-fetches payment status on demand — e.g. when the app resumes after the
/// patient returns from the external Payriff checkout page in the browser.
/// Invalidating the cached future makes the next watch/read re-hit the
/// network instead of returning the stale cached value.
void refreshPaymentStatus(WidgetRef ref, String appointmentId) {
  ref.invalidate(paymentProvider(appointmentId));
}
