import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/services/medication_scheduler.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/widgets/app_snack_bar.dart';
import 'package:medalize_mb/core/widgets/primary_button.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/features/family/providers/family_provider.dart';
import 'package:medalize_mb/features/medications/data/models/medication_model.dart';
import 'package:medalize_mb/features/medications/data/repository/medication_repository.dart';
import 'package:medalize_mb/features/medications/presentation/screens/medication_list_screen.dart';
import 'package:medalize_mb/features/medications/providers/medication_provider.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

const _kForms = ['pill', 'capsule', 'liquid', 'injection', 'other'];

class AddEditMedicationScreen extends ConsumerStatefulWidget {
  const AddEditMedicationScreen({super.key, this.existing});

  /// Non-null when editing an existing medication.
  final MedicationModel? existing;

  @override
  ConsumerState<AddEditMedicationScreen> createState() =>
      _AddEditMedicationScreenState();
}

class _AddEditMedicationScreenState
    extends ConsumerState<AddEditMedicationScreen> {
  late final TextEditingController _name;
  late final TextEditingController _dosage;
  late final TextEditingController _notes;
  late String _form;

  late List<String> _times;
  late Set<int> _selectedDays; // empty == every day
  late DateTime _startDate;
  DateTime? _endDate;

  bool _saving = false;
  String? _error;

  bool get _isEditing => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final existing = widget.existing;
    _name = TextEditingController(text: existing?.name ?? '');
    _dosage = TextEditingController(text: existing?.dosage ?? '');
    _notes = TextEditingController(text: existing?.notes ?? '');
    _form = existing?.form.isNotEmpty == true ? existing!.form : 'pill';

    final schedule = existing?.schedules.isNotEmpty == true
        ? existing!.schedules.first
        : null;
    _times = List.of(schedule?.times ?? const []);
    _selectedDays = Set.of(schedule?.daysOfWeek ?? const []);
    _startDate = schedule?.startDate ?? DateTime.now();
    _endDate = schedule?.endDate;
  }

  @override
  void dispose() {
    _name.dispose();
    _dosage.dispose();
    _notes.dispose();
    super.dispose();
  }

  Future<void> _addTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked == null) return;
    final formatted =
        '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
    if (!_times.contains(formatted)) {
      setState(() {
        _times = [..._times, formatted]..sort();
      });
    }
  }

  Future<void> _pickStartDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
    );
    if (picked != null) setState(() => _startDate = picked);
  }

  Future<void> _pickEndDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _endDate ?? _startDate,
      firstDate: _startDate,
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
    );
    if (picked != null) setState(() => _endDate = picked);
  }

  Future<void> _save() async {
    final name = _name.text.trim();
    if (name.isEmpty) {
      setState(() => _error =
          context.t.validation.fieldRequired(field: context.t.medications.name));
      return;
    }
    setState(() {
      _saving = true;
      _error = null;
    });

    final schedules = _times.isEmpty
        ? const <MedicationScheduleModel>[]
        : [
            MedicationScheduleModel(
              id: widget.existing?.schedules.isNotEmpty == true
                  ? widget.existing!.schedules.first.id
                  : '',
              times: _times,
              daysOfWeek: _selectedDays.toList()..sort(),
              startDate: _startDate,
              endDate: _endDate,
              isActive: true,
            ),
          ];

    try {
      final repo = ref.read(medicationRepositoryProvider);
      if (_isEditing) {
        await repo.updateMedication(
          widget.existing!.id,
          name: name,
          dosage: _dosage.text.trim(),
          form: _form,
          notes: _notes.text.trim(),
          schedules: schedules,
        );
      } else {
        await repo.createMedication(
          name: name,
          dosage: _dosage.text.trim(),
          form: _form,
          notes: _notes.text.trim(),
          schedules: schedules,
          dependentId: ref.read(activeProfileProvider)?.id,
        );
      }
      ref.invalidate(medicationsProvider);
      // Refresh device-local reminders from the server's source of truth.
      final all = await repo.getMedications();
      await ref.read(medicationSchedulerProvider).rescheduleAll(all);

      if (mounted) {
        AppSnackBar.show(
          context,
          _isEditing
              ? context.t.medications.updatedSuccess
              : context.t.medications.addedSuccess,
          type: SnackBarType.success,
        );
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
      appBar: AppBar(
        title: Text(_isEditing ? t.medications.editMedication : t.medications.addMedication),
      ),
      body: ResponsiveBody(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _name,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(labelText: t.medications.name),
              ),
              const Gap(12),
              TextField(
                controller: _dosage,
                decoration: InputDecoration(labelText: t.medications.dosage),
              ),
              const Gap(AppSpacing.md),
              Text(t.medications.form, style: Theme.of(context).textTheme.titleSmall),
              const Gap(8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final f in _kForms)
                    ChoiceChip(
                      label: Text(medicationFormLabel(f)),
                      selected: _form == f,
                      onSelected: (_) => setState(() => _form = f),
                    ),
                ],
              ),
              const Gap(AppSpacing.md),
              TextField(
                controller: _notes,
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: t.medications.notes,
                  alignLabelWithHint: true,
                ),
              ),
              const Gap(AppSpacing.lg),
              Text(t.medications.schedule, style: Theme.of(context).textTheme.titleMedium),
              const Gap(10),
              Text(t.medications.times, style: Theme.of(context).textTheme.labelLarge),
              const Gap(8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final time in _times)
                    InputChip(
                      label: Text(time),
                      onDeleted: () => setState(() => _times.remove(time)),
                    ),
                  ActionChip(
                    avatar: const Icon(Icons.add, size: 16),
                    label: Text(t.medications.addTime),
                    onPressed: _addTime,
                  ),
                ],
              ),
              const Gap(AppSpacing.md),
              Text(t.medications.daysOfWeek, style: Theme.of(context).textTheme.labelLarge),
              const Gap(8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  FilterChip(
                    label: Text(t.medications.everyDay),
                    selected: _selectedDays.isEmpty,
                    onSelected: (_) => setState(() => _selectedDays.clear()),
                  ),
                  for (int day = 0; day < 7; day++)
                    FilterChip(
                      label: Text(_dayLabel(context, day)),
                      selected: _selectedDays.contains(day),
                      onSelected: (selected) => setState(() {
                        if (selected) {
                          _selectedDays.add(day);
                        } else {
                          _selectedDays.remove(day);
                        }
                      }),
                    ),
                ],
              ),
              const Gap(AppSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: _DateField(
                      label: t.medications.startDate,
                      value: _startDate,
                      onTap: _pickStartDate,
                    ),
                  ),
                  const Gap(12),
                  Expanded(
                    child: _DateField(
                      label: t.medications.endDate,
                      value: _endDate,
                      onTap: _pickEndDate,
                      onClear: _endDate != null ? () => setState(() => _endDate = null) : null,
                    ),
                  ),
                ],
              ),
              if (_error != null) ...[
                const Gap(AppSpacing.sm),
                Text(_error!, style: const TextStyle(color: AppColors.error)),
              ],
              const Gap(AppSpacing.xl),
              LoadingFilledButton(
                label: t.medications.save,
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

  String _dayLabel(BuildContext context, int day) => switch (day) {
        0 => context.t.medications.dayMon,
        1 => context.t.medications.dayTue,
        2 => context.t.medications.dayWed,
        3 => context.t.medications.dayThu,
        4 => context.t.medications.dayFri,
        5 => context.t.medications.daySat,
        _ => context.t.medications.daySun,
      };
}

class _DateField extends StatelessWidget {
  const _DateField({
    required this.label,
    required this.value,
    required this.onTap,
    this.onClear,
  });

  final String label;
  final DateTime? value;
  final VoidCallback onTap;
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    final fmt = DateFormat('d MMM y');
    return InkWell(
      onTap: () {
        HapticFeedback.selectionClick();
        onTap();
      },
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: onClear != null
              ? IconButton(icon: const Icon(Icons.clear, size: 18), onPressed: onClear)
              : const Icon(Icons.calendar_today_outlined, size: 18),
        ),
        child: Text(value != null ? fmt.format(value!) : '—'),
      ),
    );
  }
}
