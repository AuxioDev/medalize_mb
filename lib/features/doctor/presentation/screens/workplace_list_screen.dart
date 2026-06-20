import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/network/dio_client.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';

final _workplacesProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
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
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (workplaces) {
          if (workplaces.isEmpty) {
            return const Center(child: Text('No workplaces yet. Tap + to add one.'));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(_workplacesProvider),
            child: ListView.builder(
              itemCount: workplaces.length,
              itemBuilder: (_, i) => _WorkplaceCard(
                workplace: workplaces[i],
                onDeleted: () => ref.invalidate(_workplacesProvider),
                onEdited: () => ref.invalidate(_workplacesProvider),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _WorkplaceCard extends ConsumerWidget {
  const _WorkplaceCard({
    required this.workplace,
    required this.onDeleted,
    required this.onEdited,
  });

  final Map<String, dynamic> workplace;
  final VoidCallback onDeleted;
  final VoidCallback onEdited;

  Future<void> _setPrimary(BuildContext context, Dio dio) async {
    try {
      await dio.patch('/doctor/workplaces/${workplace['id']}/set-primary/');
      onEdited();
    } catch (_) {}
  }

  Future<void> _delete(BuildContext context, Dio dio) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Workplace'),
        content: Text('Delete "${workplace['name']}"?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirm != true) return;
    try {
      await dio.delete('/doctor/workplaces/${workplace['id']}/');
      onDeleted();
    } on DioException catch (e) {
      if (context.mounted) {
        final msg = (e.response?.data as Map?)?['message'] ?? 'Cannot delete workplace';
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg as String)));
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dio = ref.read(dioClientProvider);
    final isPrimary = workplace['is_primary'] as bool? ?? false;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.business, color: AppColors.primary),
            title: Row(
              children: [
                Expanded(child: Text(workplace['name'] as String)),
                if (isPrimary)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text('Primary',
                        style: TextStyle(color: AppColors.primary, fontSize: 11)),
                  ),
              ],
            ),
            subtitle: Text('${workplace['address']}, ${workplace['city']}'),
            trailing: PopupMenuButton<String>(
              onSelected: (v) async {
                if (v == 'edit') {
                  final saved = await context.push<bool>(
                    '/doctor/edit-workplace/${workplace['id']}',
                    extra: workplace,
                  );
                  if (saved == true) onEdited();
                } else if (v == 'primary') {
                  await _setPrimary(context, dio);
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
                  const PopupMenuItem(value: 'primary', child: Text('Set as Primary')),
                const PopupMenuItem(
                  value: 'delete',
                  child: Text('Delete', style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
