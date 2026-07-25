import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/features/family/data/models/dependent_model.dart';
import 'package:medalize_mb/features/family/providers/family_provider.dart';
import 'package:medalize_mb/features/records/data/models/medical_record_model.dart';
import 'package:medalize_mb/features/records/data/repository/medical_record_repository.dart';
import 'package:medalize_mb/features/records/presentation/screens/upload_record_screen.dart';
import 'package:medalize_mb/i18n/strings.g.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class _FakeFilePicker extends FilePicker with MockPlatformInterfaceMixin {
  @override
  Future<FilePickerResult?> pickFiles({
    String? dialogTitle,
    String? initialDirectory,
    FileType type = FileType.any,
    List<String>? allowedExtensions,
    dynamic onFileLoading,
    bool allowCompression = true,
    int compressionQuality = 30,
    bool allowMultiple = false,
    bool withData = false,
    bool withReadStream = false,
    bool lockParentWindow = false,
    bool readSequential = false,
  }) async {
    return FilePickerResult([
      PlatformFile(name: 'blood-panel.pdf', size: 1024, path: '/tmp/blood-panel.pdf'),
    ]);
  }
}

class _FakeMedicalRecordRepository extends MedicalRecordRepository {
  _FakeMedicalRecordRepository() : super(Dio());

  String? uploadedType;
  String? uploadedTitle;
  String? uploadedFilePath;
  String? uploadedDependentId;

  @override
  Future<MedicalRecordModel> uploadRecord({
    required String recordType,
    required String title,
    DateTime? recordDate,
    String notes = '',
    required String filePath,
    String? dependentId,
  }) async {
    uploadedType = recordType;
    uploadedTitle = title;
    uploadedFilePath = filePath;
    uploadedDependentId = dependentId;
    return MedicalRecordModel(id: 'new-r', title: title, createdAt: DateTime(2026, 1, 1));
  }
}

Future<void> _pump(
  WidgetTester tester,
  _FakeMedicalRecordRepository repo, {
  DependentModel? activeProfile,
}) async {
  tester.view.physicalSize = const Size(480, 1400);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);

  final router = GoRouter(
    initialLocation: '/list',
    routes: [
      GoRoute(path: '/list', builder: (_, _) => const Scaffold(body: Text('list-screen'))),
      GoRoute(path: '/upload', builder: (_, _) => const UploadRecordScreen()),
    ],
  );
  await tester.pumpWidget(
    TranslationProvider(
      child: ProviderScope(
        overrides: [
          medicalRecordRepositoryProvider.overrideWithValue(repo),
          if (activeProfile != null)
            activeProfileProvider.overrideWith((ref) => activeProfile),
        ],
        child: MaterialApp.router(theme: AppTheme.light, routerConfig: router),
      ),
    ),
  );
  router.push('/upload');
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(() {
    FilePicker.platform = _FakeFilePicker();
  });

  testWidgets('shows a validation error when the title is empty', (tester) async {
    final repo = _FakeMedicalRecordRepository();
    await _pump(tester, repo);

    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(find.text('Title is required'), findsOneWidget);
    expect(repo.uploadedTitle, isNull);
  });

  testWidgets('shows a validation error when no file was chosen', (tester) async {
    final repo = _FakeMedicalRecordRepository();
    await _pump(tester, repo);

    await tester.enterText(find.widgetWithText(TextField, 'Title'), 'Blood Panel');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(find.text('Choose a file to upload'), findsOneWidget);
    expect(repo.uploadedFilePath, isNull);
  });

  testWidgets('picking a file and saving uploads the record', (tester) async {
    final repo = _FakeMedicalRecordRepository();
    await _pump(tester, repo);

    await tester.enterText(find.widgetWithText(TextField, 'Title'), 'Blood Panel');
    await tester.tap(find.text('Choose File'));
    await tester.pumpAndSettle();

    expect(find.text('blood-panel.pdf'), findsOneWidget);

    await tester.tap(find.text('Save'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(repo.uploadedTitle, 'Blood Panel');
    expect(repo.uploadedType, MedicalRecordModel.typeLabResult);
    expect(repo.uploadedFilePath, '/tmp/blood-panel.pdf');
  });

  testWidgets(
      'uploading a record while a family member is the active profile passes '
      'her id as dependentId (Phase 4)', (tester) async {
    const daughter = DependentModel(
      id: 'dep-1',
      firstName: 'Anna',
      relationship: DependentModel.relationshipChild,
    );
    final repo = _FakeMedicalRecordRepository();
    await _pump(tester, repo, activeProfile: daughter);

    await tester.enterText(find.widgetWithText(TextField, 'Title'), 'Blood Panel');
    await tester.tap(find.text('Choose File'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Save'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(repo.uploadedDependentId, 'dep-1');
  });

  testWidgets(
      'uploading a record for "myself" (the default active profile) sends no '
      'dependentId (Phase 4)', (tester) async {
    final repo = _FakeMedicalRecordRepository();
    await _pump(tester, repo);

    await tester.enterText(find.widgetWithText(TextField, 'Title'), 'Blood Panel');
    await tester.tap(find.text('Choose File'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Save'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(repo.uploadedDependentId, isNull);
  });
}
