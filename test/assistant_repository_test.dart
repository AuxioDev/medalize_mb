import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/features/assistant/data/repository/assistant_repository.dart';

/// Records every request and answers with a canned JSON body/status, so the
/// repository's request building and parsing can be asserted offline.
class _CapturingAdapter implements HttpClientAdapter {
  _CapturingAdapter(this.body, {this.statusCode = 200});
  final Object body;
  final int statusCode;
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
    return ResponseBody.fromString(
      jsonEncode(body),
      statusCode,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }
}

AssistantRepository _repo(_CapturingAdapter adapter) {
  final dio = Dio(BaseOptions(baseUrl: 'http://localhost/api'));
  dio.httpClientAdapter = adapter;
  return AssistantRepository(dio);
}

void main() {
  test('createConversation posts and parses the new conversation', () async {
    final adapter = _CapturingAdapter({
      'id': 'conv-1',
      'updated_at': '2026-07-04T10:00:00',
    });

    final convo = await _repo(adapter).createConversation();

    final req = adapter.requests.single;
    expect(req.method, 'POST');
    expect(req.path, '/assistant/conversations/');
    expect(convo.id, 'conv-1');
  });

  test('getConversations parses a paginated list with previews', () async {
    final adapter = _CapturingAdapter({
      'results': [
        {
          'id': 'conv-1',
          'updated_at': '2026-07-04T10:00:00',
          'last_message': 'I have a headache',
        },
        {
          'id': 'conv-2',
          'updated_at': '2026-07-03T09:00:00',
          'last_message': {'content': 'See a cardiologist'},
        },
        {
          'id': 'conv-3',
          'updated_at': '2026-07-02T08:00:00',
          'last_message': null,
        },
      ],
    });

    final conversations = await _repo(adapter).getConversations();

    expect(adapter.requests.single.method, 'GET');
    expect(adapter.requests.single.path, '/assistant/conversations/');
    expect(conversations, hasLength(3));
    expect(conversations[0].lastMessagePreview, 'I have a headache');
    expect(conversations[0].updatedAt, DateTime(2026, 7, 4, 10));
    expect(conversations[1].lastMessagePreview, 'See a cardiologist');
    expect(conversations[2].lastMessagePreview, '');
  });

  test('getConversation parses messages including suggested doctors',
      () async {
    final adapter = _CapturingAdapter({
      'id': 'conv-1',
      'messages': [
        {
          'id': 'm1',
          'role': 'user',
          'content': 'I have chest pain',
          'suggested_doctors': <Object>[],
          'flagged': false,
          'created_at': '2026-07-04T10:00:00',
        },
        {
          'id': 'm2',
          'role': 'assistant',
          'content': 'Consider a cardiologist.\n\nNot medical advice.',
          'suggested_doctors': [
            {
              'id': 'doc-1',
              'first_name': 'Aysel',
              'last_name': 'Mammadova',
              'specialization_display': 'Cardiology',
              'average_rating': 4.8,
              'city': 'Baku',
            },
            {
              'id': 'doc-2',
              'first_name': 'Rauf',
              'last_name': 'Aliyev',
              'specialization_display': 'Cardiology',
              'average_rating': null,
              'city': '',
            },
          ],
          'flagged': true,
          'created_at': '2026-07-04T10:00:05',
        },
      ],
    });

    final detail = await _repo(adapter).getConversation('conv-1');

    expect(adapter.requests.single.path, '/assistant/conversations/conv-1/');
    expect(detail.messages, hasLength(2));
    expect(detail.messages[0].isUser, isTrue);
    expect(detail.messages[1].isAssistant, isTrue);
    expect(detail.messages[1].flagged, isTrue);

    final doctors = detail.messages[1].suggestedDoctors;
    expect(doctors, hasLength(2));
    expect(doctors[0].id, 'doc-1');
    expect(doctors[0].fullName, 'Dr. Aysel Mammadova');
    expect(doctors[0].specializationDisplay, 'Cardiology');
    expect(doctors[0].averageRating, 4.8);
    expect(doctors[0].city, 'Baku');
    expect(doctors[1].averageRating, isNull);
    expect(doctors[1].city, '');
  });

  test('deleteConversation issues DELETE on the conversation url', () async {
    final adapter = _CapturingAdapter(<String, Object>{});

    await _repo(adapter).deleteConversation('conv-1');

    final req = adapter.requests.single;
    expect(req.method, 'DELETE');
    expect(req.path, '/assistant/conversations/conv-1/');
  });

  test('sendMessage posts the content and parses the assistant reply',
      () async {
    final adapter = _CapturingAdapter({
      'id': 'm9',
      'role': 'assistant',
      'content': 'You should see a dermatologist.',
      'suggested_doctors': [
        {
          'id': 'doc-3',
          'first_name': 'Leyla',
          'last_name': 'Huseynova',
          'specialization_display': 'Dermatology',
          'average_rating': 4.5,
          'city': 'Ganja',
        },
      ],
      'flagged': false,
      'created_at': '2026-07-04T11:00:00',
    });

    final reply = await _repo(adapter).sendMessage('conv-1', 'My skin itches');

    final req = adapter.requests.single;
    expect(req.method, 'POST');
    expect(req.path, '/assistant/conversations/conv-1/messages/');
    expect(req.data, {'content': 'My skin itches'});
    expect(reply.isAssistant, isTrue);
    expect(reply.suggestedDoctors.single.fullName, 'Dr. Leyla Huseynova');
  });

  test('flagMessage posts the reason to the flag endpoint', () async {
    final adapter = _CapturingAdapter(<String, Object>{});

    await _repo(adapter).flagMessage('m2', reason: 'Sounded like a diagnosis');

    final req = adapter.requests.single;
    expect(req.method, 'POST');
    expect(req.path, '/assistant/messages/m2/flag/');
    expect(req.data, {'reason': 'Sounded like a diagnosis'});
  });

  test('a 503 surfaces the backend-localized detail message', () async {
    final adapter = _CapturingAdapter(
      {'detail': 'Assistent hazırda əlçatan deyil'},
      statusCode: 503,
    );

    await expectLater(
      _repo(adapter).sendMessage('conv-1', 'hi'),
      throwsA(isA<NetworkException>().having(
        (e) => e.userMessage,
        'userMessage',
        'Assistent hazırda əlçatan deyil',
      )),
    );
  });
}
