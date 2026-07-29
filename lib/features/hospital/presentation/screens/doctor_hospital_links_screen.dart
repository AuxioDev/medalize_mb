import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/core/widgets/app_card.dart';
import 'package:medalize_mb/core/widgets/app_snack_bar.dart';
import 'package:medalize_mb/core/widgets/empty_state.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/core/widgets/shimmer_skeleton.dart';
import 'package:medalize_mb/features/hospital/data/models/doctor_hospital_link_model.dart';
import 'package:medalize_mb/features/hospital/data/repository/hospital_repository.dart';
import 'package:medalize_mb/features/hospital/providers/hospital_provider.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

enum _LinksFilter { invitations, requests, confirmed }

/// A doctor's own hospital affiliations: invites from hospitals to accept
/// or decline, their own still-pending requests (made by picking a hospital
/// on the workplace form), and hospitals they're already confirmed at.
///
/// Backed by a single unfiltered GET /api/doctor/hospital-links/ (see
/// doctorHospitalLinksProvider) — unlike the hospital-side dashboard, this
/// list is never long enough to need per-status pagination, so the three
/// tabs below just filter the one response client-side.
class DoctorHospitalLinksScreen extends ConsumerStatefulWidget {
  const DoctorHospitalLinksScreen({super.key});

  @override
  ConsumerState<DoctorHospitalLinksScreen> createState() => _DoctorHospitalLinksScreenState();
}

class _DoctorHospitalLinksScreenState extends ConsumerState<DoctorHospitalLinksScreen>
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
        title: Text(context.t.doctorHospitals.title),
        bottom: TabBar(
          controller: _tab,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          tabs: [
            Tab(text: context.t.doctorHospitals.tabInvitations),
            Tab(text: context.t.doctorHospitals.tabRequests),
            Tab(text: context.t.doctorHospitals.tabConfirmed),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tab,
        children: const [
          _LinksList(filter: _LinksFilter.invitations),
          _LinksList(filter: _LinksFilter.requests),
          _LinksList(filter: _LinksFilter.confirmed),
        ],
      ),
    );
  }
}

class _LinksList extends ConsumerWidget {
  const _LinksList({required this.filter});
  final _LinksFilter filter;

  List<DoctorHospitalLinkModel> _select(List<DoctorHospitalLinkModel> all) {
    switch (filter) {
      case _LinksFilter.invitations:
        return all.where((l) => l.status == DoctorHospitalLinkModel.statusInvited).toList();
      case _LinksFilter.requests:
        return all
            .where((l) =>
                l.status == DoctorHospitalLinkModel.statusPending &&
                l.requestedBy == DoctorHospitalLinkModel.requestedByDoctor)
            .toList();
      case _LinksFilter.confirmed:
        return all.where((l) => l.status == DoctorHospitalLinkModel.statusConfirmed).toList();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(doctorHospitalLinksProvider);
    return RefreshIndicator(
      onRefresh: () async => refreshDoctorHospitalLinks(ref),
      color: AppColors.primary,
      child: ResponsiveBody(
        child: async.when(
          loading: () => const _ListSkeleton(),
          error: (_, _) => _ScrollableCenter(
            child: EmptyState(
              icon: Icons.cloud_off_outlined,
              title: context.t.common.somethingWrong,
              subtitle: context.t.common.tryAgain,
              actionLabel: context.t.common.retry,
              onAction: () => refreshDoctorHospitalLinks(ref),
            ),
          ),
          data: (all) {
            final links = _select(all);
            if (links.isEmpty) {
              final message = switch (filter) {
                _LinksFilter.invitations => context.t.doctorHospitals.noInvitations,
                _LinksFilter.requests => context.t.doctorHospitals.noRequests,
                _LinksFilter.confirmed => context.t.doctorHospitals.noConfirmed,
              };
              return _ScrollableCenter(
                child: EmptyState(icon: Icons.local_hospital_outlined, title: message, subtitle: ''),
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.all(AppSpacing.md),
              itemCount: links.length,
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (_, i) => _LinkCard(
                link: links[i],
                showActions: filter != _LinksFilter.confirmed,
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Wraps content in a scrollable so RefreshIndicator's pull-to-refresh still
/// works when the state (empty/error) is too short to fill the viewport.
class _ScrollableCenter extends StatelessWidget {
  const _ScrollableCenter({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: Center(child: child),
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
      ]),
    );
  }
}

/// One hospital affiliation row. [showActions] is false for the confirmed
/// tab (nothing to do there — leaving a hospital happens by clearing
/// `hospital` on the workplace form, an existing flow this screen doesn't
/// duplicate).
class _LinkCard extends ConsumerStatefulWidget {
  const _LinkCard({required this.link, required this.showActions});
  final DoctorHospitalLinkModel link;
  final bool showActions;

  @override
  ConsumerState<_LinkCard> createState() => _LinkCardState();
}

class _LinkCardState extends ConsumerState<_LinkCard> {
  bool _busy = false;

  Future<void> _accept() async {
    setState(() => _busy = true);
    try {
      await ref.read(hospitalRepositoryProvider).acceptHospitalInvite(widget.link.id);
      refreshDoctorHospitalLinks(ref);
    } catch (_) {
      if (mounted) {
        AppSnackBar.show(context, context.t.common.somethingWrong, type: SnackBarType.error);
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _decline() async {
    setState(() => _busy = true);
    try {
      await ref.read(hospitalRepositoryProvider).declineHospitalLink(widget.link.id);
      refreshDoctorHospitalLinks(ref);
    } catch (_) {
      if (mounted) {
        AppSnackBar.show(context, context.t.common.somethingWrong, type: SnackBarType.error);
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final link = widget.link;
    final isInvite = link.status == DoctorHospitalLinkModel.statusInvited;

    return AppCard(
      margin: EdgeInsets.zero,
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.primary.withValues(alpha: 0.12),
            child: const Icon(Icons.local_hospital_outlined, color: AppColors.primary, size: 20),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  link.hospital.name,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (link.hospital.cityDisplay.isNotEmpty)
                  Text(link.hospital.cityDisplay, style: TextStyle(color: c.textSecondary, fontSize: 12)),
                if (widget.showActions) ...[
                  const Gap(2),
                  Text(
                    isInvite
                        ? context.t.doctorHospitals.invitedYouToJoin
                        : context.t.doctorHospitals.awaitingApproval,
                    style: TextStyle(color: c.textSecondary, fontSize: 11),
                  ),
                ],
              ],
            ),
          ),
          if (widget.showActions)
            if (_busy)
              const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            else if (isInvite)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close_rounded, color: AppColors.error),
                    tooltip: context.t.doctorHospitals.decline,
                    onPressed: _decline,
                  ),
                  IconButton(
                    icon: const Icon(Icons.check_rounded, color: AppColors.success),
                    tooltip: context.t.doctorHospitals.accept,
                    onPressed: _accept,
                  ),
                ],
              )
            else
              TextButton(
                onPressed: _decline,
                style: TextButton.styleFrom(foregroundColor: AppColors.error),
                child: Text(context.t.doctorHospitals.cancelRequest),
              ),
        ],
      ),
    );
  }
}
