claudimport 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medalize_mb/core/utils/validators.dart';
import 'package:medalize_mb/core/widgets/primary_button.dart';

void main() {
  testWidgets('LoadingFilledButton renders its label and fires onPressed',
      (tester) async {
    var tapped = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: LoadingFilledButton(
            label: 'Continue',
            onPressed: () => tapped = true,
          ),
        ),
      ),
    );

    expect(find.text('Continue'), findsOneWidget);
    await tester.tap(find.byType(LoadingFilledButton));
    await tester.pump();
    expect(tapped, isTrue);
  });

  testWidgets('LoadingFilledButton is disabled while loading', (tester) async {
    var tapped = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: LoadingFilledButton(
            label: 'Saving',
            loading: true,
            onPressed: () => tapped = true,
          ),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.tap(find.byType(LoadingFilledButton));
    await tester.pump();
    expect(tapped, isFalse);
  });

  testWidgets('A form using Validators surfaces an error on bad input',
      (tester) async {
    final formKey = GlobalKey<FormState>();
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Form(
            key: formKey,
            child: TextFormField(validator: Validators.email),
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(TextFormField), 'not-an-email');
    formKey.currentState!.validate();
    await tester.pump();
    expect(find.text('Enter a valid email address'), findsOneWidget);
  });
}
