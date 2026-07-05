import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/widgets/shimmer_skeleton.dart';
import 'package:medalize_mb/features/doctor/presentation/screens/add_edit_workplace_screen.dart';
import 'package:medalize_mb/features/doctor/presentation/screens/workplace_list_screen.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

const _workplace = <String, dynamic>{
  'id': 'w1',
  'name': 'City Clinic',
  'address': '12 Main St',
  'city': 'Baku',
  'type': 'clinic',
  'is_primary': true,
};

Widget _wrap(Widget child, {List<Override> overrides = const []}) {
  return TranslationProvider(
    child: ProviderScope(
      overrides: overrides,
      child: MaterialApp(theme: AppTheme.light, home: child),
    ),
  );
}

void main() {
  testWidgets(
      'renders AddEditWorkplaceScreen immediately when existing provided',
      (tester) async {
    var fetched = false;
    await tester.pumpWidget(_wrap(
      const EditWorkplaceLoader(workplaceId: 'w1', existing: _workplace),
      overrides: [
        workplacesProvider.overrideWith((ref) async {
          fetched = true;
          return [_workplace];
        }),
      ],
    ));
    await tester.pump();

    expect(tester.takeException(), isNull);
    expect(find.byType(AddEditWorkplaceScreen), findsOneWidget);
    expect(find.byType(ShimmerSkeleton), findsNothing);
    // Form is pre-filled from the passed-in map.
    expect(find.text('City Clinic'), findsOneWidget);
    expect(fetched, isFalse,
        reason: 'must not fetch when existing workplace is provided');
  });

  testWidgets(
      'loads workplaces and picks the matching one when extra is null',
      (tester) async {
    await tester.pumpWidget(_wrap(
      const EditWorkplaceLoader(workplaceId: 'w1'),
      overrides: [
        workplacesProvider.overrideWith((ref) async => [
              {'id': 'w0', 'name': 'Other Clinic'},
              _workplace,
            ]),
      ],
    ));

    // First frame: still loading — skeleton visible.
    expect(find.byType(ShimmerSkeleton), findsWidgets);
    expect(find.byType(AddEditWorkplaceScreen), findsNothing);

    await tester.pump();
    expect(tester.takeException(), isNull);
    expect(find.byType(AddEditWorkplaceScreen), findsOneWidget);
    expect(find.text('City Clinic'), findsOneWidget);
    expect(find.text('Other Clinic'), findsNothing);
  });

  testWidgets('shows error state when the workplace id is not in the list',
      (tester) async {
    await tester.pumpWidget(_wrap(
      const EditWorkplaceLoader(workplaceId: 'missing'),
      overrides: [
        workplacesProvider.overrideWith((ref) async => [_workplace]),
      ],
    ));
    await tester.pump();

    expect(tester.takeException(), isNull);
    expect(find.text('Something went wrong'), findsOneWidget);
    expect(find.byType(AddEditWorkplaceScreen), findsNothing);
  });

  testWidgets('shows error state when the fetch fails', (tester) async {
    await tester.pumpWidget(_wrap(
      const EditWorkplaceLoader(workplaceId: 'w1'),
      overrides: [
        workplacesProvider.overrideWith(
          (ref) => Future<List<Map<String, dynamic>>>.error(
              Exception('network')),
        ),
      ],
    ));
    await tester.pump();

    expect(tester.takeException(), isNull);
    expect(find.text('Something went wrong'), findsOneWidget);
    expect(find.byType(AddEditWorkplaceScreen), findsNothing);
  });
}
