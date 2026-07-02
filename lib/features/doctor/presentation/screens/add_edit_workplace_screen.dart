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
  bool _loading = false;
  String? _error;

  bool get _isEdit => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    _name = TextEditingController(text: e?['name'] as String? ?? '');
    _address = TextEditingController(text: e?['address'] as String? ?? '');
    _city = TextEditingController(text: e?['city'] as String? ?? '');
    _type = e?['type'] as String? ?? 'clinic';
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
    };
    try {
      if (_isEdit) {
        await dio.patch('/doctor/workplaces/${widget.existing!['id']}/',
            data: body);
      } else {
        await dio.post('/doctor/workplaces/', data: body);
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
