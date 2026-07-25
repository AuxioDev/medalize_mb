import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/features/messaging/data/repository/messaging_repository.dart';

/// Records every request and answers with canned responses (one per call, in
/// order), so the repository's request building and parsing can be asserted
/// offline — same pattern as `test/assistant_repository_test.dart`.
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

MessagingRepository _repo(_CapturingAdapter adapter) {
  final dio = Dio(BaseOptions(baseUrl: 'http://localhost/api'));
  dio.httpClientAdapter = adapter;
  return MessagingRepository(dio);
}

Map<String, dynamic> _participant({
  required String id,
  String firstName = 'Aysel',
  String lastName = 'Mammadova',
  String specializationDisplay = '',
}) =>
    {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      if (specializationDisplay.isNotEmpty) 'specialization_display': specializationDisplay,
    };

Map<String, dynamic> _threadJson({
  String id = 'thread-1',
  Map<String, dynamic>? lastMessage,
  int unreadCount = 0,
}) =>
    {
      'id': id,
      'patient': _participant(id: 'patient-1', firstName: 'Leyla', lastName: 'Huseynova'),
      'doctor': _participant(
        id: 'doctor-1',
        firstName: 'Aysel',
        lastName: 'Mammadova',
        specializationDisplay: 'Cardiology',
      ),
      'updated_at': '2026-07-24T10:00:00',
      'last_message': lastMessage,
      'unread_count': unreadCount,
    };

Map<String, dynamic> _messageJson({
  String id = 'm1',
  String thread = 'thread-1',
  String sender = 'patient-1',
  bool isMine = true,
  String body = 'Hello doctor',
}) =>
    {
      'id': id,
      'thread': thread,
      'sender': sender,
      'body': body,
      'read_at': null,
      'created_at': '2026-07-24T10:00:00',
      'is_mine': isMine,
    };

void main() {
  test('getThreads parses a plain (non-paginated) list', () async {
    final adapter = _CapturingAdapter([
      [
        _threadJson(
          id: 'thread-1',
          lastMessage: _messageJson(body: 'See you soon'),
          unreadCount: 2,
        ),
      ],
    ]);

    final threads = await _repo(adapter).getThreads();

    expect(adapter.requests.single.method, 'GET');
    expect(adapter.requests.single.path, '/messaging/threads/');
    expect(threads, hasLength(1));
    expect(threads[0].id, 'thread-1');
    expect(threads[0].patient.fullName, 'Leyla Huseynova');
    expect(threads[0].doctor.fullName, 'Aysel Mammadova');
    expect(threads[0].doctor.specializationDisplay, 'Cardiology');
    expect(threads[0].lastMessage?.body, 'See you soon');
    expect(threads[0].unreadCount, 2);
    expect(threads[0].counterpart(asDoctor: false).id, 'doctor-1');
    expect(threads[0].counterpart(asDoctor: true).id, 'patient-1');
  });

  test('getOrCreateThread posts participant_id and parses the thread', () async {
    final adapter = _CapturingAdapter([_threadJson()]);

    final thread = await _repo(adapter).getOrCreateThread('doctor-1');

    final req = adapter.requests.single;
    expect(req.method, 'POST');
    expect(req.path, '/messaging/threads/');
    expect(req.data, {'participant_id': 'doctor-1'});
    expect(thread.id, 'thread-1');
  });

  test(
      'getOrCreateThread maps the no_shared_history 403 to the localized '
      'messaging.noSharedHistory message', () async {
    final adapter = _CapturingAdapter(
      [
        {
          'code': 'no_shared_history',
          'detail': 'You need a shared appointment history to message this user.',
        },
      ],
      statusCodes: [403],
    );

    await expectLater(
      _repo(adapter).getOrCreateThread('doctor-1'),
      throwsA(isA<ConflictException>()),
    );
  });

  test('getMessages parses a single paginated page', () async {
    final adapter = _CapturingAdapter([
      {
        'count': 1,
        'next': null,
        'previous': null,
        'results': [_messageJson()],
      },
    ]);

    final messages = await _repo(adapter).getMessages('thread-1');

    final req = adapter.requests.single;
    expect(req.method, 'GET');
    expect(req.path, '/messaging/threads/thread-1/messages/');
    expect(req.queryParameters, {'page': 1});
    expect(messages.single.body, 'Hello doctor');
    expect(messages.single.isMine, isTrue);
    expect(messages.single.senderId, 'patient-1');
    expect(messages.single.threadId, 'thread-1');
  });

  test('getAllMessages walks every page via next until null', () async {
    final adapter = _CapturingAdapter([
      {
        'count': 2,
        'next': 'http://localhost/api/messaging/threads/thread-1/messages/?page=2',
        'previous': null,
        'results': [_messageJson(id: 'm1', body: 'first')],
      },
      {
        'count': 2,
        'next': null,
        'previous': null,
        'results': [_messageJson(id: 'm2', body: 'second')],
      },
    ]);

    final messages = await _repo(adapter).getAllMessages('thread-1');

    expect(adapter.requests, hasLength(2));
    expect(adapter.requests[0].queryParameters, {'page': 1});
    expect(adapter.requests[1].queryParameters, {'page': 2});
    expect(messages.map((m) => m.body), ['first', 'second']);
  });

  test('sendMessage posts the body and parses the created message', () async {
    final adapter = _CapturingAdapter([_messageJson(id: 'm9', body: 'Thanks doctor')]);

    final message = await _repo(adapter).sendMessage('thread-1', 'Thanks doctor');

    final req = adapter.requests.single;
    expect(req.method, 'POST');
    expect(req.path, '/messaging/threads/thread-1/messages/');
    expect(req.data, {'body': 'Thanks doctor'});
    expect(message.body, 'Thanks doctor');
  });

  test('getUnreadCount reads the unread_count field', () async {
    final adapter = _CapturingAdapter([
      {'unread_count': 5},
    ]);

    final count = await _repo(adapter).getUnreadCount();

    expect(adapter.requests.single.path, '/messaging/threads/unread-count/');
    expect(count, 5);
  });
}
