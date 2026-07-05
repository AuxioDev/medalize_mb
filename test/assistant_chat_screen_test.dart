import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/features/assistant/data/models/assistant_models.dart';
import 'package:medalize_mb/features/assistant/data/repository/assistant_repository.dart';
import 'package:medalize_mb/features/assistant/presentation/screens/assistant_chat_screen.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

class _FakeAssistantRepository extends AssistantRepository {
  _FakeAssistantRepository({this.messages = const []}) : super(Dio());

  final List<MessageModel> messages;

  /// When set, sendMessage waits on this so the typing indicator is
  /// observable; otherwise it replies immediately.
  Completer<MessageModel>? sendCompleter;

  String? lastSentContent;
  String? lastFlaggedId;
  String? lastFlagReason;

  @override
  Future<ConversationDetailModel> getConversation(String id) async {
    return ConversationDetailModel(id: id, messages: messages);
  }

  @override
  Future<MessageModel> sendMessage(String conversationId, String content) async {
    lastSentContent = content;
    if (sendCompleter != null) return sendCompleter!.future;
    return MessageModel(
      id: 'reply-1',
      role: MessageModel.roleAssistant,
      content: 'Assistant reply',
      createdAt: DateTime(2026, 7, 4, 12),
    );
  }

  @override
  Future<void> flagMessage(String messageId, {String reason = ''}) async {
    lastFlaggedId = messageId;
    lastFlagReason = reason;
  }
}

final _sampleMessages = [
  MessageModel(
    id: 'm1',
    role: MessageModel.roleUser,
    content: 'I have chest pain',
    createdAt: DateTime(2026, 7, 4, 10),
  ),
  MessageModel(
    id: 'm2',
    role: MessageModel.roleAssistant,
    content:
        'Chest pain can be serious — please see a cardiologist in person.\n\n'
        'This assistant does not provide medical diagnoses.',
    createdAt: DateTime(2026, 7, 4, 10, 0, 5),
    suggestedDoctors: const [
      SuggestedDoctor(
        id: 'doc-1',
        firstName: 'Aysel',
        lastName: 'Mammadova',
        specializationDisplay: 'Cardiology',
        averageRating: 4.8,
        city: 'Baku',
      ),
    ],
  ),
];

Future<void> _pump(WidgetTester tester, AssistantRepository repo) async {
  final router = GoRouter(
    initialLocation: '/chat',
    routes: [
      GoRoute(
        path: '/chat',
        builder: (_, _) => const AssistantChatScreen(conversationId: 'conv-1'),
      ),
      GoRoute(
        path: '/patient/doctor-detail/:id',
        builder: (_, state) => Scaffold(
          body: Text('doctor-detail:${state.pathParameters['id']}'),
        ),
      ),
    ],
  );
  await tester.pumpWidget(
    TranslationProvider(
      child: ProviderScope(
        overrides: [assistantRepositoryProvider.overrideWithValue(repo)],
        child: MaterialApp.router(theme: AppTheme.light, routerConfig: router),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets(
      'renders both bubbles and pins the backend disclaimer in the top banner',
      (tester) async {
    await _pump(tester, _FakeAssistantRepository(messages: _sampleMessages));

    expect(tester.takeException(), isNull);
    expect(find.text('I have chest pain'), findsOneWidget);
    expect(find.textContaining('please see a cardiologist'), findsOneWidget);
    // The banner shows exactly the disclaimer paragraph the backend appended.
    expect(
      find.text('This assistant does not provide medical diagnoses.'),
      findsOneWidget,
    );
  });

  testWidgets(
      'shows the suggested doctor card and Book opens the doctor detail route',
      (tester) async {
    await _pump(tester, _FakeAssistantRepository(messages: _sampleMessages));

    expect(find.text('Dr. Aysel Mammadova'), findsOneWidget);
    expect(find.text('4.8'), findsOneWidget);
    expect(find.text('Cardiology · Baku'), findsOneWidget);

    await tester.tap(find.text('Book'));
    await tester.pumpAndSettle();

    expect(find.text('doctor-detail:doc-1'), findsOneWidget);
  });

  testWidgets('the flag dialog reports the assistant message with a reason',
      (tester) async {
    final repo = _FakeAssistantRepository(messages: _sampleMessages);
    await _pump(tester, repo);

    await tester.tap(find.byIcon(Icons.flag_outlined));
    await tester.pumpAndSettle();

    expect(find.text('Report response'), findsOneWidget);
    await tester.enterText(find.byType(TextField).last, 'Sounded like a diagnosis');
    await tester.tap(find.text('Report'));
    await tester.pumpAndSettle();

    expect(repo.lastFlaggedId, 'm2');
    expect(repo.lastFlagReason, 'Sounded like a diagnosis');
    // The bubble now shows the flagged marker instead of the report button.
    expect(find.byIcon(Icons.flag_rounded), findsOneWidget);
    expect(find.byIcon(Icons.flag_outlined), findsNothing);
  });

  testWidgets('cancelling the flag dialog does not report anything',
      (tester) async {
    final repo = _FakeAssistantRepository(messages: _sampleMessages);
    await _pump(tester, repo);

    await tester.tap(find.byIcon(Icons.flag_outlined));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(repo.lastFlaggedId, isNull);
    expect(find.byIcon(Icons.flag_outlined), findsOneWidget);
  });

  testWidgets(
      'sending shows the user bubble and typing indicator immediately, '
      'then the assistant reply', (tester) async {
    final repo = _FakeAssistantRepository(messages: _sampleMessages)
      ..sendCompleter = Completer<MessageModel>();
    await _pump(tester, repo);

    await tester.enterText(find.byType(TextField), 'It hurts when I breathe');
    await tester.pump();
    await tester.tap(find.byIcon(Icons.arrow_upward_rounded));
    await tester.pump();

    // Optimistic: the message is on screen before the server answered.
    expect(find.text('It hurts when I breathe'), findsOneWidget);
    expect(find.text('Assistant is typing…'), findsOneWidget);
    expect(repo.lastSentContent, 'It hurts when I breathe');

    repo.sendCompleter!.complete(MessageModel(
      id: 'reply-9',
      role: MessageModel.roleAssistant,
      content: 'Please seek in-person care.',
      createdAt: DateTime(2026, 7, 4, 12),
    ));
    await tester.pumpAndSettle();

    expect(find.text('Assistant is typing…'), findsNothing);
    expect(find.text('Please seek in-person care.'), findsOneWidget);
  });
}
