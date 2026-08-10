import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/core/widgets/app_snack_bar.dart';
import 'package:medalize_mb/core/widgets/chat/chat_disclaimer_banner.dart';
import 'package:medalize_mb/core/widgets/chat/chat_input_bar.dart';
import 'package:medalize_mb/core/widgets/chat/chat_loading_skeleton.dart';
import 'package:medalize_mb/core/widgets/chat/chat_message_bubble.dart';
import 'package:medalize_mb/core/widgets/empty_state.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/features/assistant/data/models/assistant_models.dart';
import 'package:medalize_mb/features/assistant/presentation/widgets/flag_message_dialog.dart';
import 'package:medalize_mb/features/assistant/presentation/widgets/suggested_doctor_card.dart';
import 'package:medalize_mb/features/assistant/providers/assistant_provider.dart';
import 'package:medalize_mb/features/shared/presentation/widgets/app_bar_title.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

/// Chat with the AI symptom assistant. Loads the conversation by [conversationId]
/// from the route path; [conversation] is an optional preview passed via
/// `extra` and may be null (e.g. after state restoration).
class AssistantChatScreen extends ConsumerStatefulWidget {
  const AssistantChatScreen({
    super.key,
    required this.conversationId,
    this.conversation,
  });

  final String conversationId;
  final ConversationModel? conversation;

  @override
  ConsumerState<AssistantChatScreen> createState() =>
      _AssistantChatScreenState();
}

class _AssistantChatScreenState extends ConsumerState<AssistantChatScreen> {
  final _inputController = TextEditingController();
  var _hasText = false;

  // Every message id encountered so far (seeded from history on first load)
  // and the subset of those still mid-reveal. A message earns the effect
  // exactly once, the first time it's seen after history has loaded — never
  // on the initial scroll-back through history. It's removed from
  // _typewriterMessageIds the moment its reveal completes (see
  // _markTypewriterComplete), not left there for the rest of the session:
  // ListView.builder can discard and remount an off-screen bubble (e.g. the
  // keyboard opening shrinks the viewport while composing the next
  // message), and TypewriterText has no memory of already having played —
  // a stale "true" here would make a finished reply replay from scratch.
  final _seenMessageIds = <String>{};
  final _typewriterMessageIds = <String>{};
  var _historySeeded = false;

