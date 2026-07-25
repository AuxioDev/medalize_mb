import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/features/auth/providers/auth_provider.dart';
import 'package:medalize_mb/features/auth/providers/auth_state.dart';
import 'package:medalize_mb/features/messaging/data/models/messaging_models.dart';
import 'package:medalize_mb/features/messaging/presentation/screens/thread_list_screen.dart';
import 'package:medalize_mb/features/messaging/providers/messaging_provider.dart';
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

const _doctorAuth = AuthAuthenticated(
  accessToken: 'a',
  refreshToken: 'r',
  role: 'doctor',
  userId: 'doctor-1',
  email: 'd@example.com',
  onboardingComplete: true,
);

ThreadModel _thread({
  String id = 'thread-1',
  int unreadCount = 0,
  MessageModel? lastMessage,
}) =>
    ThreadModel(
      id: id,
      patient: const ThreadParticipant(id: 'patient-1', firstName: 'Leyla', lastName: 'Huseynova'),
      doctor: const ThreadParticipant(
        id: 'doctor-1',
        firstName: 'Aysel',
        lastName: 'Mammadova',
        specializationDisplay: 'Cardiology',
      ),
      lastMessage: lastMessage,
      unreadCount: unreadCount,
      updatedAt: DateTime(2026, 7, 24, 10),
    );

Future<void> _pump(
  WidgetTester tester, {
  required List<ThreadModel> threads,
  AuthState auth = _patientAuth,
}) async {
  final router = GoRouter(
    initialLocation: '/list',
    routes: [
      GoRoute(path: '/list', builder: (_, _) => const ThreadListScreen()),
      GoRoute(
        path: '/patient/messages/:id',
        builder: (_, state) => Scaffold(
          body: Text('patient-chat:${state.pathParameters['id']}'),
        ),
      ),
      GoRoute(
        path: '/doctor/messages/:id',
        builder: (_, state) => Scaffold(
          body: Text('doctor-chat:${state.pathParameters['id']}'),
        ),
      ),
    ],
  );
  await tester.pumpWidget(
    TranslationProvider(
      child: ProviderScope(
        overrides: [
          authProvider.overrideWith(() => _FakeAuthNotifier(auth)),
          // Overriding the FutureProvider directly (not just its repository)
          // skips the 60s Timer.periodic entirely for the test.
          threadsProvider.overrideWith((ref) async => threads),
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

  testWidgets(
      'renders the counterpart name, last-message preview, and unread badge',
      (tester) async {
    await _pump(tester, threads: [
      _thread(
        unreadCount: 3,
        lastMessage: MessageModel(
          id: 'm1',
          threadId: 'thread-1',
          senderId: 'doctor-1',
          isMine: false,
          body: 'See you at 10am',
          createdAt: DateTime(2026, 7, 24, 9),
        ),
      ),
    ]);

    expect(tester.takeException(), isNull);
    // Patient view: the counterpart shown is the doctor.
    expect(find.text('Aysel Mammadova'), findsOneWidget);
    expect(find.text('See you at 10am'), findsOneWidget);
    expect(find.text('3'), findsOneWidget);
  });

  testWidgets('doctor view shows the patient as the counterpart', (tester) async {
    await _pump(tester, threads: [_thread()], auth: _doctorAuth);

    expect(find.text('Leyla Huseynova'), findsOneWidget);
  });

  testWidgets('shows the empty state when there are no threads', (tester) async {
    await _pump(tester, threads: const []);

    expect(find.text('No conversations yet'), findsOneWidget);
  });

  testWidgets('tapping a thread pushes the role-appropriate chat route',
      (tester) async {
    await _pump(tester, threads: [_thread()]);

    await tester.tap(find.text('Aysel Mammadova'));
    await tester.pumpAndSettle();

    expect(find.text('patient-chat:thread-1'), findsOneWidget);
  });
}
