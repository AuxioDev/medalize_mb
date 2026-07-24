import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/features/records/data/models/medical_record_model.dart';
import 'package:medalize_mb/features/records/data/repository/medical_record_repository.dart';
import 'package:medalize_mb/features/records/presentation/screens/records_list_screen.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

class _FakeMedicalRecordRepository extends MedicalRecordRepository {
  _FakeMedicalRecordRepository(this.records) : super(Dio());
  final List<MedicalRecordModel> records;
  String? deletedId;

  @override
  Future<List<MedicalRecordModel>> getRecords() async => records;

  @override
  Future<void> deleteRecord(String id) async {
    deletedId = id;
  }
}

MedicalRecordModel _record({
  required String id,
  required String title,
  String type = MedicalRecordModel.typeLabResult,
}) =>
    MedicalRecordModel(
      id: id,
      recordType: type,
      title: title,
      createdAt: DateTime(2026, 1, 1),
    );

Widget _app(_FakeMedicalRecordRepository repo) => TranslationProvider(
      child: ProviderScope(
        overrides: [medicalRecordRepositoryProvider.overrideWithValue(repo)],
        child: MediaQuery(
          data: const MediaQueryData(disableAnimations: true),
          child: MaterialApp(theme: AppTheme.light, home: const RecordsListScreen()),
        ),
      ),
    );

void main() {
  testWidgets('groups records by type under section headers', (tester) async {
    final repo = _FakeMedicalRecordRepository([
      _record(id: 'r1', title: 'Blood Panel', type: MedicalRecordModel.typeLabResult),
      _record(id: 'r2', title: 'Chest X-Ray', type: MedicalRecordModel.typeImaging),
    ]);
    await tester.pumpWidget(_app(repo));
    await tester.pumpAndSettle();

    expect(find.text('Lab Result'), findsOneWidget);
    expect(find.text('Imaging'), findsOneWidget);
    expect(find.text('Blood Panel'), findsOneWidget);
    expect(find.text('Chest X-Ray'), findsOneWidget);
  });

  testWidgets('shows the empty state when there are no records', (tester) async {
    final repo = _FakeMedicalRecordRepository(const []);
    await tester.pumpWidget(_app(repo));
    await tester.pumpAndSettle();

    expect(find.text('No health records yet'), findsOneWidget);
  });

  testWidgets('deleting a record asks for confirmation then calls the repo',
      (tester) async {
    final repo =
        _FakeMedicalRecordRepository([_record(id: 'r1', title: 'Blood Panel')]);
    await tester.pumpWidget(_app(repo));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.delete_outline));
    await tester.pumpAndSettle();
    expect(find.text('Delete Record'), findsOneWidget);

    await tester.tap(find.text('Delete').last);
    await tester.pumpAndSettle();

    expect(repo.deletedId, 'r1');
  });
}
