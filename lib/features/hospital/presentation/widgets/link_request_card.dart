import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/core/widgets/app_card.dart';
import 'package:medalize_mb/core/widgets/app_snack_bar.dart';
import 'package:medalize_mb/features/hospital/data/models/hospital_link_model.dart';
import 'package:medalize_mb/features/hospital/data/repository/hospital_repository.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

/// A single doctor affiliation request or invite on the hospital dashboard.
/// [link.status] decides what's shown:
/// - `pending` (doctor asked to join): Approve/Reject buttons.
/// - `invited` (hospital invited, doctor hasn't answered): a waiting chip,
///   no action — the hospital is the one waiting here.
class LinkRequestCard extends ConsumerStatefulWidget {
  const LinkRequestCard({
    super.key,
    required this.link,
    this.onApproved,
    this.onRejected,
  });

  final HospitalDoctorLinkModel link;
  final VoidCallback? onApproved;
  final VoidCallback? onRejected;

  @override
  ConsumerState<LinkRequestCard> createState() => _LinkRequestCardState();
}

class _LinkRequestCardState extends ConsumerState<LinkRequestCard> {
  bool _busy = false;

  Future<void> _approve() async {
    setState(() => _busy = true);
    try {
      await ref.read(hospitalRepositoryProvider).approveLink(widget.link.id);
      widget.onApproved?.call();
    } catch (_) {
      if (mounted) {
        AppSnackBar.show(context, context.t.common.somethingWrong, type: SnackBarType.error);
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _reject() async {
    setState(() => _busy = true);
    try {
      await ref.read(hospitalRepositoryProvider).rejectLink(widget.link.id);
      widget.onRejected?.call();
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
    final isPending = link.status == HospitalDoctorLinkModel.statusPending;

    return AppCard(
      margin: EdgeInsets.zero,
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.primary.withValues(alpha: 0.12),
            child: Text(
              link.doctor.fullName.isNotEmpty ? link.doctor.fullName[0].toUpperCase() : '?',
              style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700),
            ),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(link.doctor.fullName,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.w600)),
                if (link.doctor.specializationDisplay.isNotEmpty)
                  Text(link.doctor.specializationDisplay,
                      style: TextStyle(color: c.textSecondary, fontSize: 12)),
                const Gap(2),
                Text(
                  isPending
                      ? context.t.hospitalDoctors.requestedToJoin
                      : context.t.hospitalDoctors.invitedAwaiting,
                  style: TextStyle(color: c.textSecondary, fontSize: 11),
                ),
              ],
            ),
          ),
          if (isPending)
            if (_busy)
              const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            else
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close_rounded, color: AppColors.error),
                    tooltip: context.t.hospitalDoctors.reject,
                    onPressed: _reject,
                  ),
                  IconButton(
                    icon: const Icon(Icons.check_rounded, color: AppColors.success),
                    tooltip: context.t.hospitalDoctors.approve,
                    onPressed: _approve,
                  ),
                ],
              ),
        ],
      ),
    );
  }
}
