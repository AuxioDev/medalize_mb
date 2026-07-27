import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:dio/dio.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/network/dio_client.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/widgets/primary_button.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/features/doctor/presentation/widgets/working_hours_fields.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

class AddEditWorkplaceScreen extends ConsumerStatefulWidget {
  const AddEditWorkplaceScreen({super.key, this.existing});
  final Map<String, dynamic>? existing;

  @override
  ConsumerState<AddEditWorkplaceScreen> createState() =>
      _AddEditWorkplaceScreenState();
}

class _AddEditWorkplaceScreenState
    extends ConsumerState<AddEditWorkplaceScreen> {
  final _form = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _address;
  late final TextEditingController _city;
  String _type = 'clinic';
  late List<WorkingHoursDay> _days;
  bool _loading = false;
  String? _error;

  /// Set once a create-flow POST succeeds, so a retry after a failed hours
  /// save PATCHes that workplace instead of creating a duplicate.
  String? _createdWorkplaceId;

  bool get _isEdit => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    _name = TextEditingController(text: e?['name'] as String? ?? '');
    _address = TextEditingController(text: e?['address'] as String? ?? '');
    _city = TextEditingController(text: e?['city'] as String? ?? '');
    _type = e?['type'] as String? ?? 'clinic';
    _days = e != null
        ? WorkingHoursDay.fromApiList(e['working_hours'] as List<dynamic>?)
        : WorkingHoursDay.defaultWeek(weekdaysActive: true);
  }

  @override
  void dispose() {
    _name.dispose();
    _address.dispose();
    _city.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!(_form.currentState?.validate() ?? false)) return;
    if (WorkingHoursDay.hasInvalidRange(_days)) {
      setState(() => _error = context.t.workingHours.invalidRange);
      return;
    }
    setState(() {
      _loading = true;
      _error = null;
    });
    final dio = ref.read(dioClientProvider);
    final body = {
      'name': _name.text.trim(),
      'address': _address.text.trim(),
      'city': _city.text.trim(),
      'type': _type,
      'working_hours': WorkingHoursDay.toPayload(_days),
    };
    try {
      // A previously-created workplace (create flow retried after the first
      // attempt failed downstream) is PATCHed, never re-POSTed.
      final existingId = widget.existing?['id'] as String? ?? _createdWorkplaceId;
      if (existingId != null) {
        await dio.patch('/doctor/workplaces/$existingId/', data: body);
      } else {
        final res = await dio.post('/doctor/workplaces/', data: body);
        _createdWorkplaceId = res.data['id'] as String;
      }
      if (mounted) context.pop(true);
    } on DioException catch (e) {
      // Surface the specific backend message (e.g. an invalid field) instead of
      // a generic "failed to save".
      setState(() => _error = mapDioError(e).userMessage);
    } catch (_) {
      setState(() => _error = context.t.addWorkplace.failedToSave);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(_isEdit
              ? context.t.addWorkplace.editTitle
              : context.t.addWorkplace.addTitle)),
      body: Form(
        key: _form,
        child: ResponsiveBody(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              children: [
                TextFormField(
                  controller: _name,
                  decoration:
                      InputDecoration(labelText: context.t.addWorkplace.name),
                  validator: (v) => v?.trim().isEmpty == true
                      ? context.t.common.required
                      : null,
                ),
                const Gap(12),
                TextFormField(
                  controller: _address,
                  decoration: InputDecoration(
                      labelText: context.t.addWorkplace.address),
                  validator: (v) => v?.trim().isEmpty == true
                      ? context.t.common.required
                      : null,
                ),
                const Gap(12),
                TextFormField(
                  controller: _city,
                  decoration:
                      InputDecoration(labelText: context.t.addWorkplace.city),
                  validator: (v) => v?.trim().isEmpty == true
                      ? context.t.common.required
                      : null,
                ),
                const Gap(12),
                DropdownButtonFormField<String>(
                  initialValue: _type,
                  decoration:
                      InputDecoration(labelText: context.t.addWorkplace.type),
                  items: [
                    DropdownMenuItem(
                        value: 'clinic',
                        child: Text(context.t.addWorkplace.clinic)),
                    DropdownMenuItem(
                        value: 'hospital',
                        child: Text(context.t.addWorkplace.hospital)),
                    DropdownMenuItem(
                        value: 'private',
                        child: Text(context.t.addWorkplace.privatePractice)),
                  ],
                  onChanged: (v) => setState(() => _type = v!),
                ),
                const Gap(24),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    context.t.workplaces.workingHours,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                const Gap(4),
                Text(
                  context.t.workingHours.sectionHint,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const Gap(12),
                WorkingHoursFields(
                  days: _days,
                  onChanged: (days) => setState(() => _days = days),
                  // This form already scrolls as a whole; a per-row entrance
                  // stagger (meant for the standalone hours list screen) just
                  // adds jitter here.
                  animateEntrance: false,
                ),
                if (_error != null) ...[
                  const Gap(12),
                  Text(_error!,
                      style: const TextStyle(color: AppColors.error)),
                ],
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomActionBar(
        child: LoadingFilledButton(
          label: _isEdit
              ? context.t.addWorkplace.saveChanges
              : context.t.addWorkplace.addButton,
          loading: _loading,
          onPressed: _save,
        ),
      ),
    );
  }
}
