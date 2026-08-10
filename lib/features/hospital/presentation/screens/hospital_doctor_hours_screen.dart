import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/widgets/app_snack_bar.dart';
import 'package:medalize_mb/core/widgets/empty_state.dart';
import 'package:medalize_mb/core/widgets/primary_button.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/features/doctor/presentation/widgets/working_hours_fields.dart';
import 'package:medalize_mb/features/hospital/data/models/hospital_link_model.dart';
import 'package:medalize_mb/features/hospital/data/repository/hospital_repository.dart';
import 'package:medalize_mb/features/shared/presentation/widgets/app_bar_title.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

/// Lets the hospital edit working hours for one of a confirmed doctor's
/// workplaces at this hospital. If the doctor has more than one workplace
/// here (e.g. two departments), the hospital first picks which one.
class HospitalDoctorHoursScreen extends ConsumerStatefulWidget {
  const HospitalDoctorHoursScreen({super.key, required this.doctor});

  final DoctorBriefModel doctor;

  @override
  ConsumerState<HospitalDoctorHoursScreen> createState() => _HospitalDoctorHoursScreenState();
}

class _HospitalDoctorHoursScreenState extends ConsumerState<HospitalDoctorHoursScreen> {
  List<Map<String, dynamic>>? _workplaces;
  String? _selectedWorkplaceId;
  List<WorkingHoursDay>? _days;
  bool _loading = true;
  bool _saving = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadWorkplaces();
  }

  Future<void> _loadWorkplaces() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final workplaces = await ref
          .read(hospitalRepositoryProvider)
          .getDoctorWorkplaces(widget.doctor.id);
      if (!mounted) return;
      setState(() {
        _workplaces = workplaces;
        _loading = false;
      });
      if (workplaces.length == 1) {
        _selectWorkplace(workplaces.first['id'] as String);
      }
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = context.t.common.somethingWrong;
      });
    }
  }

  Future<void> _selectWorkplace(String workplaceId) async {
    setState(() {
      _selectedWorkplaceId = workplaceId;
      _loading = true;
    });
    try {
      final days = await ref.read(hospitalRepositoryProvider).getWorkplaceHours(workplaceId);
      if (!mounted) return;
      setState(() {
        _days = days;
        _loading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = context.t.common.somethingWrong;
      });
    }
  }

  Future<void> _save() async {
    final workplaceId = _selectedWorkplaceId;
    final days = _days;
    if (workplaceId == null || days == null) return;
    if (WorkingHoursDay.hasInvalidRange(days)) {
      setState(() => _error = context.t.workingHours.invalidRange);
      return;
    }
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      await ref.read(hospitalRepositoryProvider).putWorkplaceHours(workplaceId, days);
      if (!mounted) return;
      AppSnackBar.show(context, context.t.hospitalDoctorHours.saved, type: SnackBarType.success);
    } catch (_) {
      if (!mounted) return;
      setState(() => _error = context.t.common.somethingWrong);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle(
            '${context.t.hospitalDoctorHours.title} — ${widget.doctor.fullName}',
            icon: Icons.schedule_outlined),
      ),
      body: ResponsiveBody(child: _body(context)),
      bottomNavigationBar: _days == null
          ? null
          : BottomActionBar(
              child: LoadingFilledButton(
                label: context.t.common.save,
                loading: _saving,
                onPressed: _save,
              ),
            ),
    );
  }

  Widget _body(BuildContext context) {
    if (_loading && _workplaces == null) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null && _days == null) {
      return Center(
        child: EmptyState(
          icon: Icons.cloud_off_outlined,
          title: _error!,
          subtitle: '',
          actionLabel: context.t.common.retry,
          onAction: _loadWorkplaces,
        ),
      );
    }
    final workplaces = _workplaces ?? const [];
    if (workplaces.isEmpty) {
      return Center(
        child: EmptyState(
          icon: Icons.business_outlined,
          title: context.t.common.somethingWrong,
          subtitle: '',
        ),
      );
    }
    if (workplaces.length > 1 && _selectedWorkplaceId == null) {
      return ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Text(
            context.t.hospitalDoctorHours.selectWorkplace,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const Gap(8),
          for (final wp in workplaces)
            Card(
              child: ListTile(
                title: Text(wp['name'] as String? ?? ''),
                subtitle: Text(wp['address'] as String? ?? ''),
                onTap: () => _selectWorkplace(wp['id'] as String),
              ),
            ),
        ],
      );
    }
    if (_loading || _days == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.t.workingHours.sectionHint,
              style: Theme.of(context).textTheme.bodySmall),
          const Gap(12),
          WorkingHoursFields(
            days: _days!,
            onChanged: (days) => setState(() => _days = days),
          ),
          if (_error != null) ...[
            const Gap(12),
            Text(_error!, style: const TextStyle(color: AppColors.error)),
          ],
        ],
      ),
    );
  }
}
