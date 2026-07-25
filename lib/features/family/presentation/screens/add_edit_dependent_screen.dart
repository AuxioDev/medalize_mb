import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/widgets/primary_button.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/features/family/data/models/dependent_model.dart';
import 'package:medalize_mb/features/family/data/repository/family_repository.dart';
import 'package:medalize_mb/features/family/presentation/screens/family_list_screen.dart';
import 'package:medalize_mb/features/family/providers/family_provider.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

const _kRelationships = [
  DependentModel.relationshipChild,
  DependentModel.relationshipSpouse,
  DependentModel.relationshipParent,
  DependentModel.relationshipSibling,
  DependentModel.relationshipOther,
];

/// Add/edit form for a family member. Deliberately mirrors the layout and
/// field set `ProfileScreen` already uses for the patient's own allergies /
/// chronic conditions / medications (`lib/features/shared/presentation/
/// screens/profile_screen.dart`) rather than inventing a new form style —
/// same section, same hint text, same multi-line text fields.
class AddEditDependentScreen extends ConsumerStatefulWidget {
  const AddEditDependentScreen({super.key, this.existing});

  /// Non-null when editing an existing family member.
  final DependentModel? existing;

  @override
  ConsumerState<AddEditDependentScreen> createState() =>
      _AddEditDependentScreenState();
}

class _AddEditDependentScreenState
    extends ConsumerState<AddEditDependentScreen> {
  late final TextEditingController _firstName;
  late final TextEditingController _lastName;
  late final TextEditingController _bloodType;
  late final TextEditingController _allergies;
  late final TextEditingController _chronicConditions;
  late final TextEditingController _medications;
  late String _relationship;
  DateTime? _dateOfBirth;

  bool _saving = false;
  String? _error;

  bool get _isEditing => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final existing = widget.existing;
    _firstName = TextEditingController(text: existing?.firstName ?? '');
    _lastName = TextEditingController(text: existing?.lastName ?? '');
    _bloodType = TextEditingController(text: existing?.bloodType ?? '');
    _allergies = TextEditingController(text: existing?.allergies ?? '');
    _chronicConditions =
        TextEditingController(text: existing?.chronicConditions ?? '');
    _medications = TextEditingController(text: existing?.medications ?? '');
    _relationship = existing?.relationship ?? DependentModel.relationshipChild;
    _dateOfBirth = existing?.dateOfBirth;
  }

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _bloodType.dispose();
    _allergies.dispose();
    _chronicConditions.dispose();
    _medications.dispose();
    super.dispose();
  }

  Future<void> _pickDateOfBirth() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dateOfBirth ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365 * 120)),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => _dateOfBirth = picked);
  }

  Future<void> _save() async {
    final firstName = _firstName.text.trim();
    if (firstName.isEmpty) {
      setState(() => _error = context.t.validation
          .fieldRequired(field: context.t.family.firstName));
      return;
    }
    setState(() {
      _saving = true;
      _error = null;
    });

    try {
      final repo = ref.read(familyRepositoryProvider);
      if (_isEditing) {
        await repo.updateDependent(
          widget.existing!.id,
          firstName: firstName,
          lastName: _lastName.text.trim(),
          relationship: _relationship,
          dateOfBirth: _dateOfBirth,
          bloodType: _bloodType.text.trim(),
          allergies: _allergies.text.trim(),
          chronicConditions: _chronicConditions.text.trim(),
          medications: _medications.text.trim(),
        );
      } else {
        await repo.createDependent(
          firstName: firstName,
          lastName: _lastName.text.trim(),
          relationship: _relationship,
          dateOfBirth: _dateOfBirth,
          bloodType: _bloodType.text.trim(),
          allergies: _allergies.text.trim(),
          chronicConditions: _chronicConditions.text.trim(),
          medications: _medications.text.trim(),
        );
      }
      ref.invalidate(dependentsProvider);
      if (mounted) context.pop();
    } on ApiException catch (e) {
      if (mounted) setState(() => _error = e.userMessage);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final dateFmt = DateFormat('d MMM y');
    return Scaffold(
      appBar: AppBar(
        title: Text(
            _isEditing ? t.family.editFamilyMember : t.family.addFamilyMember),
      ),
      body: ResponsiveBody(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _firstName,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(labelText: t.family.firstName),
              ),
              const Gap(12),
              TextField(
                controller: _lastName,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(labelText: t.family.lastName),
              ),
              const Gap(AppSpacing.md),
              Text(t.family.relationship,
                  style: Theme.of(context).textTheme.titleSmall),
              const Gap(8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final r in _kRelationships)
                    ChoiceChip(
                      label: Text(relationshipLabel(r)),
                      selected: _relationship == r,
                      onSelected: (_) => setState(() => _relationship = r),
                    ),
                ],
              ),
              const Gap(AppSpacing.md),
              InkWell(
                onTap: _pickDateOfBirth,
                borderRadius: BorderRadius.circular(AppRadius.sm),
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: t.family.dateOfBirth,
                    suffixIcon:
                        const Icon(Icons.calendar_today_outlined, size: 18),
                  ),
                  child:
                      Text(_dateOfBirth != null ? dateFmt.format(_dateOfBirth!) : '—'),
                ),
              ),
              const Gap(12),
              TextField(
                controller: _bloodType,
                decoration: InputDecoration(labelText: t.family.bloodType),
              ),
              const Gap(AppSpacing.lg),
              Text(t.profile.medicalInfo,
                  style: Theme.of(context).textTheme.titleSmall),
              const Gap(12),
              TextField(
                controller: _allergies,
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: t.family.allergies,
                  alignLabelWithHint: true,
                  hintText: t.profile.allergiesHint,
                ),
              ),
              const Gap(12),
              TextField(
                controller: _chronicConditions,
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: t.family.chronicConditions,
                  alignLabelWithHint: true,
                  hintText: t.profile.chronicConditionsHint,
                ),
              ),
              const Gap(12),
              TextField(
                controller: _medications,
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: t.family.medications,
                  alignLabelWithHint: true,
                  hintText: t.profile.medicationsHint,
                ),
              ),
              if (_error != null) ...[
                const Gap(AppSpacing.sm),
                Text(_error!, style: const TextStyle(color: AppColors.error)),
              ],
              const Gap(AppSpacing.xl),
              LoadingFilledButton(
                label: t.family.save,
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
