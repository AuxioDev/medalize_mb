import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/services/medication_scheduler.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/core/widgets/app_date_field.dart';
import 'package:medalize_mb/core/widgets/app_snack_bar.dart';
import 'package:medalize_mb/core/widgets/primary_button.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/features/medications/data/models/medication_model.dart';
import 'package:medalize_mb/features/medications/data/repository/medication_repository.dart';
import 'package:medalize_mb/features/medications/presentation/screens/medication_list_screen.dart';
import 'package:medalize_mb/features/medications/providers/medication_provider.dart';
import 'package:medalize_mb/features/shared/presentation/widgets/app_bar_title.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

/// Reminder-schedule editor for a medication the patient's doctor already
/// prescribed. The drug itself (name/dosage/form/notes) is shown read-only —
/// a Medication only ever exists because of a doctor's prescription (see
/// apps.prescriptions.PrescriptionApplyView on the backend), so there is no
/// "add medication" flow here, only "adjust when I get reminded".
class AddEditMedicationScreen extends ConsumerStatefulWidget {
  const AddEditMedicationScreen({super.key, required this.existing});

  final MedicationModel existing;

  @override
  ConsumerState<AddEditMedicationScreen> createState() =>
      _AddEditMedicationScreenState();
}

class _AddEditMedicationScreenState
    extends ConsumerState<AddEditMedicationScreen> {
  late List<String> _times;
  late Set<int> _selectedDays; // empty == every day
  late DateTime _startDate;
  DateTime? _endDate;

  bool _saving = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    final schedule = widget.existing.schedules.isNotEmpty
        ? widget.existing.schedules.first
        : null;
    _times = List.of(schedule?.times ?? const []);
    _selectedDays = Set.of(schedule?.daysOfWeek ?? const []);
    _startDate = schedule?.startDate ?? DateTime.now();
    _endDate = schedule?.endDate;
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
    setState(() {
      _saving = true;
      _error = null;
    });

    final schedules = _times.isEmpty
        ? const <MedicationScheduleModel>[]
        : [
            MedicationScheduleModel(
              id: widget.existing.schedules.isNotEmpty
                  ? widget.existing.schedules.first.id
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
      await repo.updateMedication(widget.existing.id, schedules: schedules);
      ref.invalidate(medicationsProvider);
      // Refresh device-local reminders from the server's source of truth.
      final all = await repo.getMedications();
      await ref.read(medicationSchedulerProvider).rescheduleAll(all);

      if (mounted) {
        AppSnackBar.show(context, context.t.medications.updatedSuccess,
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
    final c = context.colors;
    final existing = widget.existing;
    return Scaffold(
      appBar: AppBar(
          title: AppBarTitle(t.medications.editMedication,
              icon: Icons.medication_outlined)),
      body: ResponsiveBody(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Read-only — set by the doctor's prescription, not editable
              // by the patient.
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: c.surfaceAlt,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(color: c.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(medicationFormIcon(existing.form), size: 18, color: c.textSecondary),
                        const Gap(6),
                        Expanded(
                          child: Text(existing.name,
                              style: Theme.of(context).textTheme.titleMedium),
                        ),
                      ],
                    ),
                    if (existing.dosage.isNotEmpty) ...[
                      const Gap(4),
                      Text('${t.medications.dosage}: ${existing.dosage}',
                          style: Theme.of(context).textTheme.bodyMedium),
                    ],
                    if (existing.notes.isNotEmpty) ...[
                      const Gap(4),
                      Text(existing.notes, style: Theme.of(context).textTheme.bodySmall),
                    ],
                    if (existing.isFromPrescription) ...[
                      const Gap(8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: c.primarySurface,
                          borderRadius: BorderRadius.circular(AppRadius.pill),
                        ),
                        child: Text(
                          t.medications.fromPrescription,
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w600, color: c.primaryText),
                        ),
                      ),
                    ],
                  ],
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
                    child: AppDateField(
                      label: t.medications.startDate,
                      value: _startDate,
                      onTap: _pickStartDate,
                    ),
                  ),
                  const Gap(12),
                  Expanded(
                    child: AppDateField(
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
