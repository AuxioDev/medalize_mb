import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/widgets/app_badge.dart';
import 'package:medalize_mb/core/widgets/app_chip.dart';
import 'package:medalize_mb/core/widgets/primary_button.dart';
import 'package:medalize_mb/core/widgets/section_header.dart';
import 'package:medalize_mb/core/widgets/status_chip.dart';
import 'package:medalize_mb/features/auth/presentation/widgets/animated_button.dart';
import 'package:medalize_mb/features/auth/presentation/widgets/social_login_buttons.dart';
import 'package:medalize_mb/features/doctor/presentation/widgets/slot_duration_selector.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

/// A label roughly 3x longer than any real translation — if a widget survives
/// this inside a narrow parent without a RenderFlex overflow, it is safe for
/// the long ru/tr/fr/az strings.
const _longLabel =
    'An unreasonably long translated label that would never fit on a phone '
    'screen in one line no matter the locale or font scale';

Widget _host(Widget child, {double width = 320}) {
  return TranslationProvider(
    child: MaterialApp(
      theme: AppTheme.light,
      home: Scaffold(
        body: Center(
          child: SizedBox(width: width, child: child),
        ),
      ),
    ),
  );
}

void main() {
  group('SectionHeader', () {
    testWidgets('ellipsizes a long title and keeps the action button',
        (tester) async {
      var actioned = false;
      await tester.pumpWidget(_host(
        SectionHeader(
          title: _longLabel,
          actionLabel: 'See all',
          onAction: () => actioned = true,
        ),
        width: 280,
      ));

      final title = tester.widget<Text>(find.text(_longLabel));
      expect(title.maxLines, 1);
      expect(title.overflow, TextOverflow.ellipsis);
      expect(find.text('See all'), findsOneWidget);
      expect(find.byIcon(Icons.chevron_right), findsOneWidget);

      await tester.tap(find.text('See all'));
      expect(actioned, isTrue);
    });

    testWidgets('renders a title-only header without an action',
        (tester) async {
      await tester.pumpWidget(_host(const SectionHeader(title: 'Upcoming')));
      expect(find.text('Upcoming'), findsOneWidget);
      expect(find.byType(TextButton), findsNothing);
    });
  });

  group('AppChip.filter', () {
    testWidgets('renders, toggles and survives a long label in a narrow row',
        (tester) async {
      String? picked;
      await tester.pumpWidget(_host(
        Row(
          children: [
            Flexible(
              child: AppChip.filter(
                label: _longLabel,
                selected: false,
                onSelected: (_) => picked = 'spec',
              ),
            ),
          ],
        ),
        width: 160,
      ));

      final label = tester.widget<Text>(find.text(_longLabel));
      expect(label.maxLines, 1);
      expect(label.overflow, TextOverflow.ellipsis);

      await tester.tap(find.byType(AppChip));
      await tester.pump();
      expect(picked, 'spec');
    });

    testWidgets('renders a leading widget next to the label', (tester) async {
      await tester.pumpWidget(_host(
        AppChip.filter(
          label: '4+',
          leading: const Icon(Icons.star_rounded, size: 13),
          selected: true,
          onSelected: (_) {},
        ),
      ));
      expect(find.byIcon(Icons.star_rounded), findsOneWidget);
      expect(find.text('4+'), findsOneWidget);
    });
  });

  group('AppChip.choice', () {
    testWidgets('fires onTap and ellipsizes a long label', (tester) async {
      var tapped = false;
      await tester.pumpWidget(_host(
        AppChip.choice(
          label: _longLabel,
          selected: false,
          onTap: () => tapped = true,
        ),
        width: 140,
      ));

      final label = tester.widget<Text>(find.text(_longLabel));
      expect(label.maxLines, 1);
      expect(label.overflow, TextOverflow.ellipsis);

      await tester.tap(find.byType(AppChip));
      expect(tapped, isTrue);
    });

    testWidgets('a null onTap disables the chip', (tester) async {
      await tester.pumpWidget(_host(
        const AppChip.choice(label: '30 min', selected: false, onTap: null),
      ));
      // Tapping a disabled chip must not throw; the Opacity dim is applied.
      await tester.tap(find.byType(AppChip));
      expect(find.byType(Opacity), findsOneWidget);
    });
  });

  group('AppBadge', () {
    testWidgets('renders its label', (tester) async {
      await tester.pumpWidget(_host(const AppBadge(label: 'Primary')));
      expect(find.text('Primary'), findsOneWidget);
    });

    testWidgets('clamps a long label to one line in a tight spot',
        (tester) async {
      await tester.pumpWidget(_host(
        const AppBadge(label: _longLabel),
        width: 70,
      ));
      final label = tester.widget<Text>(find.text(_longLabel));
      expect(label.maxLines, 1);
      expect(label.overflow, TextOverflow.ellipsis);
    });
  });

  group('StatusChip', () {
    testWidgets('ellipsizes an extremely long status label', (tester) async {
      // Unmapped statuses fall back to title-casing, so this exercises the
      // chip with a label far longer than any real translation.
      const status =
          'requires_rescheduling_after_an_extremely_long_translated_reason';
      await tester.pumpWidget(_host(
        const StatusChip(status: status),
        width: 90,
      ));

      final label =
          tester.widget<Text>(find.text(StatusChip.labelFor(status)));
      expect(label.maxLines, 1);
      expect(label.overflow, TextOverflow.ellipsis);
    });
  });

  group('button label protection', () {
    testWidgets(
        'LoadingFilledButton with an icon fits a long label in a narrow width',
        (tester) async {
      await tester.pumpWidget(_host(
        LoadingFilledButton(
          label: _longLabel,
          icon: Icons.check,
          onPressed: () {},
        ),
        width: 200,
      ));
      final label = tester.widget<Text>(find.text(_longLabel));
      expect(label.maxLines, 1);
      expect(label.overflow, TextOverflow.ellipsis);
      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    testWidgets('AnimatedButton fits a long label in a narrow width',
        (tester) async {
      await tester.pumpWidget(_host(
        AnimatedButton(label: _longLabel, onPressed: () {}),
        width: 200,
      ));
      final label = tester.widget<Text>(find.text(_longLabel));
      expect(label.maxLines, 1);
      expect(label.overflow, TextOverflow.ellipsis);
    });
  });

  group('section B spot fixes', () {
    testWidgets('SocialLoginButtons render inside a narrow column',
        (tester) async {
      await tester.pumpWidget(_host(
        SocialLoginButtons(
          enabled: true,
          onGoogleTap: () {},
          onAppleTap: () {},
        ),
        width: 200,
      ));
      // The Google label lives in a Flexible with single-line ellipsis, so a
      // 200px column must render without a RenderFlex overflow.
      expect(find.byType(OutlinedButton), findsOneWidget);
    });

    testWidgets('SlotDurationSelector selects a duration via AppChip.choice',
        (tester) async {
      int? selected;
      await tester.pumpWidget(_host(
        SlotDurationSelector(selected: 30, onSelect: (v) => selected = v),
      ));
      expect(find.byType(AppChip), findsNWidgets(kSlotDurations.length));

      await tester.tap(find.byType(AppChip).first);
      await tester.pump();
      expect(selected, kSlotDurations.first);
    });
  });
}
