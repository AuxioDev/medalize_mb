import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/features/payments/data/repository/payment_repository.dart';

/// Records every request and answers with one canned response per call, in
/// order — same pattern as `test/messaging_repository_test.dart`.
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

PaymentRepository _repo(_CapturingAdapter adapter) {
  final dio = Dio(BaseOptions(baseUrl: 'http://localhost/api'));
  dio.httpClientAdapter = adapter;
  return PaymentRepository(dio);
}

Map<String, dynamic> _paymentJson({
  String id = 'pay-1',
  String appointment = 'appt-1',
  String amount = '50.00',
  String currency = 'AZN',
  String status = 'pending',
  String paymentUrl = 'https://checkout.payriff.com/session/abc',
}) =>
    {
      'id': id,
      'appointment': appointment,
      'amount': amount,
      'currency': currency,
      'status': status,
      'payment_url': paymentUrl,
      'created_at': '2026-07-24T10:00:00',
      'paid_at': null,
    };

void main() {
  test('getPayment parses the full payment representation', () async {
    final adapter = _CapturingAdapter([_paymentJson()]);

    final payment = await _repo(adapter).getPayment('appt-1');

    expect(adapter.requests.single.method, 'GET');
    expect(adapter.requests.single.path, '/appointments/appt-1/payment/');
    expect(payment, isNotNull);
    expect(payment!.id, 'pay-1');
    expect(payment.appointmentId, 'appt-1');
    expect(payment.amount, '50.00');
    expect(payment.currency, 'AZN');
    expect(payment.status, 'pending');
    expect(payment.paymentUrl, 'https://checkout.payriff.com/session/abc');
    expect(payment.isPending, isTrue);
  });

  test('getPayment maps a 404 to null (no payment created yet), not an error',
      () async {
    final adapter = _CapturingAdapter(
      [
        {'detail': 'Not found.'}
      ],
      statusCodes: [404],
    );

    final payment = await _repo(adapter).getPayment('appt-1');

    expect(payment, isNull);
  });

  test('getPayment maps other error statuses to an ApiException', () async {
    final adapter = _CapturingAdapter(
      [
        {'detail': 'Server error'}
      ],
      statusCodes: [500],
    );

    await expectLater(
      _repo(adapter).getPayment('appt-1'),
      throwsA(isA<ApiException>()),
    );
  });

  test(
      'createPayment posts to the appointment payment endpoint and fills in '
      'the appointment id from the caller (POST responses omit "appointment")',
      () async {
    final adapter = _CapturingAdapter([
      {
        'id': 'pay-2',
        'status': 'pending',
        'amount': '75.00',
        'currency': 'AZN',
        'payment_url': 'https://checkout.payriff.com/session/xyz',
      },
    ]);

    final payment = await _repo(adapter).createPayment('appt-2');

    final req = adapter.requests.single;
    expect(req.method, 'POST');
    expect(req.path, '/appointments/appt-2/payment/');
    expect(payment.id, 'pay-2');
    // Not present in the response body — filled in from the call argument.
    expect(payment.appointmentId, 'appt-2');
    expect(payment.amount, '75.00');
    expect(payment.paymentUrl, 'https://checkout.payriff.com/session/xyz');
  });

  test(
      'createPayment maps a 503 to PaymentUnavailableException — the '
      "'payment not configured in this environment' case, not a normal error",
      () async {
    final adapter = _CapturingAdapter(
      [
        {'detail': 'Payments are not configured.'}
      ],
      statusCodes: [503],
    );

    await expectLater(
      _repo(adapter).createPayment('appt-1'),
      throwsA(isA<PaymentUnavailableException>()),
    );
  });

  test('createPayment maps other error statuses to an ApiException', () async {
    final adapter = _CapturingAdapter(
      [
        {'code': 'validation_error', 'errors': {}}
      ],
      statusCodes: [400],
    );

    await expectLater(
      _repo(adapter).createPayment('appt-1'),
      throwsA(isA<ApiException>()),
    );
  });
}
