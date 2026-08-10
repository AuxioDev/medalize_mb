import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/constants/user_roles.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/core/widgets/app_snack_bar.dart';
import 'package:medalize_mb/core/widgets/location_picker_field.dart';
import 'package:medalize_mb/core/widgets/primary_button.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/features/auth/providers/auth_provider.dart';
import 'package:medalize_mb/features/auth/providers/auth_state.dart';
import 'package:medalize_mb/features/hospital/data/models/hospital_model.dart';
import 'package:medalize_mb/features/hospital/data/repository/hospital_repository.dart';
import 'package:medalize_mb/features/shared/presentation/widgets/app_bar_title.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

/// Second step of hospital registration, reached from RegisterScreen with
/// the base account fields (email/password/name/consent) passed via
/// `extra`. Collects the one thing a hospital registrant needs that a
/// doctor/patient doesn't: which hospital they are — either found in the
/// registry (claimed) or typed fresh (created), see
/// apps.hospitals.services.claim_or_create_hospital. Both the search
/// (GET /api/hospitals/) and the eventual POST /api/auth/register/ work
/// unauthenticated — this screen runs entirely before any token exists.
class HospitalRegistrationScreen extends ConsumerStatefulWidget {
  const HospitalRegistrationScreen({super.key, required this.accountFields});

  final Map<String, dynamic> accountFields;

  @override
  ConsumerState<HospitalRegistrationScreen> createState() =>
      _HospitalRegistrationScreenState();
}

class _HospitalRegistrationScreenState
    extends ConsumerState<HospitalRegistrationScreen> {
  String? _cityKey;
  final _search = TextEditingController();
  Timer? _debounce;
  int _requestGeneration = 0;
  List<HospitalModel> _results = const [];
  bool _searching = false;

  HospitalModel? _selectedHospital;
  bool _addingNew = false;
  final _newNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _search.addListener(_onQueryChanged);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _search.dispose();
    _newNameController.dispose();
    super.dispose();
  }

  void _onCityChanged(String? key) {
    setState(() {
      _cityKey = key;
      _selectedHospital = null;
      _addingNew = false;
      _search.clear();
      _results = const [];
    });
    if (key != null) _runSearch('');
  }

  void _onQueryChanged() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      _runSearch(_search.text.trim());
    });
  }

  Future<void> _runSearch(String query) async {
    final cityKey = _cityKey;
    if (cityKey == null) return;
    final generation = ++_requestGeneration;
    setState(() => _searching = true);
    try {
      final results = await ref
          .read(hospitalRepositoryProvider)
          .search(q: query, city: cityKey);
      if (!mounted || generation != _requestGeneration) return;
      setState(() {
        _results = results;
        _searching = false;
      });
    } catch (_) {
      if (!mounted || generation != _requestGeneration) return;
      setState(() => _searching = false);
    }
  }

  bool get _canSubmit {
    if (_cityKey == null) return false;
    if (_addingNew) return _newNameController.text.trim().isNotEmpty;
    return _selectedHospital != null;
  }

  Future<void> _submit() async {
    if (!_canSubmit) return;
    final fields = widget.accountFields;
    await ref.read(authProvider.notifier).register(
          email: fields['email'] as String,
          password: fields['password'] as String,
          passwordConfirm: fields['passwordConfirm'] as String,
          role: UserRole.hospital,
          firstName: fields['firstName'] as String,
          lastName: fields['lastName'] as String,
          privacyConsent: fields['privacyConsent'] as bool,
          phone: fields['phone'] as String? ?? '',
          hospitalId: _addingNew ? null : _selectedHospital?.id,
          hospitalName: _addingNew ? _newNameController.text.trim() : '',
          hospitalCity: _cityKey!,
        );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authProvider, (_, next) {
      if (next is AuthError) {
        AppSnackBar.show(context, next.exception.userMessage, type: SnackBarType.error);
      }
    });
    final authState = ref.watch(authProvider);
    final isLoading = authState is AuthLoading;

    return Scaffold(
      appBar: AppBar(
          title: AppBarTitle(context.t.hospitalRegistration.title,
              icon: Icons.apartment_outlined)),
      body: ResponsiveBody(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                context.t.hospitalRegistration.subtitle,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const Gap(AppSpacing.lg),
              Text(
                context.t.hospitalRegistration.cityStep,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const Gap(8),
              LocationPickerField(
                value: _cityKey,
                onChanged: _onCityChanged,
                decoration: InputDecoration(labelText: context.t.addWorkplace.city),
              ),
              const Gap(AppSpacing.lg),
              if (_cityKey != null) ...[
                Text(
                  context.t.hospitalRegistration.hospitalStep,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const Gap(8),
                if (_addingNew) _newHospitalForm(context) else _searchAndResults(context),
              ],
              if (_selectedHospital != null && !_addingNew) ...[
                const Gap(AppSpacing.md),
                if (_selectedHospital!.isPendingReview)
                  Text(
                    context.t.hospitalRegistration.pendingReviewNotice,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: AppColors.warning),
                  ),
              ],
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomActionBar(
        child: LoadingFilledButton(
          label: context.t.hospitalRegistration.submit,
          loading: isLoading,
          onPressed: _canSubmit && !isLoading ? _submit : null,
        ),
      ),
    );
  }

  Widget _searchAndResults(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _search,
          decoration: InputDecoration(
            hintText: context.t.hospitalRegistration.searchHint,
            prefixIcon: const Icon(Icons.search_rounded, size: 20),
          ),
        ),
        const Gap(8),
        if (_searching)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Center(child: CircularProgressIndicator()),
          )
        else ...[
          for (final hospital in _results)
            Card(
              margin: const EdgeInsets.only(bottom: 6),
              child: ListTile(
                title: Text(hospital.name),
                subtitle: hospital.address.isNotEmpty ? Text(hospital.address) : null,
                selected: _selectedHospital?.id == hospital.id,
                trailing: _selectedHospital?.id == hospital.id
                    ? const Icon(Icons.check_circle_rounded, color: AppColors.success)
                    : null,
                onTap: () => setState(() => _selectedHospital = hospital),
              ),
            ),
          if (_results.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                context.t.hospitalRegistration.noResultsFound,
                style: TextStyle(color: context.colors.textSecondary),
              ),
            ),
          const Gap(4),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: () => setState(() {
                _addingNew = true;
                _selectedHospital = null;
              }),
              icon: const Icon(Icons.add_circle_outline_rounded, size: 18),
              label: Text(context.t.hospitalRegistration.addManually),
            ),
          ),
        ],
      ],
    );
  }

  Widget _newHospitalForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _newNameController,
          autofocus: true,
          decoration:
              InputDecoration(labelText: context.t.hospitalRegistration.newHospitalName),
          onChanged: (_) => setState(() {}),
        ),
        const Gap(4),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
            onPressed: () => setState(() {
              _addingNew = false;
              _newNameController.clear();
            }),
            child: Text(context.t.hospitalRegistration.useSearchInstead),
          ),
        ),
      ],
    );
  }
}
