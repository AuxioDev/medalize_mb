import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/widgets/app_snack_bar.dart';
import 'package:medalize_mb/core/widgets/empty_state.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/core/widgets/shimmer_skeleton.dart';
import 'package:medalize_mb/features/hospital/data/models/hospital_link_model.dart';
import 'package:medalize_mb/features/hospital/data/repository/hospital_repository.dart';
import 'package:medalize_mb/features/hospital/presentation/widgets/hospital_doctor_tile.dart';
import 'package:medalize_mb/features/hospital/presentation/widgets/link_request_card.dart';
import 'package:medalize_mb/features/hospital/providers/hospital_provider.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

class HospitalDoctorsScreen extends ConsumerStatefulWidget {
  const HospitalDoctorsScreen({super.key});

  @override
  ConsumerState<HospitalDoctorsScreen> createState() => _HospitalDoctorsScreenState();
}

class _HospitalDoctorsScreenState extends ConsumerState<HospitalDoctorsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tab;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.t.hospitalDoctors.title),
        bottom: TabBar(
          controller: _tab,
          tabs: [
            Tab(text: context.t.hospitalDoctors.tabConfirmed),
            Tab(text: context.t.hospitalDoctors.tabRequests),
            Tab(text: context.t.hospitalDoctors.tabInvited),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add_alt_outlined),
            onPressed: () => context.push('/hospital/invite-doctor'),
          ),
        ],
      ),
      body: TabBarView(
        controller: _tab,
        children: [
          _ConfirmedList(),
          _RequestsList(status: HospitalDoctorLinkModel.statusPending),
          _RequestsList(status: HospitalDoctorLinkModel.statusInvited),
        ],
      ),
    );
  }
}

class _ConfirmedList extends ConsumerWidget {
  const _ConfirmedList();

  Future<void> _remove(BuildContext context, WidgetRef ref, HospitalDoctorLinkModel link) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(context.t.hospitalDoctors.removeConfirmTitle),
        content: Text(
          context.t.hospitalDoctors.removeConfirmMessage(name: link.doctor.fullName),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(context.t.common.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: AppButtonStyles.destructiveFilled,
            child: Text(context.t.hospitalDoctors.remove),
          ),
        ],
      ),
    );
    if (confirm != true) return;
    try {
      await ref.read(hospitalRepositoryProvider).removeLink(link.id);
      refreshHospitalLinks(ref);
    } catch (_) {
      if (context.mounted) {
        AppSnackBar.show(context, context.t.common.somethingWrong, type: SnackBarType.error);
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(hospitalLinksProvider(HospitalDoctorLinkModel.statusConfirmed));
    return RefreshIndicator(
      onRefresh: () async => refreshHospitalLinks(ref),
      color: AppColors.primary,
      child: ResponsiveBody(
        child: async.when(
          loading: () => const _ListSkeleton(),
          error: (_, _) => _errorState(context, ref),
          data: (links) {
            if (links.isEmpty) {
              return _emptyList(
                context.t.hospitalDoctors.noConfirmedDoctors,
                Icons.groups_outlined,
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.all(AppSpacing.md),
              itemCount: links.length,
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (_, i) {
                final link = links[i];
                return HospitalDoctorTile(
                  link: link,
                  onEditHours: () => context.push(
                    '/hospital/doctors/${link.doctor.id}/hours',
                    extra: link.doctor,
                  ),
                  onRemove: () => _remove(context, ref, link),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _RequestsList extends ConsumerWidget {
  const _RequestsList({required this.status});

  final String status;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(hospitalLinksProvider(status));
    final isPending = status == HospitalDoctorLinkModel.statusPending;
    return RefreshIndicator(
      onRefresh: () async => refreshHospitalLinks(ref),
      color: AppColors.primary,
      child: ResponsiveBody(
        child: async.when(
          loading: () => const _ListSkeleton(),
          error: (_, _) => _errorState(context, ref),
          data: (links) {
            if (links.isEmpty) {
              return _emptyList(
                isPending ? context.t.hospitalDoctors.noRequests : context.t.hospitalDoctors.noInvited,
                Icons.mail_outline_rounded,
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.all(AppSpacing.md),
              itemCount: links.length,
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (_, i) => LinkRequestCard(
                link: links[i],
                onApproved: () => refreshHospitalLinks(ref),
                onRejected: () => refreshHospitalLinks(ref),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ListSkeleton extends StatelessWidget {
  const _ListSkeleton();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(AppSpacing.md),
      child: Column(children: [
        ShimmerSkeleton(height: 76),
        SizedBox(height: 8),
        ShimmerSkeleton(height: 76),
        SizedBox(height: 8),
        ShimmerSkeleton(height: 76),
      ]),
    );
  }
}

Widget _emptyList(String title, IconData icon) => Center(
      child: EmptyState(icon: icon, title: title, subtitle: ''),
    );

Widget _errorState(BuildContext context, WidgetRef ref) => Center(
      child: EmptyState(
        icon: Icons.cloud_off_outlined,
        title: context.t.common.somethingWrong,
        subtitle: context.t.common.tryAgain,
        actionLabel: context.t.common.retry,
        onAction: () => refreshHospitalLinks(ref),
      ),
    );
