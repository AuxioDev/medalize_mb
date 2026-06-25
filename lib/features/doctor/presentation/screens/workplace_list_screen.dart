import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/network/dio_client.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/core/widgets/animated_entrance.dart';
import 'package:medalize_mb/core/widgets/app_card.dart';
import 'package:medalize_mb/core/widgets/app_snack_bar.dart';
import 'package:medalize_mb/core/widgets/empty_state.dart';
import 'package:medalize_mb/core/widgets/refreshable.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/core/widgets/shimmer_skeleton.dart';

final _workplacesProvider =
    FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final dio = ref.read(dioClientProvider);
  final res = await dio.get('/doctor/workplaces/');
  return (res.data as List<dynamic>).cast<Map<String, dynamic>>();
});

class WorkplaceListScreen extends ConsumerWidget {
  const WorkplaceListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(_workplacesProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('My Workplaces')),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final added = await context.push<bool>('/doctor/add-workplace');
          if (added == true) ref.invalidate(_workplacesProvider);
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
            onRefresh: () async => ref.invalidate(_workplacesProvider),
            child: EmptyState(
              icon: Icons.cloud_off_outlined,
              title: 'Something went wrong',
              subtitle: 'Could not load workplaces',
              actionLabel: 'Retry',
              onAction: () => ref.invalidate(_workplacesProvider),
            ),
          ),
          data: (workplaces) {
            if (workplaces.isEmpty) {
              return RefreshableView(
                onRefresh: () async => ref.invalidate(_workplacesProvider),
                child: const EmptyState(
                  icon: Icons.business_outlined,
                  title: 'No workplaces yet',
                  subtitle: 'Tap + to add your first workplace',
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: () async => ref.invalidate(_workplacesProvider),
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
                    onChanged: () => ref.invalidate(_workplacesProvider),
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

  Future<void> _setPrimary(Dio dio) async {
    try {
      await dio.patch('/doctor/workplaces/${workplace['id']}/set-primary/');
      onChanged();
    } catch (_) {}
  }

  Future<void> _delete(BuildContext context, Dio dio) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Workplace'),
        content: Text('Delete "${workplace['name']}"?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel')),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.error,
              minimumSize: Size.zero,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            ),
            child: const Text('Delete'),
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
        final msg =
            (e.response?.data as Map?)?['message'] ?? 'Cannot delete workplace';
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
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.success.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(AppRadius.xl),
                        ),
                        child: const Text('Primary',
                            style: TextStyle(
                                color: AppColors.success,
                                fontSize: 10,
                                fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ],
                ),
                const Gap(2),
                Text(
                  '${workplace['address']}, ${workplace['city']}',
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
                await _setPrimary(dio);
              } else if (v == 'hours') {
                context.push('/doctor/working-hours/${workplace['id']}');
              } else if (v == 'delete') {
                await _delete(context, dio);
              }
            },
            itemBuilder: (_) => [
              const PopupMenuItem(value: 'hours', child: Text('Working Hours')),
              const PopupMenuItem(value: 'edit', child: Text('Edit')),
              if (!isPrimary)
                const PopupMenuItem(
                    value: 'primary', child: Text('Set as Primary')),
              const PopupMenuItem(
                value: 'delete',
                child:
                    Text('Delete', style: TextStyle(color: AppColors.error)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
