import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/features/assistant/data/models/assistant_models.dart';
import 'package:medalize_mb/features/assistant/data/repository/assistant_repository.dart';
import 'package:medalize_mb/features/assistant/presentation/screens/conversation_summary_screen.dart';
import 'package:medalize_mb/i18n/strings.g.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:share_plus_platform_interface/share_plus_platform_interface.dart';

class _FakeAssistantRepository extends AssistantRepository {
  _FakeAssistantRepository(this.summary) : super(Dio());
  final ConversationSummaryModel summary;

  @override
  Future<ConversationDetailModel> generateSummary(String conversationId) async {
    return ConversationDetailModel(
      id: conversationId,
      messages: const [],
      summary: summary,
      summaryGeneratedAt: DateTime(2026, 7, 24, 12),
    );
  }
}

class _FakeSharePlatform extends SharePlatform with MockPlatformInterfaceMixin {
  ShareParams? lastParams;

  @override
  Future<ShareResult> share(ShareParams params) async {
    lastParams = params;
    return const ShareResult('ok', ShareResultStatus.success);
  }
}

ConversationSummaryModel _summary({
  String urgency = ConversationSummaryModel.urgencyRoutine,
  List<PossibleConditionModel> conditions = const [
    PossibleConditionModel(
      name: 'Tension headache',
      likelihood: PossibleConditionModel.likelihoodMedium,
      note: 'Common with stress and poor sleep.',
    ),
  ],
}) =>
    ConversationSummaryModel(
      summaryText: 'You described a mild recurring headache over the past week.',
      possibleConditions: conditions,
      urgency: urgency,
      recommendedSpecialization: 'neurology',
    );

Future<void> _pump(WidgetTester tester, ConversationSummaryModel summary) async {
  final router = GoRouter(
    initialLocation: '/summary',
    routes: [
      GoRoute(
        path: '/summary',
        builder: (_, _) => const ConversationSummaryScreen(conversationId: 'conv-1'),
      ),
      GoRoute(
        path: '/patient/doctor-search',
        builder: (_, _) => const Scaffold(body: Text('doctor-search')),
      ),
    ],
  );
  await tester.pumpWidget(
    TranslationProvider(
      child: ProviderScope(
        overrides: [
          assistantRepositoryProvider.overrideWithValue(_FakeAssistantRepository(summary)),
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
    SharePlatform.instance = _FakeSharePlatform();
  });

  for (final urgency in [
    ConversationSummaryModel.urgencyRoutine,
    ConversationSummaryModel.urgencySoon,
    ConversationSummaryModel.urgencyUrgent,
    ConversationSummaryModel.urgencyEmergency,
  ]) {
    testWidgets('renders the $urgency urgency state without error', (tester) async {
      await _pump(tester, _summary(urgency: urgency));

      expect(tester.takeException(), isNull);
      // Every state renders the summary text and the recommended specialist card.
      expect(
        find.textContaining('mild recurring headache'),
        findsOneWidget,
      );
      expect(find.textContaining('Neurology'), findsOneWidget);
      if (urgency == ConversationSummaryModel.urgencyEmergency) {
        expect(find.textContaining('emergency care'), findsOneWidget);
      }
    });
  }

  testWidgets('renders one card per possible condition with its likelihood chip',
      (tester) async {
    await _pump(
      tester,
      _summary(conditions: const [
        PossibleConditionModel(name: 'Migraine', likelihood: PossibleConditionModel.likelihoodHigh),
        PossibleConditionModel(name: 'Dehydration', likelihood: PossibleConditionModel.likelihoodLow),
      ]),
    );

    expect(find.text('Migraine'), findsOneWidget);
    expect(find.text('High'), findsOneWidget);
    expect(find.text('Dehydration'), findsOneWidget);
    expect(find.text('Low'), findsOneWidget);
  });

  testWidgets('the Find Doctors button navigates to the doctor search screen',
      (tester) async {
    await _pump(tester, _summary());

    await tester.tap(find.text('Find Doctors'));
    await tester.pumpAndSettle();

    expect(find.text('doctor-search'), findsOneWidget);
  });

  testWidgets('the Share button hands a plain-text summary to the native share sheet',
      (tester) async {
    await _pump(tester, _summary());
    final fake = SharePlatform.instance as _FakeSharePlatform;

    await tester.tap(find.byIcon(Icons.ios_share_rounded));
    await tester.pumpAndSettle();

    expect(fake.lastParams, isNotNull);
    expect(fake.lastParams!.text, contains('mild recurring headache'));
    expect(fake.lastParams!.text, contains('Tension headache'));
  });
}
