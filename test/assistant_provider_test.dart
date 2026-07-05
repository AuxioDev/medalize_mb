import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/features/assistant/data/models/assistant_models.dart';
import 'package:medalize_mb/features/assistant/data/repository/assistant_repository.dart';
import 'package:medalize_mb/features/assistant/providers/assistant_provider.dart';

class _FakeAssistantRepository extends AssistantRepository {
  _FakeAssistantRepository({
    this.messages = const [],
    this.loadError,
    this.sendError,
    this.flagError,
  }) : super(Dio());

  final List<MessageModel> messages;
  final ApiException? loadError;
  final ApiException? sendError;
  final ApiException? flagError;

  /// When set, sendMessage waits on this before answering, so tests can
  /// observe the optimistic in-flight state.
  Completer<MessageModel>? sendCompleter;

  String? lastSentContent;
  String? lastFlaggedId;
  String? lastFlagReason;

  @override
  Future<ConversationDetailModel> getConversation(String id) async {
    if (loadError != null) throw loadError!;
    return ConversationDetailModel(id: id, messages: messages);
  }

  @override
  Future<MessageModel> sendMessage(String conversationId, String content) async {
    lastSentContent = content;
    if (sendCompleter != null) return sendCompleter!.future;
    if (sendError != null) throw sendError!;
    return MessageModel(
      id: 'reply-1',
      role: MessageModel.roleAssistant,
      content: 'Assistant reply',
      createdAt: DateTime(2026, 7, 4, 12),
    );
  }

  @override
  Future<void> flagMessage(String messageId, {String reason = ''}) async {
    if (flagError != null) throw flagError!;
    lastFlaggedId = messageId;
    lastFlagReason = reason;
  }
}

MessageModel _assistantMessage(String id) => MessageModel(
      id: id,
      role: MessageModel.roleAssistant,
      content: 'Hello, how can I help?',
      createdAt: DateTime(2026, 7, 4, 10),
    );

(ProviderContainer, ProviderSubscription<AssistantChatState>) _chat(
    _FakeAssistantRepository repo) {
  final container = ProviderContainer(
    overrides: [assistantRepositoryProvider.overrideWithValue(repo)],
  );
  // Keep the autoDispose family provider alive for the duration of the test.
  final sub = container.listen(assistantChatProvider('conv-1'), (_, _) {});
  return (container, sub);
}

void main() {
  test('loads the conversation messages and clears the loading flag',
      () async {
    final repo = _FakeAssistantRepository(messages: [_assistantMessage('m1')]);
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
    final repo = _FakeAssistantRepository(loadError: const ServerException(500));
    final (container, sub) = _chat(repo);
    addTearDown(container.dispose);

    await Future<void>.delayed(Duration.zero);

    final state = sub.read();
    expect(state.loading, isFalse);
    expect(state.loadFailed, isTrue);
    expect(state.messages, isEmpty);
  });

  test(
      'send appends the user message optimistically and shows the typing '
      'indicator until the reply arrives', () async {
    final repo = _FakeAssistantRepository()
      ..sendCompleter = Completer<MessageModel>();
    final (container, sub) = _chat(repo);
    addTearDown(container.dispose);
    await Future<void>.delayed(Duration.zero);

    final future =
        container.read(assistantChatProvider('conv-1').notifier).send('I feel dizzy');
    // Reply not yet received: the user's message is already visible.
    var state = sub.read();
    expect(state.sending, isTrue);
    expect(state.messages, hasLength(1));
    expect(state.messages.single.isUser, isTrue);
    expect(state.messages.single.content, 'I feel dizzy');
    expect(repo.lastSentContent, 'I feel dizzy');

    repo.sendCompleter!.complete(MessageModel(
      id: 'reply-1',
      role: MessageModel.roleAssistant,
      content: 'Please see a neurologist',
      createdAt: DateTime(2026, 7, 4, 12),
    ));
    expect(await future, isTrue);

    state = sub.read();
    expect(state.sending, isFalse);
    expect(state.messages, hasLength(2));
    expect(state.messages.last.isAssistant, isTrue);
    expect(state.messages.last.content, 'Please see a neurologist');
  });

  test('a failed send rolls back the optimistic message and keeps the error',
      () async {
    final repo =
        _FakeAssistantRepository(sendError: const ServerException(500));
    final (container, sub) = _chat(repo);
    addTearDown(container.dispose);
    await Future<void>.delayed(Duration.zero);

    final ok = await container
        .read(assistantChatProvider('conv-1').notifier)
        .send('I feel dizzy');

    expect(ok, isFalse);
    final state = sub.read();
    expect(state.sending, isFalse);
    expect(state.messages, isEmpty);
    expect(state.sendError, isNotNull);
  });

  test('flag marks the message as flagged in place', () async {
    final repo = _FakeAssistantRepository(messages: [_assistantMessage('m1')]);
    final (container, sub) = _chat(repo);
    addTearDown(container.dispose);
    await Future<void>.delayed(Duration.zero);

    final ok = await container
        .read(assistantChatProvider('conv-1').notifier)
        .flag('m1', 'inaccurate');

    expect(ok, isTrue);
    expect(repo.lastFlaggedId, 'm1');
    expect(repo.lastFlagReason, 'inaccurate');
    expect(sub.read().messages.single.flagged, isTrue);
  });

  test('a failed flag reports failure and leaves the message untouched',
      () async {
    final repo = _FakeAssistantRepository(
      messages: [_assistantMessage('m1')],
      flagError: const ServerException(500),
    );
    final (container, sub) = _chat(repo);
    addTearDown(container.dispose);
    await Future<void>.delayed(Duration.zero);

    final ok = await container
        .read(assistantChatProvider('conv-1').notifier)
        .flag('m1', '');

    expect(ok, isFalse);
    expect(sub.read().messages.single.flagged, isFalse);
  });
}
