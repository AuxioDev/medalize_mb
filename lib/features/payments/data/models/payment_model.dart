class PaymentModel {
  static const statusPending = 'pending';
  static const statusPaid = 'paid';
  static const statusFailed = 'failed';
  static const statusCancelled = 'cancelled';

  final String id;
  final String appointmentId;

  /// Kept as the raw decimal string from the backend (e.g. `"50.00"`) rather
  /// than parsed to a double — same convention as
  /// `DoctorModel.consultationFee`, avoids float rounding surprises for a
  /// value that's only ever displayed, never computed on client-side.
  final String amount;
  final String currency;
  final String status;
  final String paymentUrl;
  final DateTime? createdAt;
  final DateTime? paidAt;

  const PaymentModel({
    required this.id,
    this.appointmentId = '',
    this.amount = '0',
    this.currency = 'AZN',
    this.status = statusPending,
    this.paymentUrl = '',
    this.createdAt,
    this.paidAt,
  });

  bool get isPending => status == statusPending;
  bool get isPaid => status == statusPaid;
  bool get isFailed => status == statusFailed;
  bool get isCancelled => status == statusCancelled;

  /// [appointmentIdFallback] covers the `POST .../payment/` response, which
  /// (per the backend contract) returns only
  /// `{id, status, amount, currency, payment_url}` — no `appointment` field —
  /// since the caller already knows the id it just posted to.
  factory PaymentModel.fromJson(Map<String, dynamic> j, {String? appointmentIdFallback}) =>
      PaymentModel(
        id: j['id'] as String,
        appointmentId: j['appointment'] as String? ?? appointmentIdFallback ?? '',
        amount: j['amount']?.toString() ?? '0',
        currency: j['currency'] as String? ?? 'AZN',
        status: j['status'] as String? ?? statusPending,
        paymentUrl: j['payment_url'] as String? ?? '',
        createdAt:
            j['created_at'] != null ? DateTime.tryParse(j['created_at'] as String) : null,
        paidAt: j['paid_at'] != null ? DateTime.tryParse(j['paid_at'] as String) : null,
      );
}
