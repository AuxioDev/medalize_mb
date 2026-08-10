import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/network/dio_client.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/core/widgets/animated_entrance.dart';
import 'package:medalize_mb/core/widgets/app_badge.dart';
import 'package:medalize_mb/core/widgets/app_card.dart';
import 'package:medalize_mb/core/widgets/app_snack_bar.dart';
import 'package:medalize_mb/core/widgets/empty_state.dart';
import 'package:medalize_mb/core/widgets/refreshable.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/core/widgets/shimmer_skeleton.dart';
import 'package:medalize_mb/features/doctor/presentation/screens/add_edit_workplace_screen.dart';
import 'package:medalize_mb/features/shared/presentation/widgets/app_bar_title.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

/// The doctor's workplaces. Also consumed by [EditWorkplaceLoader] to recover
/// a single workplace by id when GoRouter `extra` is unavailable.
///
/// `autoDispose`: this doctor's own data — must not survive a logout/login
/// as another doctor on a shared device. Disposed once nothing is watching
/// it, which the auth redirect guarantees happens on both logout and the
/// next login (see `medications/providers/medication_provider.dart` for the
/// full rationale).
final workplacesProvider =
    FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final dio = ref.read(dioClientProvider);
  final res = await dio.get('/doctor/workplaces/');
  return (res.data as List<dynamic>).cast<Map<String, dynamic>>();
});

