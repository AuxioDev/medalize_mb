import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/features/assistant/data/models/assistant_models.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

/// Compact doctor card rendered under an assistant message when the bot
/// suggested doctors. "Book" opens the regular doctor-detail screen, which
/// loads its own data by id.
class SuggestedDoctorCard extends StatelessWidget {
  const SuggestedDoctorCard({super.key, required this.doctor});

  final SuggestedDoctor doctor;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final subtitleParts = [
      if (doctor.specializationDisplay.isNotEmpty) doctor.specializationDisplay,
      if (doctor.city.isNotEmpty) doctor.city,
    ];

    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: c.border),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(AppRadius.sm + 2),
            ),
            child: const Icon(Icons.medical_services_outlined,
                color: Colors.white, size: 20),
          ),
          const Gap(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctor.fullName,
                  style: Theme.of(context).textTheme.labelLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const Gap(2),
                Row(
                  children: [
                    if (doctor.averageRating != null) ...[
                      const Icon(Icons.star_rounded,
                          size: 14, color: AppColors.warning),
                      const Gap(2),
                      Text(
                        doctor.averageRating!.toStringAsFixed(1),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const Gap(6),
                    ],
                    Expanded(
                      child: Text(
                        subtitleParts.join(' · '),
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Gap(8),
          FilledButton(
            onPressed: () =>
                context.push('/patient/doctor-detail/${doctor.id}'),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              minimumSize: const Size(0, 36),
              textStyle:
                  const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            child: Text(context.t.assistant.book),
          ),
        ],
      ),
    );
  }
}
