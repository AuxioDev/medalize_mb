import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:dio/dio.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/network/dio_client.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/widgets/hospital_picker_field.dart';
import 'package:medalize_mb/core/widgets/location_picker_field.dart';
import 'package:medalize_mb/core/widgets/primary_button.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/features/doctor/presentation/screens/workplace_map_picker_screen.dart';
import 'package:medalize_mb/features/doctor/presentation/widgets/working_hours_fields.dart';
import 'package:medalize_mb/features/locations/data/repository/location_repository.dart';
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
  String? _cityKey;
  String? _cityFallbackLabel;
  String? _hospitalId;
  String? _hospitalLabel;
  String? _hospitalLinkStatus;
  double? _lat;
  double? _lng;
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
    _cityKey = e?['city'] as String?;
    _cityFallbackLabel = e?['city_display'] as String?;
    _hospitalId = e?['hospital'] as String?;
    _hospitalLabel = e?['hospital_name'] as String?;
    _hospitalLinkStatus = e?['hospital_link_status'] as String?;
    _lat = double.tryParse('${e?['latitude'] ?? ''}');
    _lng = double.tryParse('${e?['longitude'] ?? ''}');
    _type = e?['type'] as String? ?? 'clinic';
    _days = e != null
        ? WorkingHoursDay.fromApiList(e['working_hours'] as List<dynamic>?)
        : WorkingHoursDay.defaultWeek(weekdaysActive: true);
  }

  @override
  void dispose() {
    _name.dispose();
    _address.dispose();
    super.dispose();
  }

  /// The map should already show wherever this workplace's address
  /// currently points to: the doctor's own pin if there is one, else the
  /// centroid of the city already picked in the form, else nothing (the
  /// map screen itself falls back to Baku).
  ({double? lat, double? lng}) _mapStartingPoint() {
    if (_lat != null && _lng != null) return (lat: _lat, lng: _lng);
    final cityKey = _cityKey;
    if (cityKey == null) return (lat: null, lng: null);
    for (final region in ref.read(locationsProvider).valueOrNull ?? const []) {
      for (final city in region.cities) {
        if (city.key == cityKey) return (lat: city.lat, lng: city.lng);
      }
    }
    return (lat: null, lng: null);
  }

  Future<void> _pickOnMap() async {
    final start = _mapStartingPoint();
    final result = await context.push<PickedLocation?>(
      '/doctor/pick-workplace-location',
      extra: {'lat': start.lat, 'lng': start.lng},
    );
    if (result == null || !mounted) return;
    setState(() {
      _lat = result.lat;
      _lng = result.lng;
      if (result.address != null && result.address!.trim().isNotEmpty) {
        _address.text = result.address!;
      }
    });
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
      'city': _cityKey,
      'hospital': _hospitalId,
      'type': _type,
      'working_hours': WorkingHoursDay.toPayload(_days),
      if (_lat != null && _lng != null) 'latitude': _lat,
      if (_lat != null && _lng != null) 'longitude': _lng,
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
                // City first: both the hospital picker (undedupable without
                // a city — see apps.hospitals.matching) and the map's
                // starting point depend on it.
                LocationPickerField(
                  value: _cityKey,
                  fallbackLabel: _cityFallbackLabel,
                  onChanged: (key) => setState(() {
                    _cityKey = key;
                    // A hospital picked under the old city may not even
                    // exist as an option under the new one — clear it
                    // rather than silently keep a stale cross-city pick.
                    _hospitalId = null;
                    _hospitalLabel = null;
                  }),
                  decoration:
                      InputDecoration(labelText: context.t.addWorkplace.city),
                  validator: (v) =>
                      v == null || v.isEmpty ? context.t.common.required : null,
                ),
                const Gap(12),
                HospitalPickerField(
                  selectedId: _hospitalId,
                  selectedLabel: _hospitalLabel,
                  city: _cityKey,
                  onSelected: (hospital) => setState(() {
                    _hospitalId = hospital?.id;
                    _hospitalLabel = hospital?.name;
                    // A freshly-picked hospital defaults the name field too
                    // (mirrors the backend's own fallback in
                    // WorkplaceSerializer._apply_hospital_name) — only when
                    // the doctor hasn't already typed something themselves.
                    if (hospital != null && _name.text.trim().isEmpty) {
                      _name.text = hospital.name;
                    }
                  }),
                  decoration: InputDecoration(
                    labelText: context.t.hospitalPicker.title,
                  ),
                ),
                if (_hospitalLinkStatus == 'pending')
                  Padding(
                    padding: const EdgeInsets.only(top: 4, left: 4),
                    child: Text(
                      context.t.hospitalPicker.pendingReview,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: AppColors.warning),
                    ),
                  ),
                const Gap(12),
                TextFormField(
                  controller: _name,
                  decoration:
                      InputDecoration(labelText: context.t.addWorkplace.name),
                  validator: (v) => v?.trim().isEmpty == true && _hospitalId == null
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
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    onPressed: _pickOnMap,
                    icon: const Icon(Icons.map_outlined, size: 18),
                    label: Text(context.t.addWorkplace.pickOnMap),
                  ),
                ),
                if (_lat != null && _lng != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 4, bottom: 4),
                    child: Text(
                      context.t.addWorkplace.locationSet,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: AppColors.success),
                    ),
                  ),
                const Gap(4),
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
