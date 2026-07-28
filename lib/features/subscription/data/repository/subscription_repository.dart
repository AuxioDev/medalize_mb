import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/network/dio_client.dart';
import 'package:medalize_mb/features/subscription/data/models/subscription_model.dart';

final subscriptionRepositoryProvider = Provider<SubscriptionRepository>(
  (ref) => SubscriptionRepository(ref.read(dioClientProvider)),
);

/// Thrown by [SubscriptionRepository.checkout] on a 503 — Payriff has no
/// merchant credentials configured in this environment. Same convention as
/// `PaymentUnavailableException`: deliberately not an [ApiException], since
/// callers must handle "checkout isn't available right now" distinctly from
/// a normal error (e.g. hide the paywall CTA instead of showing a snackbar).
class SubscriptionUnavailableException implements Exception {
  const SubscriptionUnavailableException();
}

class SubscriptionRepository {
  SubscriptionRepository(this._dio);
  final Dio _dio;

  Future<SubscriptionModel> getSubscription() async {
    try {
      final res = await _dio.get('/doctor/subscription/');
      return SubscriptionModel.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  Future<List<SubscriptionPlanModel>> getPlans() async {
    try {
      final res = await _dio.get('/doctor/subscription/plans/');
      return (res.data as List)
          .map((e) => SubscriptionPlanModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  /// Opens a Payriff checkout order for [plan] and returns the hosted
  /// checkout URL to launch in an external browser.
  Future<String> checkout(String plan) async {
    try {
      final res = await _dio.post(
        '/doctor/subscription/checkout/',
        data: {'plan': plan},
      );
      return (res.data as Map<String, dynamic>)['payment_url'] as String;
    } on DioException catch (e) {
      if (e.response?.statusCode == 503) {
        throw const SubscriptionUnavailableException();
      }
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }
}
