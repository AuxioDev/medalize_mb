import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/features/messaging/data/models/messaging_models.dart';
import 'package:medalize_mb/features/messaging/data/repository/messaging_repository.dart';
import 'package:medalize_mb/features/messaging/providers/messaging_provider.dart';

class _FakeMessagingRepository extends MessagingRepository {
  _FakeMessagingRepository({
    this.messages = const [],
    this.loadError,
    this.sendError,
  }) : super(Dio());

  final List<MessageModel> messages;
  final ApiException? loadError;
  final ApiException? sendError;

  /// When set, sendMessage waits on this before answering, so tests can
  /// observe the optimistic in-flight state.
  Completer<MessageModel>? sendCompleter;

  String? lastSentBody;
  var getAllMessagesCallCount = 0;

  @override
  Future<List<MessageModel>> getAllMessages(String threadId) async {
    getAllMessagesCallCount++;
    if (loadError != null) throw loadError!;
    return messages;
  }

  @override
  Future<MessageModel> sendMessage(String threadId, String body) async {
    lastSentBody = body;
    if (sendCompleter != null) return sendCompleter!.future;
    if (sendError != null) throw sendError!;
    return MessageModel(
      id: 'server-1',
      threadId: threadId,
      senderId: 'doctor-1',
      isMine: true,
      body: body,
      createdAt: DateTime(2026, 7, 24, 12),
    );
  }
}

MessageModel _incoming(String id) => MessageModel(
      id: id,
      threadId: 'thread-1',
      senderId: 'doctor-1',
      isMine: false,
      body: 'Hello from the doctor',
      createdAt: DateTime(2026, 7, 24, 10),
    );

(ProviderContainer, ProviderSubscription<ThreadChatState>) _chat(
    _FakeMessagingRepository repo) {
  final container = ProviderContainer(
    overrides: [messagingRepositoryProvider.overrideWithValue(repo)],
  );
  // Keep the autoDispose family provider alive for the duration of the test.
  final sub = container.listen(threadChatProvider('thread-1'), (_, _) {});
  return (container, sub);
}

void main() {
  test('loads every message in the thread and clears the loading flag',
      () async {
    final repo = _FakeMessagingRepository(messages: [_incoming('m1')]);
    final (container, sub) = _chat(repo);
    addTearDown(container.dispose);

    expect(sub.read().loading, isTrue);

    await Future<void>.delayed(Duration.zero);

    final state = sub.read();
    expect(state.loading, isFalse);
    expect(state.loadFailed, isFalse);
    expect(state.messages.single.id, 'm1');
  });

  test('a failed load flips loadFailed instead of throwing', () async {
    final repo = _FakeMessagingRepository(loadError: const ServerException(500));
    final (container, sub) = _chat(repo);
    addTearDown(container.dispose);

    await Future<void>.delayed(Duration.zero);

    final state = sub.read();
    expect(state.loading, isFalse);
    expect(state.loadFailed, isTrue);
    expect(state.messages, isEmpty);
  });

  test(
      'send appends the outgoing message optimistically before the server '
      'confirms it, then swaps it for the server copy', () async {
    final repo = _FakeMessagingRepository()..sendCompleter = Completer<MessageModel>();
    final (container, sub) = _chat(repo);
    addTearDown(container.dispose);
    await Future<void>.delayed(Duration.zero);

    final future = container
        .read(threadChatProvider('thread-1').notifier)
        .send('On my way to the clinic');
    // Not yet confirmed by the server: the optimistic bubble is already there.
    var state = sub.read();
    expect(state.sending, isTrue);
    expect(state.messages, hasLength(1));
    expect(state.messages.single.isMine, isTrue);
    expect(state.messages.single.body, 'On my way to the clinic');
    expect(repo.lastSentBody, 'On my way to the clinic');

    repo.sendCompleter!.complete(MessageModel(
      id: 'server-9',
      threadId: 'thread-1',
      senderId: 'patient-1',
      isMine: true,
      body: 'On my way to the clinic',
      createdAt: DateTime(2026, 7, 24, 12),
    ));
    expect(await future, isTrue);

    state = sub.read();
    expect(state.sending, isFalse);
    expect(state.messages, hasLength(1));
    expect(state.messages.single.id, 'server-9');
  });

  test('a failed send rolls back the optimistic message and keeps the error',
      () async {
    final repo = _FakeMessagingRepository(sendError: const ServerException(500));
    final (container, sub) = _chat(repo);
    addTearDown(container.dispose);
    await Future<void>.delayed(Duration.zero);

    final ok = await container
        .read(threadChatProvider('thread-1').notifier)
        .send('This will fail');

    expect(ok, isFalse);
    final state = sub.read();
    expect(state.sending, isFalse);
    expect(state.messages, isEmpty);
    expect(state.sendError, isNotNull);
  });
}
