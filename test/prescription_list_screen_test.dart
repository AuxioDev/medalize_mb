import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/features/prescriptions/data/models/prescription_model.dart';
import 'package:medalize_mb/features/prescriptions/data/repository/prescription_repository.dart';
import 'package:medalize_mb/features/prescriptions/presentation/screens/prescription_list_screen.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

class _FakePrescriptionRepository extends PrescriptionRepository {
  _FakePrescriptionRepository(this.prescriptions) : super(Dio());
  final List<PrescriptionModel> prescriptions;

  @override
  Future<List<PrescriptionModel>> getPrescriptions() async => prescriptions;
}

PrescriptionModel _prescription({
  required String id,
  required String doctorName,
  List<PrescriptionItemModel> items = const [],
}) =>
    PrescriptionModel(
      id: id,
      doctorName: doctorName,
      issuedAt: DateTime(2026, 6, 1),
      items: items,
    );

Widget _app(_FakePrescriptionRepository repo) => TranslationProvider(
      child: ProviderScope(
        overrides: [prescriptionRepositoryProvider.overrideWithValue(repo)],
        child: MediaQuery(
          data: const MediaQueryData(disableAnimations: true),
          child: MaterialApp(
            theme: AppTheme.light,
            home: const PrescriptionListScreen(),
          ),
        ),
      ),
    );

void main() {
  testWidgets('renders each prescription with the issuing doctor and item count',
      (tester) async {
    final repo = _FakePrescriptionRepository([
      _prescription(id: 'p1', doctorName: 'Jane Doe', items: const [
        PrescriptionItemModel(drugName: 'Amoxicillin'),
        PrescriptionItemModel(drugName: 'Paracetamol'),
      ]),
    ]);
    await tester.pumpWidget(_app(repo));
    await tester.pumpAndSettle();

    expect(find.text('Issued by Dr. Jane Doe'), findsOneWidget);
    expect(find.text('2 medications'), findsOneWidget);
  });

  testWidgets('shows the empty state when there are no prescriptions', (tester) async {
    final repo = _FakePrescriptionRepository(const []);
    await tester.pumpWidget(_app(repo));
    await tester.pumpAndSettle();

    expect(find.text('No prescriptions yet'), findsOneWidget);
  });
}
