import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/core/widgets/app_snack_bar.dart';
import 'package:medalize_mb/core/widgets/primary_button.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/features/prescriptions/data/models/prescription_model.dart';
import 'package:medalize_mb/features/prescriptions/data/repository/prescription_repository.dart';
import 'package:medalize_mb/features/prescriptions/providers/prescription_provider.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

class WritePrescriptionScreen extends ConsumerStatefulWidget {
  const WritePrescriptionScreen({
    super.key,
    required this.appointmentId,
    required this.patientName,
  });

  final String appointmentId;
  final String patientName;

  @override
  ConsumerState<WritePrescriptionScreen> createState() =>
      _WritePrescriptionScreenState();
}

class _WritePrescriptionScreenState extends ConsumerState<WritePrescriptionScreen> {
  final _notes = TextEditingController();
  final List<_DrugRowControllers> _rows = [_DrugRowControllers()];
  bool _saving = false;
  String? _error;

  @override
  void dispose() {
    _notes.dispose();
    for (final row in _rows) {
      row.dispose();
    }
    super.dispose();
  }

  void _addRow() => setState(() => _rows.add(_DrugRowControllers()));

  void _removeRow(int index) {
    setState(() {
      _rows[index].dispose();
      _rows.removeAt(index);
    });
  }

  Future<void> _save() async {
    final items = <PrescriptionItemModel>[];
    for (final row in _rows) {
      final name = row.name.text.trim();
      if (name.isEmpty) continue;
      items.add(PrescriptionItemModel(
        drugName: name,
        dosage: row.dosage.text.trim(),
        frequency: row.frequency.text.trim(),
        duration: row.duration.text.trim(),
        instructions: row.instructions.text.trim(),
      ));
    }
    if (items.isEmpty) {
      setState(() => _error = context.t.prescriptions.atLeastOneDrug);
      return;
    }

    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      await ref.read(prescriptionRepositoryProvider).createPrescription(
            widget.appointmentId,
            notes: _notes.text.trim(),
            items: items,
          );
      ref.invalidate(appointmentPrescriptionProvider(widget.appointmentId));
      if (mounted) {
        AppSnackBar.show(context, context.t.prescriptions.prescriptionIssued,
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
      appBar: AppBar(title: Text(t.prescriptions.writeTitle)),
      body: ResponsiveBody(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.patientName.isNotEmpty) ...[
                Text(widget.patientName, style: Theme.of(context).textTheme.titleMedium),
                const Gap(AppSpacing.md),
              ],
              for (int i = 0; i < _rows.length; i++)
                _DrugRow(
                  index: i,
                  controllers: _rows[i],
                  onRemove: _rows.length > 1 ? () => _removeRow(i) : null,
                ),
              OutlinedButton.icon(
                onPressed: _addRow,
                icon: const Icon(Icons.add, size: 18),
                label: Text(t.prescriptions.addDrug),
              ),
              const Gap(AppSpacing.lg),
              TextField(
                controller: _notes,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: t.prescriptions.notes,
                  alignLabelWithHint: true,
                ),
              ),
              if (_error != null) ...[
                const Gap(AppSpacing.sm),
                Text(_error!, style: const TextStyle(color: AppColors.error)),
              ],
              const Gap(AppSpacing.xl),
              LoadingFilledButton(
                label: t.prescriptions.save,
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

class _DrugRowControllers {
  final name = TextEditingController();
  final dosage = TextEditingController();
  final frequency = TextEditingController();
  final duration = TextEditingController();
  final instructions = TextEditingController();

  void dispose() {
    name.dispose();
    dosage.dispose();
    frequency.dispose();
    duration.dispose();
    instructions.dispose();
  }
}

class _DrugRow extends StatelessWidget {
  const _DrugRow({
    required this.index,
    required this.controllers,
    this.onRemove,
  });

  final int index;
  final _DrugRowControllers controllers;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final t = context.t;
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
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
              Expanded(
                child: Text('#${index + 1}', style: Theme.of(context).textTheme.labelLarge),
              ),
              if (onRemove != null)
                IconButton(
                  icon: const Icon(Icons.close, size: 18),
                  tooltip: t.prescriptions.removeDrug,
                  onPressed: onRemove,
                ),
            ],
          ),
          TextField(
            controller: controllers.name,
            decoration: InputDecoration(labelText: t.prescriptions.drugName),
          ),
          const Gap(8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controllers.dosage,
                  decoration: InputDecoration(labelText: t.prescriptions.dosage),
                ),
              ),
              const Gap(8),
              Expanded(
                child: TextField(
                  controller: controllers.frequency,
                  decoration: InputDecoration(labelText: t.prescriptions.frequency),
                ),
              ),
            ],
          ),
          const Gap(8),
          TextField(
            controller: controllers.duration,
            decoration: InputDecoration(labelText: t.prescriptions.duration),
          ),
          const Gap(8),
          TextField(
            controller: controllers.instructions,
            maxLines: 2,
            decoration: InputDecoration(
              labelText: t.prescriptions.instructions,
              alignLabelWithHint: true,
            ),
          ),
        ],
      ),
    );
  }
}