class WorkplaceListScreen extends ConsumerWidget {
  const WorkplaceListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(workplacesProvider);
    return Scaffold(
      appBar: AppBar(
          title: AppBarTitle(context.t.workplaces.title,
              icon: Icons.business_outlined)),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final added = await context.push<bool>('/doctor/add-workplace');
          if (added == true) ref.invalidate(workplacesProvider);
        },
        child: const Icon(Icons.add),
      ),
      body: ResponsiveBody(
        child: async.when(
          loading: () => const Padding(
            padding: EdgeInsets.all(AppSpacing.md),
            child: Column(
              children: [
                ShimmerSkeleton(height: 76),
                ShimmerSkeleton(height: 76),
                ShimmerSkeleton(height: 76),
              ],
            ),
          ),
          error: (_, _) => RefreshableView(
            onRefresh: () async => ref.invalidate(workplacesProvider),
            child: EmptyState(
              icon: Icons.cloud_off_outlined,
              title: context.t.common.somethingWrong,
              subtitle: context.t.workplaces.couldNotLoad,
              actionLabel: context.t.common.retry,
              onAction: () => ref.invalidate(workplacesProvider),
            ),
          ),
          data: (workplaces) {
            if (workplaces.isEmpty) {
              return RefreshableView(
                onRefresh: () async => ref.invalidate(workplacesProvider),
                child: EmptyState(
                  icon: Icons.business_outlined,
                  title: context.t.workplaces.noWorkplacesYet,
                  subtitle: context.t.workplaces.tapToAdd,
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: () async => ref.invalidate(workplacesProvider),
              color: AppColors.primary,
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(
                    AppSpacing.md, AppSpacing.md, AppSpacing.md, 88),
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                itemCount: workplaces.length,
                itemBuilder: (_, i) => AnimatedEntrance(
                  index: i,
                  child: _WorkplaceCard(
                    workplace: workplaces[i],
                    onChanged: () => ref.invalidate(workplacesProvider),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _WorkplaceCard extends ConsumerWidget {
  const _WorkplaceCard({required this.workplace, required this.onChanged});

  final Map<String, dynamic> workplace;
  final VoidCallback onChanged;

  Future<void> _setPrimary(BuildContext context, Dio dio) async {
    try {
      await dio.patch('/doctor/workplaces/${workplace['id']}/set-primary/');
      onChanged();
    } on DioException catch (e) {
      if (context.mounted) {
        AppSnackBar.show(context, mapDioError(e).userMessage,
            type: SnackBarType.error);
      }
    }
  }

  Future<void> _delete(BuildContext context, Dio dio) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(context.t.workplaces.deleteTitle),
        content: Text(context.t.workplaces
            .deleteConfirm(name: workplace['name'] as String)),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(context.t.common.cancel)),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: AppButtonStyles.destructiveFilled,
            child: Text(context.t.common.delete),
          ),
        ],
      ),
    );
    if (confirm != true) return;
    try {
      await dio.delete('/doctor/workplaces/${workplace['id']}/');
      onChanged();
    } on DioException catch (e) {
      if (context.mounted) {
        final msg = (e.response?.data as Map?)?['message'] ??
            context.t.workplaces.cannotDelete;
        AppSnackBar.show(context, msg as String, type: SnackBarType.error);
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.colors;
    final dio = ref.read(dioClientProvider);
    final isPrimary = workplace['is_primary'] as bool? ?? false;

    return AppCard(
      padding: const EdgeInsets.fromLTRB(14, 12, 4, 12),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: c.primarySurface,
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Icon(Icons.business_outlined, color: c.primaryText, size: 22),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        workplace['name'] as String,
                        style: Theme.of(context).textTheme.labelLarge,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (isPrimary) ...[
                      const Gap(8),
                      AppBadge(label: context.t.common.primary),
                    ],
                  ],
                ),
                const Gap(2),
                Text(
                  '${workplace['address']}, ${workplace['city_display'] ?? workplace['city']}',
                  style: Theme.of(context).textTheme.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: c.textSecondary),
            onSelected: (v) async {
              if (v == 'edit') {
                final saved = await context.push<bool>(
                  '/doctor/edit-workplace/${workplace['id']}',
                  extra: workplace,
                );
                if (saved == true) onChanged();
              } else if (v == 'primary') {
                await _setPrimary(context, dio);
              } else if (v == 'hours') {
                context.push('/doctor/working-hours/${workplace['id']}');
              } else if (v == 'delete') {
                await _delete(context, dio);
              }
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                  value: 'hours',
                  child: Text(context.t.workplaces.workingHours)),
              PopupMenuItem(value: 'edit', child: Text(context.t.common.edit)),
              if (!isPrimary)
                PopupMenuItem(
                    value: 'primary',
                    child: Text(context.t.workplaces.setAsPrimary)),
              PopupMenuItem(
                value: 'delete',
                child: Text(context.t.common.delete,
                    style: const TextStyle(color: AppColors.error)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Wraps [AddEditWorkplaceScreen] to handle cases where the GoRouter [extra]
/// state is unavailable (deep link, app restoration after kill). There is no
/// single-workplace endpoint on the backend, so it falls back to loading the
/// full workplace list and picking the entry matching [workplaceId].
class EditWorkplaceLoader extends ConsumerWidget {
  const EditWorkplaceLoader({
    super.key,
    required this.workplaceId,
    this.existing,
  });

  final String workplaceId;
  final Map<String, dynamic>? existing;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (existing != null) {
      return AddEditWorkplaceScreen(existing: existing);
    }
    final async = ref.watch(workplacesProvider);
    return async.when(
      loading: () => Scaffold(
        appBar: AppBar(),
        body: const Padding(
          padding: EdgeInsets.all(AppSpacing.md),
          child: Column(children: [
            ShimmerSkeleton(height: 64),
            ShimmerSkeleton(height: 120),
            ShimmerSkeleton(height: 120),
            ShimmerSkeleton(height: 80),
          ]),
        ),
      ),
      error: (_, _) => Scaffold(
        appBar: AppBar(),
        body: EmptyState(
          icon: Icons.cloud_off_outlined,
          title: context.t.common.somethingWrong,
          subtitle: context.t.workplaces.couldNotLoad,
          actionLabel: context.t.common.retry,
          onAction: () => ref.invalidate(workplacesProvider),
        ),
      ),
      data: (workplaces) {
        Map<String, dynamic>? match;
        for (final w in workplaces) {
          if ('${w['id']}' == workplaceId) {
            match = w;
            break;
          }
        }
        if (match == null) {
          return Scaffold(
            appBar: AppBar(),
            body: EmptyState(
              icon: Icons.business_outlined,
              title: context.t.common.somethingWrong,
              subtitle: context.t.workplaces.couldNotLoad,
              actionLabel: context.t.common.retry,
              onAction: () => ref.invalidate(workplacesProvider),
            ),
          );
        }
        return AddEditWorkplaceScreen(existing: match);
      },
    );
  }
}
