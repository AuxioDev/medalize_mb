import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/features/subscription/data/repository/subscription_repository.dart';

/// Records every request and answers with one canned response per call, in
/// order — same pattern as test/payment_repository_test.dart.
class _CapturingAdapter implements HttpClientAdapter {
  _CapturingAdapter(List<Object> bodies, {List<int>? statusCodes})
      : _bodies = List.of(bodies),
        _statusCodes = statusCodes ?? List.filled(bodies.length, 200);

  final List<Object> _bodies;
  final List<int> _statusCodes;
  var _i = 0;
  final requests = <RequestOptions>[];

  @override
  void close({bool force = false}) {}

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    final body = _bodies[_i];
    final status = _statusCodes[_i];
    _i++;
    return ResponseBody.fromString(
      jsonEncode(body),
      status,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }
}

SubscriptionRepository _repo(_CapturingAdapter adapter) {
  final dio = Dio(BaseOptions(baseUrl: 'http://localhost/api'));
  dio.httpClientAdapter = adapter;
  return SubscriptionRepository(dio);
}

Map<String, dynamic> _subscriptionJson({
  String status = 'trialing',
  String plan = '',
  String effectivePlan = 'trial',
}) =>
    {
      'status': status,
      'plan': plan,
      'effective_plan': effectivePlan,
      'trial_ends_at': '2026-08-04T00:00:00Z',
      'current_period_end': null,
      'grace_ends_at': null,
      'limits': {
        'workplaces': 5,
        'appointments_per_month': null,
        'chat': true,
        'promoted': true,
        'advanced_stats': true,
      },
      'usage': {'workplaces': 1, 'appointments_this_month': 3},
    };

void main() {
  test('getSubscription parses status, limits, and usage', () async {
    final adapter = _CapturingAdapter([_subscriptionJson()]);

    final sub = await _repo(adapter).getSubscription();

    expect(adapter.requests.single.method, 'GET');
    expect(adapter.requests.single.path, '/doctor/subscription/');
    expect(sub.status, 'trialing');
    expect(sub.isTrialing, isTrue);
    expect(sub.effectivePlan, 'trial');
    expect(sub.limits.workplaces, 5);
    expect(sub.limits.appointmentsPerMonth, isNull);
    expect(sub.limits.chat, isTrue);
    expect(sub.usage?.workplaces, 1);
    expect(sub.usage?.appointmentsThisMonth, 3);
  });

  test('getSubscription maps error statuses to an ApiException', () async {
    final adapter = _CapturingAdapter([
      {'detail': 'Server error'}
    ], statusCodes: [
      500
    ]);

    await expectLater(
      _repo(adapter).getSubscription(),
      throwsA(isA<ApiException>()),
    );
  });

  test('getPlans parses the plan catalog with string prices', () async {
    final adapter = _CapturingAdapter([
      [
        {
          'plan': 'basic',
          'name': 'Başlanğıc',
          'price': '19.99',
          'currency': 'AZN',
          'limits': {
            'workplaces': 1,
            'appointments_per_month': 40,
            'chat': false,
            'promoted': false,
            'advanced_stats': false,
          },
        },
        {
          'plan': 'pro',
          'name': 'Peşəkar',
          'price': '39.99',
          'currency': 'AZN',
          'limits': {
            'workplaces': 5,
            'appointments_per_month': null,
            'chat': true,
            'promoted': true,
            'advanced_stats': true,
          },
        },
      ],
    ]);

    final plans = await _repo(adapter).getPlans();

    expect(adapter.requests.single.path, '/doctor/subscription/plans/');
    expect(plans, hasLength(2));
    expect(plans[0].plan, 'basic');
    expect(plans[0].price, '19.99');
    expect(plans[0].limits.appointmentsPerMonth, 40);
    expect(plans[1].plan, 'pro');
    expect(plans[1].limits.appointmentsPerMonth, isNull);
  });

  test('checkout posts the chosen plan and returns the payment url', () async {
    final adapter = _CapturingAdapter([
      {'payment_url': 'https://checkout.payriff.com/session/sub-1'},
    ], statusCodes: [
      201
    ]);

    final url = await _repo(adapter).checkout('pro');

    final req = adapter.requests.single;
    expect(req.method, 'POST');
    expect(req.path, '/doctor/subscription/checkout/');
    expect(req.data, {'plan': 'pro'});
    expect(url, 'https://checkout.payriff.com/session/sub-1');
  });

  test(
      'checkout maps a 503 to SubscriptionUnavailableException — payments not '
      'configured in this environment', () async {
    final adapter = _CapturingAdapter([
      {'detail': 'Payments are not configured.'}
    ], statusCodes: [
      503
    ]);

    await expectLater(
      _repo(adapter).checkout('basic'),
      throwsA(isA<SubscriptionUnavailableException>()),
    );
  });

  test('checkout maps other error statuses to an ApiException', () async {
    final adapter = _CapturingAdapter([
      {'code': 'validation_error', 'errors': {}}
    ], statusCodes: [
      400
    ]);

    await expectLater(
      _repo(adapter).checkout('basic'),
      throwsA(isA<ApiException>()),
    );
  });
}