  @override
  void initState() {
    super.initState();
    _inputController.addListener(() {
      final hasText = _inputController.text.trim().isNotEmpty;
      if (hasText != _hasText) setState(() => _hasText = hasText);
    });
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  /// The disclaimer arrives from the backend, already localized: either as a
  /// dedicated field on assistant messages or as the final paragraph appended
  /// to every substantive assistant reply. Never hardcoded on the client.
  ///
  /// Only looks at the LAST assistant message, not the whole history — some
  /// replies (emergency warning, off-topic refusal, "didn't understand") are
  /// a single paragraph with no disclaimer. Falling back to an older message
  /// there would pin a stale disclaimer from a previous, unrelated turn.
  String? _disclaimerText(List<MessageModel> messages) {
    final lastAssistant = messages.reversed.where((m) => m.isAssistant).firstOrNull;
    if (lastAssistant == null) return null;
    final d = lastAssistant.disclaimer;
    if (d != null && d.isNotEmpty) return d;
    final parts = lastAssistant.content
        .split(RegExp(r'\n\s*\n'))
        .where((p) => p.trim().isNotEmpty)
        .toList();
    return parts.length > 1 ? parts.last.trim() : null;
  }

  Future<void> _send() => _sendText(_inputController.text.trim());

  /// Shared by the input bar's send button and the empty-state topic chips —
  /// a tapped chip's label is sent exactly like typed text, restoring it to
  /// the (empty) input field on failure the same way either path recovers.
  Future<void> _sendText(String text) async {
    if (text.isEmpty) return;
    final notifier = ref.read(assistantChatProvider(widget.conversationId).notifier);
    _inputController.clear();
    final ok = await notifier.send(text);
    if (!ok && mounted) {
      // Roll the text back into the field so the patient can retry.
      _inputController.text = text;
      final error =
          ref.read(assistantChatProvider(widget.conversationId)).sendError;
      AppSnackBar.show(
        context,
        error ?? context.t.assistant.sendFailed,
        type: SnackBarType.error,
      );
    }
  }

  /// Called once a message's typewriter reveal finishes. Drops it from
  /// [_typewriterMessageIds] so this message renders as plain [Text] from
  /// here on — see the field's doc comment for why that's the part doing
  /// the real work, not the reveal widget's own internal state.
  void _markTypewriterComplete(String messageId) {
    if (!mounted) return;
    setState(() => _typewriterMessageIds.remove(messageId));
  }

  Future<void> _flag(MessageModel message) async {
    final reason = await showFlagMessageDialog(context);
    if (reason == null || !mounted) return;
    final ok = await ref
        .read(assistantChatProvider(widget.conversationId).notifier)
        .flag(message.id, reason);
    if (!mounted) return;
    AppSnackBar.show(
      context,
      ok ? context.t.assistant.reportSuccess : context.t.assistant.reportFailed,
      type: ok ? SnackBarType.success : SnackBarType.error,
    );
  }

  /// Opens the same specialization → template drill-down used in the empty
  /// state, in a modal sheet — the quick-reply chips aren't just a
  /// first-message affordance, they stay reachable for the rest of the
  /// conversation via this button.
  Future<void> _showTopicsSheet() async {
    final label = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.6,
        minChildSize: 0.3,
        maxChildSize: 0.9,
        builder: (_, scrollController) => SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg, 0, AppSpacing.lg, AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                context.t.assistant.topicsSheetTitle,
                style: Theme.of(sheetContext).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const Gap(16),
              _TopicPicker(onTap: (text) => Navigator.of(sheetContext).pop(text)),
            ],
          ),
        ),
      ),
    );
    if (label != null && mounted) await _sendText(label);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(assistantChatProvider(widget.conversationId));
    if (!_historySeeded && !state.loading) {
      _seenMessageIds.addAll(state.messages.map((m) => m.id));
      _historySeeded = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle(context.t.assistant.title,
            icon: Icons.smart_toy_outlined),
        actions: [
          IconButton(
            tooltip: context.t.assistant.topicsTooltip,
            onPressed: _showTopicsSheet,
            icon: const Icon(Icons.category_outlined),
          ),
        ],
      ),
      body: ResponsiveBody(
        child: switch ((state.loading, state.loadFailed)) {
          (true, _) => const ChatLoadingSkeleton(),
          (false, true) => EmptyState(
              icon: Icons.cloud_off_outlined,
              title: context.t.common.somethingWrong,
              subtitle: context.t.assistant.couldNotLoadChat,
              actionLabel: context.t.common.retry,
              onAction: () => ref
                  .read(assistantChatProvider(widget.conversationId).notifier)
                  .retryLoad(),
            ),
          _ => _buildChat(context, state),
        },
      ),
    );
  }

  Widget _buildChat(BuildContext context, AssistantChatState state) {
    final disclaimer = _disclaimerText(state.messages);
    final reversed = state.messages.reversed.toList();
    final itemCount = reversed.length + (state.sending ? 1 : 0);

    return Column(
      children: [
        if (disclaimer != null) ChatDisclaimerBanner(text: disclaimer),
        Expanded(
          child: state.messages.isEmpty && !state.sending
              ? _EmptyStateWithTopics(onTopicTap: _sendText)
              : ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.all(AppSpacing.md),
                  physics: const BouncingScrollPhysics(),
                  itemCount: itemCount,
                  itemBuilder: (context, i) {
                    if (state.sending && i == 0) {
                      return const _TypingIndicator();
                    }
                    final message = reversed[state.sending ? i - 1 : i];
                    final c = context.colors;
                    if (!message.isUser && _seenMessageIds.add(message.id)) {
                      _typewriterMessageIds.add(message.id);
                    }
                    return ChatMessageBubble(
                      key: ValueKey(message.id),
                      text: message.content,
                      isMine: message.isUser,
                      animateTyping: _typewriterMessageIds.contains(message.id),
                      onTypingComplete: () => _markTypewriterComplete(message.id),
                      trailing: message.isUser
                          ? null
                          : (message.flagged
                              ? Padding(
                                  padding: const EdgeInsets.all(AppSpacing.sm),
                                  child: Icon(Icons.flag_rounded,
                                      size: 16, color: c.textSecondary),
                                )
                              : IconButton(
                                  tooltip: context.t.assistant.reportTooltip,
                                  onPressed: () => _flag(message),
                                  visualDensity: VisualDensity.compact,
                                  icon: Icon(Icons.flag_outlined,
                                      size: 16, color: c.textSecondary),
                                )),
                      below: message.isUser
                          ? null
                          : [
                              for (final doctor in message.suggestedDoctors)
                                SuggestedDoctorCard(doctor: doctor),
                            ],
                    );
                  },
                ),
        ),
        ChatInputBar(
          controller: _inputController,
          enabled: !state.sending,
          canSend: _hasText && !state.sending,
          onSend: _send,
          hintText: context.t.assistant.inputHint,
          sendTooltip: context.t.assistant.send,
        ),
      ],
    );
  }
}

