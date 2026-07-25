import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/features/auth/providers/auth_provider.dart';
import 'package:medalize_mb/features/auth/providers/auth_state.dart';
import 'package:medalize_mb/features/messaging/data/models/messaging_models.dart';
import 'package:medalize_mb/features/messaging/data/repository/messaging_repository.dart';
import 'package:medalize_mb/features/messaging/presentation/screens/thread_chat_screen.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

class _FakeAuthNotifier extends AuthNotifier {
  _FakeAuthNotifier(this._fixed);
  final AuthState _fixed;
  @override
  AuthState build() => _fixed;
}

const _patientAuth = AuthAuthenticated(
  accessToken: 'a',
  refreshToken: 'r',
  role: 'patient',
  userId: 'patient-1',
  email: 'p@example.com',
  onboardingComplete: true,
);

class _FakeMessagingRepository extends MessagingRepository {
  _FakeMessagingRepository() : super(Dio());

  /// When set, sendMessage waits on this so the optimistic state is
  /// observable; otherwise it replies immediately.
  Completer<MessageModel>? sendCompleter;

  String? lastSentBody;

  @override
  Future<List<MessageModel>> getAllMessages(String threadId) async => const [];

  @override
  Future<MessageModel> sendMessage(String threadId, String body) async {
    lastSentBody = body;
    if (sendCompleter != null) return sendCompleter!.future;
    return MessageModel(
      id: 'server-1',
      threadId: threadId,
      senderId: 'patient-1',
      isMine: true,
      body: body,
      createdAt: DateTime(2026, 7, 24, 12),
    );
  }
}

final _thread = ThreadModel(
  id: 'thread-1',
  patient: const ThreadParticipant(id: 'patient-1', firstName: 'Leyla', lastName: 'Huseynova'),
  doctor: const ThreadParticipant(
    id: 'doctor-1',
    firstName: 'Aysel',
    lastName: 'Mammadova',
    specializationDisplay: 'Cardiology',
  ),
  updatedAt: DateTime(2026, 7, 24, 10),
);

Future<void> _pump(WidgetTester tester, MessagingRepository repo) async {
  final router = GoRouter(
    initialLocation: '/chat',
    routes: [
      GoRoute(
        path: '/chat',
        builder: (_, _) => ThreadChatScreen(threadId: 'thread-1', thread: _thread),
      ),
    ],
  );
  await tester.pumpWidget(
    TranslationProvider(
      child: ProviderScope(
        overrides: [
          authProvider.overrideWith(() => _FakeAuthNotifier(_patientAuth)),
          messagingRepositoryProvider.overrideWithValue(repo),
        ],
        child: MediaQuery(
          data: const MediaQueryData(disableAnimations: true),
          child: MaterialApp.router(theme: AppTheme.light, routerConfig: router),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  setUp(() {
    FlutterSecureStorage.setMockInitialValues({});
  });

  testWidgets('shows the counterpart name in the app bar and the disclaimer banner',
      (tester) async {
    await _pump(tester, _FakeMessagingRepository());

    expect(tester.takeException(), isNull);
    expect(find.text('Aysel Mammadova'), findsOneWidget);
    expect(
      find.textContaining('not an emergency line'),
      findsOneWidget,
    );
  });

  testWidgets(
      'sending a message shows the outgoing bubble immediately (optimistic), '
      'before the server confirms it', (tester) async {
    final repo = _FakeMessagingRepository()..sendCompleter = Completer<MessageModel>();
    await _pump(tester, repo);

    await tester.enterText(find.byType(TextField), 'I am running 10 minutes late');
    await tester.pump();
    await tester.tap(find.byIcon(Icons.arrow_upward_rounded));
    await tester.pump();

    // Optimistic: the message is on screen before the server answered.
    expect(find.text('I am running 10 minutes late'), findsOneWidget);
    expect(repo.lastSentBody, 'I am running 10 minutes late');

    repo.sendCompleter!.complete(MessageModel(
      id: 'server-9',
      threadId: 'thread-1',
      senderId: 'patient-1',
      isMine: true,
      body: 'I am running 10 minutes late',
      createdAt: DateTime(2026, 7, 24, 12),
    ));
    await tester.pumpAndSettle();

    // Still on screen after the server confirms — now backed by the server copy.
    expect(find.text('I am running 10 minutes late'), findsOneWidget);
  });
}
