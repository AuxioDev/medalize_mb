import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/features/messaging/data/models/messaging_models.dart';
import 'package:medalize_mb/features/messaging/data/repository/messaging_repository.dart';

/// Thread list, auto-refreshed every 60 seconds while watched — same
/// `Timer.periodic` + `ref.onDispose` pattern as
/// `lib/features/notifications/providers/notification_provider.dart::notificationsProvider`.
final threadsProvider = FutureProvider<List<ThreadModel>>((ref) {
  final timer = Timer.periodic(const Duration(seconds: 60), (_) {
    ref.invalidateSelf();
  });
  ref.onDispose(timer.cancel);
  return ref.read(messagingRepositoryProvider).getThreads();
});

/// Total unread message count across every thread, for the [MessageBell]
/// badge. Polls its own dedicated endpoint (not derived from [threadsProvider])
/// on the same 60-second cadence.
final unreadMessagesCountProvider = FutureProvider<int>((ref) {
  final timer = Timer.periodic(const Duration(seconds: 60), (_) {
    ref.invalidateSelf();
  });
  ref.onDispose(timer.cancel);
  return ref.read(messagingRepositoryProvider).getUnreadCount();
});

class ThreadChatState {
  final List<MessageModel> messages;
  final bool loading;
  final bool loadFailed;

  /// True while awaiting the server's confirmation of an optimistically
  /// added outgoing message.
  final bool sending;
  final String? sendError;

  const ThreadChatState({
    this.messages = const [],
    this.loading = true,
    this.loadFailed = false,
    this.sending = false,
    this.sendError,
  });

  ThreadChatState copyWith({
    List<MessageModel>? messages,
    bool? loading,
    bool? loadFailed,
    bool? sending,
    String? sendError,
  }) =>
      ThreadChatState(
        messages: messages ?? this.messages,
        loading: loading ?? this.loading,
        loadFailed: loadFailed ?? this.loadFailed,
        sending: sending ?? this.sending,
        sendError: sendError,
      );
}

/// Mirrors `lib/features/assistant/providers/assistant_provider.dart::AssistantChatController`
/// — the established live-chat pattern in this codebase: optimistic local
/// message insertion before the server responds, plus (unlike the assistant,
/// which only ever replies to what the patient just sent) a short
/// `Timer.periodic` that polls for new incoming messages from the other
/// participant while the screen is open.
final threadChatProvider = StateNotifierProvider.autoDispose
    .family<ThreadChatController, ThreadChatState, String>(
  (ref, threadId) => ThreadChatController(
    ref.read(messagingRepositoryProvider),
    threadId,
  ),
);

class ThreadChatController extends StateNotifier<ThreadChatState> {
  ThreadChatController(this._repo, this.threadId) : super(const ThreadChatState()) {
    _load();
    // Short poll for the other participant's replies while this screen is
    // open — 12s, inside the 10-15s window the spec calls for. Cancelled in
    // dispose(), never left running once the screen is popped.
    _poll = Timer.periodic(const Duration(seconds: 12), (_) => _refresh());
  }

  final MessagingRepository _repo;
  final String threadId;
  var _localSeq = 0;
  Timer? _poll;

  Future<void> _load() async {
    state = state.copyWith(loading: true, loadFailed: false);
    try {
      final messages = await _repo.getAllMessages(threadId);
      if (!mounted) return;
      state = state.copyWith(loading: false, messages: messages);
    } on ApiException {
      if (!mounted) return;
      state = state.copyWith(loading: false, loadFailed: true);
    }
  }

  Future<void> retryLoad() => _load();

  /// Background refresh driven by [_poll]: silently merges freshly fetched
  /// messages without flipping the loading skeleton, and skips entirely
  /// while a send is in flight so it can never clobber the optimistic bubble.
  Future<void> _refresh() async {
    if (!mounted || state.sending) return;
    try {
      final messages = await _repo.getAllMessages(threadId);
      if (!mounted) return;
      state = state.copyWith(messages: messages);
    } on ApiException {
      // Silent — a failed background poll shouldn't disrupt the screen.
    }
  }

  /// Optimistically appends the patient's/doctor's own message, then swaps it
  /// for the server's copy once it's confirmed. On failure the optimistic
  /// message is rolled back so the input can be restored. Returns whether it
  /// succeeded.
  Future<bool> send(String text) async {
    final optimistic = MessageModel(
      id: 'local-${_localSeq++}',
      threadId: threadId,
      senderId: '',
      isMine: true,
      body: text,
      createdAt: DateTime.now(),
    );
    state = state.copyWith(
      messages: [...state.messages, optimistic],
      sending: true,
    );
    try {
      final sent = await _repo.sendMessage(threadId, text);
      if (!mounted) return true;
      state = state.copyWith(
        messages: [
          for (final m in state.messages)
            if (m.id != optimistic.id) m,
          sent,
        ],
        sending: false,
      );
      return true;
    } on ApiException catch (e) {
      if (!mounted) return false;
      state = state.copyWith(
        messages: state.messages.where((m) => m.id != optimistic.id).toList(),
        sending: false,
        sendError: e.userMessage,
      );
      return false;
    }
  }

  @override
  void dispose() {
    _poll?.cancel();
    super.dispose();
  }
}
