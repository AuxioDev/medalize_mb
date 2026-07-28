import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/core/widgets/app_card.dart';
import 'package:medalize_mb/core/widgets/empty_state.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/core/widgets/shimmer_skeleton.dart';
import 'package:medalize_mb/core/widgets/status_chip.dart';
import 'package:medalize_mb/features/hospital/providers/hospital_provider.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

class HospitalAppointmentsScreen extends ConsumerWidget {
  const HospitalAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(hospitalAppointmentsProvider);
    return Scaffold(
      appBar: AppBar(title: Text(context.t.hospitalAppointments.title)),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(hospitalAppointmentsProvider),
        color: AppColors.primary,
        child: ResponsiveBody(
          child: async.when(
            loading: () => const Padding(
              padding: EdgeInsets.all(AppSpacing.md),
              child: Column(children: [
                ShimmerSkeleton(height: 80),
                SizedBox(height: 8),
                ShimmerSkeleton(height: 80),
              ]),
            ),
            error: (_, _) => Center(
              child: EmptyState(
                icon: Icons.cloud_off_outlined,
                title: context.t.common.somethingWrong,
                subtitle: context.t.common.tryAgain,
                actionLabel: context.t.common.retry,
                onAction: () => ref.invalidate(hospitalAppointmentsProvider),
              ),
            ),
            data: (appointments) {
              if (appointments.isEmpty) {
                return Center(
                  child: EmptyState(
                    icon: Icons.calendar_today_outlined,
                    title: context.t.hospitalAppointments.empty,
                    subtitle: '',
                  ),
                );
              }
              return ListView.separated(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                padding: const EdgeInsets.all(AppSpacing.md),
                itemCount: appointments.length,
                separatorBuilder: (_, _) => const SizedBox(height: 8),
                itemBuilder: (_, i) {
                  final appt = appointments[i];
                  final c = context.colors;
                  return AppCard(
                    margin: EdgeInsets.zero,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(appt.doctor.fullName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(fontWeight: FontWeight.w600)),
                              Text(appt.workplace.name,
                                  style: TextStyle(color: c.textSecondary, fontSize: 12)),
                              const SizedBox(height: 4),
                              Text(
                                DateFormat('d MMM, HH:mm').format(appt.startsAt),
                                style: TextStyle(color: c.textSecondary, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        StatusChip(status: appt.status),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
