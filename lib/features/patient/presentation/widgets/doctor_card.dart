import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/core/utils/next_slot_format.dart';
import 'package:medalize_mb/core/widgets/app_card.dart';
import 'package:medalize_mb/core/widgets/book_now_button.dart';
import 'package:medalize_mb/core/widgets/gradient_avatar.dart';
import 'package:medalize_mb/features/doctors/data/models/doctor_model.dart';
import 'package:medalize_mb/features/patient/providers/favorites_provider.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

/// Full doctor card — avatar, name, specialization, city/distance, rating,
/// next available slot, favorite toggle, book button. Shared by the doctor
/// search list (`doctor_search_screen.dart`) and the favorites list
/// (`favorites_screen.dart`), which used to keep two near-identical copies
/// of this (favorites' version was missing icons, rating and next-slot —
/// drift from a shared origin, not a deliberate simpler design: favorites
/// already gets rating/next_slot fields from the same `DoctorPublicSerializer`
/// the search list uses, see apps.appointments.serializers on the backend).
class DoctorCard extends ConsumerWidget {
  const DoctorCard({super.key, required this.doctor, this.batchedNextSlot});

  final DoctorModel doctor;

  /// A screen-wide batched next-slot lookup (see
  /// `nextSlotBatchProvider` in `doctor_search_screen.dart`) — this card
  /// just reads its own id out of it, rather than each card making its own
  /// request. Left null where no such batch exists (e.g. the favorites
  /// list): the next-slot row then only shows when `doctor.nextSlotAt`
  /// already arrived directly with the doctor payload, and is omitted
  /// entirely otherwise, rather than showing a spinner for a fetch that
  /// will never happen.
  final AsyncValue<Map<String, DateTime?>>? batchedNextSlot;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.colors;
    final initials =
        doctor.firstName.isNotEmpty ? doctor.firstName[0].toUpperCase() : 'D';
    // ordering=next_slot already returns next_slot_at with the list — skip
    // the extra per-doctor round-trip when it's there.
    final AsyncValue<DateTime?>? nextSlot = doctor.nextSlotAt != null
        ? AsyncValue<DateTime?>.data(doctor.nextSlotAt)
        : batchedNextSlot?.when(
            data: (map) => AsyncValue<DateTime?>.data(map[doctor.id]),
            loading: () => const AsyncValue<DateTime?>.loading(),
            error: AsyncValue<DateTime?>.error,
          );
    final isFavorite =
        ref.watch(favoritesProvider.select((s) => s.contains(doctor.id)));

    return AppCard(
      onTap: () {
        HapticFeedback.lightImpact();
        context.push('/patient/doctor-detail/${doctor.id}', extra: doctor);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Hero(
                tag: 'doctor-avatar-${doctor.id}',
                child: doctor.avatarUrl != null
                    ? CachedNetworkImage(
                        imageUrl: doctor.avatarUrl!,
                        imageBuilder: (ctx, imageProvider) => CircleAvatar(
                          radius: 26,
                          backgroundImage: imageProvider,
                        ),
                        placeholder: (ctx, _) => GradientAvatar(initials: initials, size: 52),
                        errorWidget: (ctx, url, _) => GradientAvatar(initials: initials, size: 52),
                      )
                    : GradientAvatar(initials: initials, size: 52),
              ),
              const Gap(12),
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
                    const Gap(3),
                    Row(
                      children: [
                        Icon(Icons.medical_services_outlined,
                            size: 13, color: c.primaryText),
                        const Gap(4),
                        Expanded(
                          child: Text(
                            doctor.specializationDisplay,
                            style: TextStyle(
                                fontSize: 13,
                                color: c.primaryText,
                                fontWeight: FontWeight.w500),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    if (doctor.primaryWorkplaceCity != null ||
                        doctor.distanceKm != null) ...[
                      const Gap(2),
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined,
                              size: 13, color: c.textSecondary),
                          const Gap(3),
                          Text(
                            [
                              if (doctor.primaryWorkplaceCity != null)
                                doctor.primaryWorkplaceCity!,
                              if (doctor.distanceKm != null)
                                context.t.doctorSearch.distanceKm(
                                    km: doctor.distanceKm!.toStringAsFixed(1)),
                            ].join(' · '),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                    const Gap(2),
                    if (doctor.averageRating != null)
                      Row(
                        children: [
                          Icon(Icons.star_rounded, size: 13, color: Colors.amber.shade600),
                          const Gap(3),
                          Text(
                            '${doctor.averageRating!.toStringAsFixed(1)} (${doctor.reviewCount})',
                            style: TextStyle(fontSize: 11, color: c.textSecondary),
                          ),
                        ],
                      )
                    else
                      Text(
                        context.t.common.noRatings,
                        style: TextStyle(fontSize: 11, color: c.textSecondary),
                      ),
                    if (nextSlot != null) ...[
                      const Gap(4),
                      nextSlot.when(
                        loading: () => const SizedBox(
                          height: 12,
                          width: 80,
                          child: LinearProgressIndicator(minHeight: 2),
                        ),
                        error: (_, _) => const SizedBox.shrink(),
                        data: (date) => date == null
                            ? Text(
                                context.t.doctorSearch.noAvailability,
                                style: TextStyle(
                                    fontSize: 11, color: c.textSecondary),
                              )
                            : Row(
                                children: [
                                  Icon(Icons.event_available_outlined,
                                      size: 12, color: c.primaryText),
                                  const Gap(3),
                                  Text(
                                    formatNextSlotDate(context, date),
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: c.primaryText,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ],
                  ],
                ),
              ),
              IconButton(
                tooltip: isFavorite
                    ? context.t.favorites.remove
                    : context.t.favorites.add,
                visualDensity: VisualDensity.compact,
                onPressed: () {
                  HapticFeedback.selectionClick();
                  ref.read(favoritesProvider.notifier).toggle(doctor.id);
                },
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? AppColors.error : c.textSecondary,
                  size: 22,
                ),
              ),
            ],
          ),
          const Gap(8),
          BookNowButton(doctorId: doctor.id),
        ],
      ),
    );
  }
}
