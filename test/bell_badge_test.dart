import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medalize_mb/core/widgets/message_bell.dart';
import 'package:medalize_mb/core/widgets/notification_bell.dart';

/// Regression test for a ParentDataWidget crash: `Positioned` was nested
/// inside the `AnimatedSwitcher`'s ScaleTransition/FadeTransition instead of
/// wrapping it, so it wasn't a direct child of the Stack when the badge count
/// changed and the switcher started a transition. Only throws mid-animation,
/// not on a static build — must pump through AppDuration.fast to catch it.
void main() {
  Future<void> pumpChangingBadge(WidgetTester tester, Widget Function(int) build) async {
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: build(0))));
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: build(3))));
    await tester.pump(const Duration(milliseconds: 60));
    await tester.pump(const Duration(milliseconds: 60));
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: build(7))));
    await tester.pump(const Duration(milliseconds: 60));
    await tester.pump(const Duration(milliseconds: 200));
  }

  testWidgets('MessageBell survives a badge count change without a ParentDataWidget error',
      (tester) async {
    await pumpChangingBadge(
      tester,
      (count) => MessageBell(count: count, onTap: () {}),
    );
    expect(tester.takeException(), isNull);
    expect(find.text('7'), findsOneWidget);
  });

  testWidgets('NotificationBell survives a badge count change without a ParentDataWidget error',
      (tester) async {
    await pumpChangingBadge(
      tester,
      (count) => NotificationBell(count: count, onTap: () {}),
    );
    expect(tester.takeException(), isNull);
    expect(find.text('7'), findsOneWidget);
  });

  testWidgets('MessageBell badge disappears cleanly when count drops to zero',
      (tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(body: MessageBell(count: 5, onTap: () {}))));
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(body: MessageBell(count: 0, onTap: () {}))));
    await tester.pump(const Duration(milliseconds: 60));
    await tester.pump(const Duration(milliseconds: 200));
    expect(tester.takeException(), isNull);
    expect(find.text('5'), findsNothing);
  });
}