/// Empty-conversation state: the usual icon/title/subtitle plus every active
/// template as a tappable quick-reply chip, so a patient can start the chat
/// without typing. Scrollable — the bank easily exceeds one screen.
class _EmptyStateWithTopics extends StatelessWidget {
  const _EmptyStateWithTopics({required this.onTopicTap});

  final ValueChanged<String> onTopicTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.xl),
      children: [
        const Gap(8),
        Center(
          child: Container(
            width: 76,
            height: 76,
            decoration: BoxDecoration(color: c.primarySurface, shape: BoxShape.circle),
            child: Icon(Icons.health_and_safety_outlined, size: 38, color: c.primaryText),
          ),
        ),
        const Gap(16),
        Text(
          context.t.assistant.startTitle,
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        const Gap(6),
        Text(
          context.t.assistant.startSubtitle,
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        const Gap(20),
        _TopicPicker(onTap: onTopicTap),
      ],
    );
  }
}

/// The specialization → template drill-down, on its own so it can be shown
/// both in the empty state (above) and, once the conversation has messages
/// and that empty state is gone, inside the modal sheet opened from the app
/// bar's topics button — the whole point being that quick-replies aren't
/// only reachable before the first message.
class _TopicPicker extends ConsumerStatefulWidget {
  const _TopicPicker({required this.onTap});

  final ValueChanged<String> onTap;

  @override
  ConsumerState<_TopicPicker> createState() => _TopicPickerState();
}

class _TopicPickerState extends ConsumerState<_TopicPicker> {
  /// null = showing the top-level topic list; otherwise the specialization
  /// code of the topic currently drilled into.
  String? _selectedSpecialization;

  /// Groups the flat template bank by specialization, preserving the bank's
  /// own order — both across groups and within each one — rather than
  /// re-sorting; it's already curated server-side.
  List<_TopicGroup> _groupBySpecialization(List<AssistantTemplateOption> opts) {
    final groups = <String, _TopicGroup>{};
    for (final opt in opts) {
      groups
          .putIfAbsent(
            opt.specialization,
            () => _TopicGroup(
              specialization: opt.specialization,
              display: opt.specializationDisplay,
            ),
          )
          .options
          .add(opt);
    }
    return groups.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    final options = ref.watch(assistantTemplateOptionsProvider);

    return options.when(
      data: (opts) {
        if (opts.isEmpty) return const SizedBox.shrink();
        final groups = _groupBySpecialization(opts);
        final selectedSpec = _selectedSpecialization;
        final selectedGroup = selectedSpec == null
            ? null
            : groups.where((g) => g.specialization == selectedSpec).firstOrNull;

        // A single topic isn't worth a drill-down step — show its
        // templates directly, flattened, same as the old flat layout.
        final showTopics = groups.length > 1 && selectedGroup == null;

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 220),
          transitionBuilder: (child, anim) => FadeTransition(opacity: anim, child: child),
          child: showTopics
              ? _TopicChips(
                  key: const ValueKey('topics'),
                  groups: groups,
                  onSelect: (group) =>
                      setState(() => _selectedSpecialization = group.specialization),
                )
              : _TemplateChips(
                  key: ValueKey(selectedGroup?.specialization ?? 'all'),
                  options: selectedGroup?.options ?? opts,
                  // Omitted (rather than disabled) once there's only one
                  // topic overall — there's nowhere to go back to.
                  backLabel: (selectedGroup != null && groups.length > 1)
                      ? (selectedGroup.display.isEmpty
                          ? selectedGroup.specialization
                          : selectedGroup.display)
                      : null,
                  onBack: () => setState(() => _selectedSpecialization = null),
                  onTap: widget.onTap,
                ),
        );
      },
      loading: () => const Padding(
        padding: EdgeInsets.all(AppSpacing.md),
        child: Center(child: CircularProgressIndicator()),
      ),
      // Quiet failure — typing free text still works even if the
      // quick-reply chips fail to load.
      error: (_, _) => const SizedBox.shrink(),
    );
  }
}

