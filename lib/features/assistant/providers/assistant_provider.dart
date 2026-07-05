import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/features/assistant/data/models/assistant_models.dart';
import 'package:medalize_mb/features/assistant/data/repository/assistant_repository.dart';

final assistantConversationsProvider =
    FutureProvider.autoDispose<List<ConversationModel>>(
  (ref) => ref.watch(assistantRepositoryProvider).getConversations(),
);

class AssistantChatState {
  final List<MessageModel> messages;
  final bool loading;
  final bool loadFailed;

  /// True while awaiting the assistant's reply — drives the typing indicator.
  final bool sending;
  final String? sendError;

  const AssistantChatState({
    this.messages = const [],
    this.loading = true,
    this.loadFailed = false,
    this.sending = false,
    this.sendError,
  });

  AssistantChatState copyWith({
    List<MessageModel>? messages,
    bool? loading,
    bool? loadFailed,
    bool? sending,
    String? sendError,
  }) =>
      AssistantChatState(
        messages: messages ?? this.messages,
        loading: loading ?? this.loading,
        loadFailed: loadFailed ?? this.loadFailed,
        sending: sending ?? this.sending,
        sendError: sendError,
      );
}

final assistantChatProvider = StateNotifierProvider.autoDispose
    .family<AssistantChatController, AssistantChatState, String>(
  (ref, conversationId) => AssistantChatController(
    ref.read(assistantRepositoryProvider),
    conversationId,
  ),
);

class AssistantChatController extends StateNotifier<AssistantChatState> {
  AssistantChatController(this._repo, this.conversationId)
      : super(const AssistantChatState()) {
    _load();
  }

  final AssistantRepository _repo;
  final String conversationId;
  var _localSeq = 0;

  Future<void> _load() async {
    state = state.copyWith(loading: true, loadFailed: false);
    try {
      final detail = await _repo.getConversation(conversationId);
      if (!mounted) return;
      state = state.copyWith(loading: false, messages: detail.messages);
    } on ApiException {
      if (!mounted) return;
      state = state.copyWith(loading: false, loadFailed: true);
    }
  }

  Future<void> retryLoad() => _load();

  /// Optimistically appends the user's message, then swaps the typing
  /// indicator for the assistant's reply. On failure the optimistic message is
  /// rolled back so the input can be restored. Returns whether it succeeded.
  Future<bool> send(String text) async {
    final optimistic = MessageModel(
      id: 'local-${_localSeq++}',
      role: MessageModel.roleUser,
      content: text,
      createdAt: DateTime.now(),
    );
    state = state.copyWith(
      messages: [...state.messages, optimistic],
      sending: true,
    );
    try {
      final reply = await _repo.sendMessage(conversationId, text);
      if (!mounted) return true;
      state = state.copyWith(
        messages: [...state.messages, reply],
        sending: false,
      );
      return true;
    } on ApiException catch (e) {
      if (!mounted) return false;
      state = state.copyWith(
        messages:
            state.messages.where((m) => m.id != optimistic.id).toList(),
        sending: false,
        sendError: e.userMessage,
      );
      return false;
    }
  }

  Future<bool> flag(String messageId, String reason) async {
    try {
      await _repo.flagMessage(messageId, reason: reason);
    } on ApiException {
      return false;
    }
    if (!mounted) return true;
    state = state.copyWith(
      messages: [
        for (final m in state.messages)
          m.id == messageId ? m.copyWith(flagged: true) : m,
      ],
    );
    return true;
  }
}
