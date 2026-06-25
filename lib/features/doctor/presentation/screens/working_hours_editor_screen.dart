import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/network/dio_client.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/core/widgets/animated_entrance.dart';
import 'package:medalize_mb/core/widgets/app_card.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/core/widgets/app_snack_bar.dart';
import 'package:medalize_mb/core/widgets/shimmer_skeleton.dart';

const _dayNames = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday'
];

class _DayState {
  bool isActive;
  TimeOfDay startTime;
  TimeOfDay endTime;

  _DayState(
      {required this.isActive,
      required this.startTime,
      required this.endTime});
}

class WorkingHoursEditorScreen extends ConsumerStatefulWidget {
  const WorkingHoursEditorScreen({super.key, required this.workplaceId});
  final String workplaceId;

  @override
  ConsumerState<WorkingHoursEditorScreen> createState() =>
      _WorkingHoursEditorState();
}

class _WorkingHoursEditorState
    extends ConsumerState<WorkingHoursEditorScreen> {
  bool _loading = true;
  bool _saving = false;
  late List<_DayState> _days;

  @override
  void initState() {
    super.initState();
    _days = List.generate(
      7,
      (_) => _DayState(
        isActive: false,
        startTime: const TimeOfDay(hour: 9, minute: 0),
        endTime: const TimeOfDay(hour: 17, minute: 0),
      ),
    );
    _load();
  }

  Future<void> _load() async {
    final dio = ref.read(dioClientProvider);
    try {
      final res =
          await dio.get('/doctor/workplaces/${widget.workplaceId}/hours/');
      final hours = res.data as List<dynamic>;
      setState(() {
        for (final h in hours) {
          final d = h as Map<String, dynamic>;
          final weekday = d['weekday'] as int;
          final parts = (d['start_time'] as String).split(':');
          final endParts = (d['end_time'] as String).split(':');
          _days[weekday] = _DayState(
            isActive: d['is_active'] as bool? ?? false,
            startTime: TimeOfDay(
              hour: int.parse(parts[0]),
              minute: int.parse(parts[1]),
            ),
            endTime: TimeOfDay(
              hour: int.parse(endParts[0]),
              minute: int.parse(endParts[1]),
            ),
          );
        }
        _loading = false;
      });
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _pickTime(int day, bool isStart) async {
    final current = isStart ? _days[day].startTime : _days[day].endTime;
    final picked = await showTimePicker(context: context, initialTime: current);
    if (picked == null) return;
    setState(() {
      if (isStart) {
        _days[day].startTime = picked;
      } else {
        _days[day].endTime = picked;
      }
    });
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    final dio = ref.read(dioClientProvider);
    final payload = List.generate(7, (i) {
      final d = _days[i];
      return {
        'weekday': i,
        'is_active': d.isActive,
        'start_time':
            '${d.startTime.hour.toString().padLeft(2, '0')}:${d.startTime.minute.toString().padLeft(2, '0')}:00',
        'end_time':
            '${d.endTime.hour.toString().padLeft(2, '0')}:${d.endTime.minute.toString().padLeft(2, '0')}:00',
      };
    });
    try {
      await dio.put('/doctor/workplaces/${widget.workplaceId}/hours/',
          data: payload);
      if (mounted) {
        AppSnackBar.show(context, 'Working hours saved', type: SnackBarType.success);
        context.pop(true);
      }
    } catch (_) {
      if (mounted) {
        AppSnackBar.show(context, 'Failed to save working hours', type: SnackBarType.error);
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Working Hours'),
        actions: [
          TextButton(
            onPressed: _saving ? null : _save,
            child: _saving
                ? const SizedBox(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Save'),
          ),
        ],
      ),
      body: ResponsiveBody(
        child: _loading
            ? const Padding(
                padding: EdgeInsets.all(AppSpacing.md),
                child: Column(
                  children: [
                    ShimmerSkeleton(height: 60),
                    ShimmerSkeleton(height: 60),
                    ShimmerSkeleton(height: 60),
                    ShimmerSkeleton(height: 60),
                    ShimmerSkeleton(height: 60),
                  ],
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(AppSpacing.md),
                itemCount: 7,
                itemBuilder: (_, i) {
                  final day = _days[i];
                  return AnimatedEntrance(
                    index: i,
                    child: AppCard(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 6),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 92,
                            child: Text(_dayNames[i],
                                style:
                                    Theme.of(context).textTheme.labelLarge),
                          ),
                          Switch(
                            value: day.isActive,
                            onChanged: (v) =>
                                setState(() => day.isActive = v),
                          ),
                          if (day.isActive) ...[
                            const Spacer(),
                            _TimeButton(
                              label: day.startTime.format(context),
                              onTap: () => _pickTime(i, true),
                            ),
                            Text('—',
                                style:
                                    TextStyle(color: context.colors.textSecondary)),
                            _TimeButton(
                              label: day.endTime.format(context),
                              onTap: () => _pickTime(i, false),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}

class _TimeButton extends StatelessWidget {
  const _TimeButton({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        minimumSize: Size.zero,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      ),
      child: Text(label),
    );
  }
}
