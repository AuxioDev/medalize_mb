import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medalize_mb/core/constants/user_roles.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/network/dio_client.dart';
import 'package:medalize_mb/features/auth/providers/auth_provider.dart';
import 'package:medalize_mb/features/auth/providers/auth_state.dart';
import 'package:medalize_mb/features/subscription/data/models/subscription_model.dart';

/// Derives its endpoint prefix from the signed-in role, so the one existing
/// provider (and everything downstream of it — subscriptionProvider,
/// subscriptionPlansProvider, SubscriptionScreen) works unchanged for both
/// doctors and hospitals rather than needing a parallel hospital-specific
/// copy of each.
final subscriptionRepositoryProvider = Provider<SubscriptionRepository>((ref) {
  final auth = ref.watch(authProvider);
  final role = auth is AuthAuthenticated ? auth.role : UserRole.doctor;
  final basePath =
      role == UserRole.hospital ? '/hospital/subscription' : '/doctor/subscription';
  return SubscriptionRepository(ref.read(dioClientProvider), basePath: basePath);
});

/// Thrown by [SubscriptionRepository.checkout] on a 503 — Payriff has no
/// merchant credentials configured in this environment. Same convention as
/// `PaymentUnavailableException`: deliberately not an [ApiException], since
/// callers must handle "checkout isn't available right now" distinctly from
/// a normal error (e.g. hide the paywall CTA instead of showing a snackbar).
class SubscriptionUnavailableException implements Exception {
  const SubscriptionUnavailableException();
}

class SubscriptionRepository {
  SubscriptionRepository(this._dio, {this.basePath = '/doctor/subscription'});
  final Dio _dio;

  /// `/doctor/subscription` or `/hospital/subscription` — see the
  /// [subscriptionRepositoryProvider] above for how this is chosen.
  final String basePath;

  Future<SubscriptionModel> getSubscription() async {
    try {
      final res = await _dio.get('$basePath/');
      return SubscriptionModel.fromJson(res.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioError(e);
    } catch (_) {
      throw const ServerException(0);
    }
  }

  Future<List<SubscriptionPlanModel>> getPlans() async {
    try {
      final res = await _dio.get('$basePath/plans/');
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
        '$basePath/checkout/',
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