class _TopicGroup {
  _TopicGroup({required this.specialization, required this.display});

  final String specialization;
  final String display;
  final List<AssistantTemplateOption> options = [];
}

/// Level 1 of the drill-down: one chip per specialization.
class _TopicChips extends StatelessWidget {
  const _TopicChips({super.key, required this.groups, required this.onSelect});

  final List<_TopicGroup> groups;
  final ValueChanged<_TopicGroup> onSelect;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final group in groups)
          ActionChip(
            label: Text(group.display.isEmpty ? group.specialization : group.display),
            onPressed: () => onSelect(group),
          ),
      ],
    );
  }
}

/// Level 2 of the drill-down: the specific templates within one topic — or
/// every template, flattened, when there was only ever one topic to begin
/// with ([backLabel] is null in that case, since there's nowhere to go back
/// to).
class _TemplateChips extends StatelessWidget {
  const _TemplateChips({
    super.key,
    required this.options,
    required this.backLabel,
    required this.onBack,
    required this.onTap,
  });

  final List<AssistantTemplateOption> options;
  final String? backLabel;
  final VoidCallback onBack;
  final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (backLabel != null) ...[
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: onBack,
              icon: const Icon(Icons.arrow_back_rounded, size: 16),
              label: Text(backLabel!),
              style: TextButton.styleFrom(visualDensity: VisualDensity.compact),
            ),
          ),
          const Gap(8),
        ],
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final option in options)
              ActionChip(
                label: Text(option.label),
                onPressed: () => onTap(option.label),
              ),
          ],
        ),
      ],
    );
  }
}

/// "The assistant is thinking" bubble: three dots bouncing in a staggered
/// wave, the standard chat-app pattern (iMessage/WhatsApp/Telegram) —
/// replaces a bare spinner because it reads as "composing a reply" rather
/// than "something is loading."
class _TypingIndicator extends StatelessWidget {
  const _TypingIndicator();

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, right: 64),
      child: Align(
        alignment: Alignment.centerLeft,
        // The dots are purely decorative to sighted users; a screen reader
        // still needs an explicit label since there's no visible text.
        child: Semantics(
          label: context.t.assistant.typing,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: c.surfaceAlt,
              border: Border.all(color: c.border),
              borderRadius: BorderRadius.circular(AppRadius.lg),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (var i = 0; i < 3; i++) _TypingDot(index: i, color: c.textSecondary),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TypingDot extends StatelessWidget {
  const _TypingDot({required this.index, required this.color});

  final int index;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final dot = Container(
      width: 7,
      height: 7,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
    final reducedMotion = MediaQuery.maybeOf(context)?.disableAnimations ?? false;
    if (reducedMotion) return dot;
    return dot
        .animate(onPlay: (c) => c.repeat(), delay: (index * 150).ms)
        .moveY(begin: 0, end: -5, duration: 380.ms, curve: Curves.easeInOut)
        .then()
        .moveY(begin: -5, end: 0, duration: 380.ms, curve: Curves.easeInOut)
        .then(delay: 300.ms);
  }
}

