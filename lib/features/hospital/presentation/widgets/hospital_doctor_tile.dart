import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/core/widgets/app_card.dart';
import 'package:medalize_mb/features/hospital/data/models/hospital_link_model.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

/// A confirmed doctor's row on the hospital dashboard — tap to edit their
/// hours, menu for removing the affiliation.
class HospitalDoctorTile extends StatelessWidget {
  const HospitalDoctorTile({
    super.key,
    required this.link,
    required this.onEditHours,
    required this.onRemove,
  });

  final HospitalDoctorLinkModel link;
  final VoidCallback onEditHours;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return AppCard(
      margin: EdgeInsets.zero,
      onTap: onEditHours,
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
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.schedule_outlined),
            tooltip: context.t.hospitalDoctors.editHours,
            onPressed: onEditHours,
          ),
          PopupMenuButton<void>(
            icon: const Icon(Icons.more_vert_rounded),
            itemBuilder: (_) => [
              PopupMenuItem(
                onTap: onRemove,
                child: Text(
                  context.t.hospitalDoctors.remove,
                  style: const TextStyle(color: AppColors.error),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
