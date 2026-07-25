import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/core/widgets/animated_entrance.dart';
import 'package:medalize_mb/core/widgets/app_list_card.dart';
import 'package:medalize_mb/core/widgets/app_snack_bar.dart';
import 'package:medalize_mb/core/widgets/empty_state.dart';
import 'package:medalize_mb/core/widgets/gradient_avatar.dart';
import 'package:medalize_mb/core/widgets/refreshable.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/core/widgets/shimmer_skeleton.dart';
import 'package:medalize_mb/features/family/data/models/dependent_model.dart';
import 'package:medalize_mb/features/family/data/repository/family_repository.dart';
import 'package:medalize_mb/features/family/providers/family_provider.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

/// Shared across the family screens and everywhere a dependent's
/// relationship needs a translated label (badges, appointment detail).
String relationshipLabel(String relationship) => switch (relationship) {
      DependentModel.relationshipChild => t.family.relationshipChild,
      DependentModel.relationshipSpouse => t.family.relationshipSpouse,
      DependentModel.relationshipParent => t.family.relationshipParent,
      DependentModel.relationshipSibling => t.family.relationshipSibling,
      _ => t.family.relationshipOther,
    };

class FamilyListScreen extends ConsumerWidget {
  const FamilyListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(dependentsProvider);
    return Scaffold(
      appBar: AppBar(title: Text(context.t.family.title)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          HapticFeedback.lightImpact();
          context.push('/patient/family/add');
        },
        tooltip: context.t.family.addFamilyMember,
        child: const Icon(Icons.add),
      ),
      body: async.when(
        loading: () => const ResponsiveBody(
          child: Padding(
            padding: EdgeInsets.all(AppSpacing.md),
            child: Column(
              children: [
                ShimmerSkeleton(height: 72),
                ShimmerSkeleton(height: 72),
              ],
            ),
          ),
        ),
        error: (_, _) => RefreshableView(
          onRefresh: () async => ref.invalidate(dependentsProvider),
          child: EmptyState(
            icon: Icons.cloud_off_outlined,
            title: context.t.common.somethingWrong,
            subtitle: context.t.common.tryAgain,
            actionLabel: context.t.common.retry,
            onAction: () => ref.invalidate(dependentsProvider),
          ),
        ),
        data: (dependents) {
          if (dependents.isEmpty) {
            return RefreshableView(
              onRefresh: () async => ref.invalidate(dependentsProvider),
              child: EmptyState(
                icon: Icons.family_restroom_outlined,
                title: context.t.family.empty,
                subtitle: context.t.family.emptySubtitle,
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(dependentsProvider),
            color: AppColors.primary,
            child: ResponsiveBody(
              child: ListView.builder(
                padding: const EdgeInsets.all(AppSpacing.md),
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                itemCount: dependents.length,
                itemBuilder: (_, i) => AnimatedEntrance(
                  index: i,
                  slideY: 0.05,
                  child: _DependentCard(dependent: dependents[i]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _DependentCard extends ConsumerWidget {
  const _DependentCard({required this.dependent});
  final DependentModel dependent;

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(context.t.family.deleteConfirmTitle),
        content: Text(context.t.family.deleteConfirmBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(context.t.common.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(backgroundColor: AppColors.error),
            child: Text(context.t.common.delete),
          ),
        ],
      ),
    );
    if (confirm != true) return;

    try {
      await ref.read(familyRepositoryProvider).deleteDependent(dependent.id);
      ref.invalidate(dependentsProvider);
      // A deleted dependent can no longer be the active profile — fall back
      // to "myself" so a stale reference never lingers into the next booking.
      if (ref.read(activeProfileProvider)?.id == dependent.id) {
        ref.read(activeProfileProvider.notifier).state = null;
      }
    } on ApiException catch (e) {
      if (context.mounted) {
        AppSnackBar.show(context, e.userMessage, type: SnackBarType.error);
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.colors;
    return AppListCard(
      leading: GradientAvatar(initials: dependent.fullName, size: 44),
      onTap: () {
        HapticFeedback.lightImpact();
        context.push('/patient/family/${dependent.id}/edit', extra: dependent);
      },
      trailing: IconButton(
        icon: const Icon(Icons.delete_outline, size: 20),
        color: c.textSecondary,
        onPressed: () => _confirmDelete(context, ref),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            dependent.fullName,
            style: Theme.of(context).textTheme.titleSmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const Gap(2),
          Text(
            relationshipLabel(dependent.relationship),
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: c.textSecondary),
          ),
        ],
      ),
    );
  }
}
