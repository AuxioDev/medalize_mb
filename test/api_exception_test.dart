import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

DioException _dio({
  dynamic data,
  int? status,
  DioExceptionType type = DioExceptionType.badResponse,
  String? message,
}) {
  final ro = RequestOptions(path: '/x');
  return DioException(
    requestOptions: ro,
    type: type,
    message: message,
    response: (status == null && data == null)
        ? null
        : Response(requestOptions: ro, data: data, statusCode: status),
  );
}

void main() {
  group('mapDioError — connectivity', () {
    test('connection error maps to NetworkException without leaking raw text', () {
      final e = mapDioError(_dio(
        type: DioExceptionType.connectionError,
        message: 'The connection errored: Connection refused',
      ));
      expect(e, isA<NetworkException>());
      expect(e.userMessage, t.errors.network);
      expect(e.userMessage, isNot(contains('Connection refused')));
    });

    test('send and receive timeouts map to NetworkException', () {
      expect(mapDioError(_dio(type: DioExceptionType.sendTimeout)),
          isA<NetworkException>());
      expect(mapDioError(_dio(type: DioExceptionType.receiveTimeout)),
          isA<NetworkException>());
    });

    test('null response (e.g. cancel) maps to NetworkException', () {
      expect(mapDioError(_dio(type: DioExceptionType.cancel)),
          isA<NetworkException>());
    });

    test('a non-Dio error maps to NetworkException', () {
      expect(mapDioError(Exception('boom')), isA<NetworkException>());
    });
  });

  group('mapDioError — validation', () {
    test('per-field errors are preserved for form binding', () {
      final e = mapDioError(_dio(status: 400, data: {
        'code': 'validation_error',
        'errors': {
          'email': ['Taken'],
        },
      })) as ValidationException;
      expect(e.fieldErrors['email'], ['Taken']);
      expect(e.firstError, 'Taken');
    });

    test('non_field_errors surface as a message instead of being swallowed', () {
      final e = mapDioError(_dio(status: 400, data: {
        'code': 'validation_error',
        'errors': {
          'non_field_errors': ['This slot is no longer available.'],
        },
      })) as ValidationException;
      expect(e.fieldErrors, isEmpty);
      expect(e.message, 'This slot is no longer available.');
      expect(e.userMessage, 'This slot is no longer available.');
    });

    test('list-form errors surface as a message', () {
      final e = mapDioError(_dio(status: 400, data: {
        'code': 'validation_error',
        'errors': ['Bad request'],
      })) as ValidationException;
      expect(e.message, 'Bad request');
    });
  });

  group('mapDioError — typed codes', () {
    test('invalid_credentials uses the backend message', () {
      final e = mapDioError(_dio(status: 401, data: {
        'code': 'invalid_credentials',
        'message': 'Invalid email or password.',
      }));
      expect(e, isA<InvalidCredentialsException>());
      expect(e.userMessage, 'Invalid email or password.');
    });

    test('rate_limit_exceeded carries retry seconds', () {
      final e = mapDioError(_dio(status: 429, data: {
        'code': 'rate_limit_exceeded',
        'retry_after_seconds': 30,
      }));
      expect((e as RateLimitException).retryAfterSeconds, 30);
    });

    test('unknown/server_error maps to ServerException with the status code', () {
      final e = mapDioError(_dio(status: 500, data: {'code': 'server_error'}));
      expect((e as ServerException).statusCode, 500);
    });

    test('conflict uses the backend message instead of a generic server error', () {
      final e = mapDioError(_dio(status: 409, data: {
        'code': 'conflict',
        'message': 'Cannot cancel within 2 hours of appointment.',
      }));
      expect(e, isA<ConflictException>());
      expect(e.userMessage, 'Cannot cancel within 2 hours of appointment.');
    });

    test('onboarding_incomplete carries the message and missing fields', () {
      final e = mapDioError(_dio(status: 400, data: {
        'code': 'onboarding_incomplete',
        'message': 'Complete all required fields before finishing onboarding.',
        'missing': ['specialization', 'diploma'],
      })) as OnboardingIncompleteException;
      expect(e.userMessage,
          'Complete all required fields before finishing onboarding.');
      expect(e.missing, ['specialization', 'diploma']);
    });

    test('social_email_unverified surfaces the backend guidance', () {
      final e = mapDioError(_dio(status: 403, data: {
        'code': 'social_email_unverified',
        'message':
            'An account with this email already exists. Please sign in with your password.',
      }));
      expect(e, isA<SocialLoginException>());
      expect(e.userMessage, contains('sign in with your password'));
    });

    test('social_token_invalid and social_email_missing also map to SocialLoginException', () {
      expect(
        mapDioError(_dio(status: 401, data: {'code': 'social_token_invalid'})),
        isA<SocialLoginException>(),
      );
      expect(
        mapDioError(_dio(status: 400, data: {'code': 'social_email_missing'})),
        isA<SocialLoginException>(),
      );
    });
  });
}
