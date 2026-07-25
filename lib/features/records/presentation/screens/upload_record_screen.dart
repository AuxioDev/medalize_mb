import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/widgets/app_date_field.dart';
import 'package:medalize_mb/core/widgets/app_snack_bar.dart';
import 'package:medalize_mb/core/widgets/primary_button.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/features/family/providers/family_provider.dart';
import 'package:medalize_mb/features/records/data/models/medical_record_model.dart';
import 'package:medalize_mb/features/records/data/repository/medical_record_repository.dart';
import 'package:medalize_mb/features/records/presentation/screens/records_list_screen.dart';
import 'package:medalize_mb/features/records/providers/medical_record_provider.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

const _kRecordTypes = [
  MedicalRecordModel.typeLabResult,
  MedicalRecordModel.typeImaging,
  MedicalRecordModel.typeDocument,
  MedicalRecordModel.typeOther,
];

class UploadRecordScreen extends ConsumerStatefulWidget {
  const UploadRecordScreen({super.key});

  @override
  ConsumerState<UploadRecordScreen> createState() => _UploadRecordScreenState();
}

class _UploadRecordScreenState extends ConsumerState<UploadRecordScreen> {
  final _title = TextEditingController();
  final _notes = TextEditingController();
  String _recordType = MedicalRecordModel.typeLabResult;
  DateTime? _recordDate;
  String? _filePath;
  String? _fileName;

  bool _saving = false;
  String? _error;

  @override
  void dispose() {
    _title.dispose();
    _notes.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['pdf', 'jpg', 'jpeg', 'png'],
    );
    final file = result?.files.singleOrNull;
    if (file?.path == null) return;
    setState(() {
      _filePath = file!.path;
      _fileName = file.name;
    });
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _recordDate ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365 * 20)),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => _recordDate = picked);
  }

  Future<void> _save() async {
    final title = _title.text.trim();
    if (title.isEmpty) {
      setState(() => _error = context.t.records.titleRequired);
      return;
    }
    if (_filePath == null) {
      setState(() => _error = context.t.records.fileRequired);
      return;
    }

    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      await ref.read(medicalRecordRepositoryProvider).uploadRecord(
            recordType: _recordType,
            title: title,
            recordDate: _recordDate,
            notes: _notes.text.trim(),
            filePath: _filePath!,
            dependentId: ref.read(activeProfileProvider)?.id,
          );
      ref.invalidate(medicalRecordsProvider);
      if (mounted) {
        AppSnackBar.show(context, context.t.records.uploadSuccess,
            type: SnackBarType.success);
        context.pop();
      }
    } on ApiException catch (e) {
      if (mounted) setState(() => _error = e.userMessage);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return Scaffold(
      appBar: AppBar(title: Text(t.records.upload)),
      body: ResponsiveBody(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(t.records.recordType, style: Theme.of(context).textTheme.titleSmall),
              const Gap(8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final type in _kRecordTypes)
                    ChoiceChip(
                      label: Text(recordTypeLabel(type)),
                      selected: _recordType == type,
                      onSelected: (_) => setState(() => _recordType = type),
                    ),
                ],
              ),
              const Gap(AppSpacing.md),
              TextField(
                controller: _title,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(labelText: t.records.recordTitle),
              ),
              const Gap(12),
              AppDateField(
                label: t.records.recordDate,
                value: _recordDate,
                onTap: _pickDate,
              ),
              const Gap(12),
              TextField(
                controller: _notes,
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: t.records.notes,
                  alignLabelWithHint: true,
                ),
              ),
              const Gap(AppSpacing.md),
              OutlinedButton.icon(
                onPressed: _pickFile,
                icon: const Icon(Icons.attach_file, size: 18),
                label: Text(_fileName == null ? t.records.chooseFile : t.records.changeFile),
              ),
              const Gap(6),
              Text(
                _fileName ?? t.records.noFileChosen,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              if (_error != null) ...[
                const Gap(AppSpacing.sm),
                Text(_error!, style: const TextStyle(color: AppColors.error)),
              ],
              const Gap(AppSpacing.xl),
              LoadingFilledButton(
                label: t.records.save,
                loading: _saving,
                onPressed: _saving ? null : _save,
              ),
              const Gap(AppSpacing.md),
            ],
          ),
        ),
      ),
    );
  }
}
