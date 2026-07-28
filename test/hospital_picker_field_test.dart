import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medalize_mb/core/widgets/hospital_picker_field.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/features/hospital/data/models/hospital_model.dart';
import 'package:medalize_mb/features/hospital/data/repository/hospital_repository.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

class _FakeHospitalRepository extends HospitalRepository {
  _FakeHospitalRepository() : super(Dio());

  HospitalModel? created;

  @override
  Future<List<HospitalModel>> search({String q = '', String? city}) async {
    if (q == 'nomatch') return const [];
    return const [
      HospitalModel(id: 'h1', name: 'City Hospital', city: 'baku'),
    ];
  }

  @override
  Future<HospitalModel> create({
    required String name,
    required String city,
    String address = '',
  }) async {
    final hospital = HospitalModel(
      id: 'new-1',
      name: name,
      city: city,
      status: HospitalModel.statusPendingReview,
    );
    created = hospital;
    return hospital;
  }
}

class _Harness extends StatefulWidget {
  const _Harness({required this.city, required this.repo});

  final String? city;
  final HospitalRepository repo;

  @override
  State<_Harness> createState() => _HarnessState();
}

class _HarnessState extends State<_Harness> {
  String? _selectedId;
  String? _selectedLabel;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [hospitalRepositoryProvider.overrideWithValue(widget.repo)],
      child: TranslationProvider(
        child: MaterialApp(
          theme: AppTheme.light,
          home: Scaffold(
            body: HospitalPickerField(
              selectedId: _selectedId,
              selectedLabel: _selectedLabel,
              city: widget.city,
              onSelected: (hospital) => setState(() {
                _selectedId = hospital?.id;
                _selectedLabel = hospital?.name;
              }),
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  setUpAll(() => LocaleSettings.setLocale(AppLocale.en));

  testWidgets('disabled (does not open) until a city is set', (tester) async {
    await tester.pumpWidget(_Harness(city: null, repo: _FakeHospitalRepository()));
    await tester.pumpAndSettle();

    expect(find.text(t.hospitalPicker.selectCityFirst), findsOneWidget);

    await tester.tap(find.byType(InkWell));
    await tester.pumpAndSettle();

    // Nothing opened — the sheet's search field never appears.
    expect(find.text(t.hospitalPicker.searchHint), findsNothing);
  });

  testWidgets('opens a search sheet once a city is set, and selecting a result '
      'reports it back through onSelected', (tester) async {
    await tester.pumpWidget(_Harness(city: 'baku', repo: _FakeHospitalRepository()));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(InkWell));
    await tester.pumpAndSettle();

    expect(find.text(t.hospitalPicker.title), findsOneWidget);
    expect(find.text('City Hospital'), findsOneWidget);

    await tester.tap(find.text('City Hospital'));
    await tester.pumpAndSettle();

    expect(find.text('City Hospital'), findsOneWidget); // now shown as the field's label
    expect(find.text(t.hospitalPicker.title), findsNothing); // sheet closed
  });

  testWidgets('no-match search shows the "add your variant" tile, hidden for '
      'an empty query', (tester) async {
    final repo = _FakeHospitalRepository();
    await tester.pumpWidget(_Harness(city: 'baku', repo: repo));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(InkWell));
    await tester.pumpAndSettle();

    // Initial load (empty query) returns a match — no add-tile yet.
    expect(find.textContaining(t.hospitalPicker.addVariant(name: '')), findsNothing);

    await tester.enterText(find.byType(TextField), 'nomatch');
    // Debounce is 300ms.
    await tester.pump(const Duration(milliseconds: 350));
    await tester.pumpAndSettle();

    expect(find.text(t.hospitalPicker.noResultsFound), findsNothing);
    expect(find.text(t.hospitalPicker.addVariant(name: 'nomatch')), findsOneWidget);

    await tester.tap(find.text(t.hospitalPicker.addVariant(name: 'nomatch')));
    await tester.pumpAndSettle();

    expect(repo.created?.name, 'nomatch');
    expect(repo.created?.city, 'baku');
    // The sheet closed and the new hospital is now selected.
    expect(find.text('nomatch'), findsOneWidget);
  });
}
