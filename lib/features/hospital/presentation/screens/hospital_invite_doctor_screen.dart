import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/core/widgets/app_snack_bar.dart';
import 'package:medalize_mb/core/widgets/empty_state.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/features/hospital/data/models/hospital_link_model.dart';
import 'package:medalize_mb/features/hospital/data/repository/hospital_repository.dart';
import 'package:medalize_mb/features/hospital/providers/hospital_provider.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

class HospitalInviteDoctorScreen extends ConsumerStatefulWidget {
  const HospitalInviteDoctorScreen({super.key});

  @override
  ConsumerState<HospitalInviteDoctorScreen> createState() =>
      _HospitalInviteDoctorScreenState();
}

class _HospitalInviteDoctorScreenState extends ConsumerState<HospitalInviteDoctorScreen> {
  final _search = TextEditingController();
  Timer? _debounce;
  int _requestGeneration = 0;
  List<DoctorBriefModel> _results = const [];
  bool _loading = true;
  final _invitedIds = <String>{};
  final _invitingIds = <String>{};

  @override
  void initState() {
    super.initState();
    _runSearch('');
    _search.addListener(_onQueryChanged);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _search.dispose();
    super.dispose();
  }

  void _onQueryChanged() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () => _runSearch(_search.text.trim()));
  }

  Future<void> _runSearch(String query) async {
    final generation = ++_requestGeneration;
    setState(() => _loading = true);
    try {
      final results = await ref.read(hospitalRepositoryProvider).searchDoctors(q: query);
      if (!mounted || generation != _requestGeneration) return;
      setState(() {
        _results = results;
        _loading = false;
      });
    } catch (_) {
      if (!mounted || generation != _requestGeneration) return;
      setState(() => _loading = false);
    }
  }

  Future<void> _invite(DoctorBriefModel doctor) async {
    setState(() => _invitingIds.add(doctor.id));
    try {
      await ref.read(hospitalRepositoryProvider).inviteDoctor(doctor.id);
      if (!mounted) return;
      setState(() {
        _invitedIds.add(doctor.id);
        _invitingIds.remove(doctor.id);
      });
      refreshHospitalLinks(ref);
    } catch (_) {
      if (!mounted) return;
      setState(() => _invitingIds.remove(doctor.id));
      AppSnackBar.show(context, context.t.common.somethingWrong, type: SnackBarType.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Scaffold(
      appBar: AppBar(title: Text(context.t.hospitalInvite.title)),
      body: ResponsiveBody(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: TextField(
                controller: _search,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: context.t.hospitalInvite.searchHint,
                  prefixIcon: const Icon(Icons.search_rounded, size: 20),
                ),
              ),
            ),
            Expanded(
              child: _loading
                  ? const Center(child: CircularProgressIndicator())
                  : _results.isEmpty
                      ? Center(
                          child: EmptyState(
                            icon: Icons.person_search_outlined,
                            title: context.t.hospitalInvite.noResultsFound,
                            subtitle: '',
                          ),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                          itemCount: _results.length,
                          separatorBuilder: (_, _) => const Gap(8),
                          itemBuilder: (_, i) {
                            final doctor = _results[i];
                            final invited = _invitedIds.contains(doctor.id);
                            final inviting = _invitingIds.contains(doctor.id);
                            return Card(
                              child: ListTile(
                                title: Text(doctor.fullName),
                                subtitle: doctor.specializationDisplay.isNotEmpty
                                    ? Text(doctor.specializationDisplay,
                                        style: TextStyle(color: c.textSecondary))
                                    : null,
                                trailing: invited
                                    ? Text(context.t.hospitalInvite.invited,
                                        style: const TextStyle(color: AppColors.success))
                                    : inviting
                                        ? const SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(strokeWidth: 2),
                                          )
                                        : TextButton(
                                            onPressed: () => _invite(doctor),
                                            child: Text(context.t.hospitalInvite.invite),
                                          ),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
