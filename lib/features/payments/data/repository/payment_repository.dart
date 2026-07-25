import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/network/dio_client.dart';
import 'package:medalize_mb/features/payments/data/models/payment_model.dart';

final paymentRepositoryProvider = Provider<PaymentRepository>(
  (ref) => PaymentRepository(ref.read(dioClientProvider)),
);

/// Thrown by [PaymentRepository.createPayment] when the backend answers 503
/// — Payriff has no merchant credentials configured in this environment.
/// This is the expected, common state in dev/staging (see
/// `PayriffProvider` on the backend) and is deliberately **not** an
/// [ApiException]: payment is an optional add-on to booking, never a user
/// facing error. Callers must catch this and silently skip the payment step
/// — the booking success flow renders exactly as if payments didn't exist.
class PaymentUnavailableException implements Exception {
  const PaymentUnavailableException();
}

class PaymentRepository {
  PaymentRepository(this._dio);
  final Dio _dio;

  /// `null` means no payment has been created yet for this appointment — not
  /// an error (mirrors `PrescriptionRepository.getPrescriptionForAppointment`).
  Future<PaymentModel?> getPayment(String appointmentId) async {
    try {
      final res = await _dio.get('/appointments/$appointmentId/payment/');
      return PaymentModel.fromJson(res.data as Map<String, dynamic>,
          appointmentIdFallback: appointmentId);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) return null;
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  /// Creates (or, server-side, idempotently reuses a still-`pending`) payment
  /// for [appointmentId]. Throws [PaymentUnavailableException] on a 503 —
  /// see its doc comment for why that's handled separately from
  /// [ApiException].
  Future<PaymentModel> createPayment(String appointmentId) async {
    try {
      final res = await _dio.post('/appointments/$appointmentId/payment/');
      return PaymentModel.fromJson(res.data as Map<String, dynamic>,
          appointmentIdFallback: appointmentId);
    } on DioException catch (e) {
      if (e.response?.statusCode == 503) throw const PaymentUnavailableException();
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }
}
