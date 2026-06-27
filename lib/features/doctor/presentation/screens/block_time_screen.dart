import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:gap/gap.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/network/dio_client.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/core/widgets/primary_button.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

class BlockTimeScreen extends ConsumerStatefulWidget {
  const BlockTimeScreen({super.key});

  @override
  ConsumerState<BlockTimeScreen> createState() => _BlockTimeScreenState();
}

class _BlockTimeScreenState extends ConsumerState<BlockTimeScreen> {
  DateTimeRange? _dateRange;
  bool _notifyPatients = false;
  final _reasonController = TextEditingController();
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _pickDateRange() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) setState(() => _dateRange = picked);
  }

  Future<void> _submit() async {
    if (_dateRange == null) {
      setState(() => _error = context.t.blockTime.selectDateRange);
      return;
    }
    setState(() {
      _loading = true;
      _error = null;
    });
    final dio = ref.read(dioClientProvider);
    try {
      await dio.post('/doctor/blocked-periods/', data: {
        'starts_at': _dateRange!.start.toIso8601String(),
        'ends_at': _dateRange!.end
            .add(const Duration(hours: 23, minutes: 59))
            .toIso8601String(),
        'reason': _reasonController.text.trim(),
        'notify_patients': _notifyPatients,
      });
      if (mounted) context.pop(true);
    } catch (e) {
      setState(() => _error = context.t.blockTime.failedToBlock);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final fmt = DateFormat('d MMM y');
    return Scaffold(
      appBar: AppBar(title: Text(context.t.blockTime.title)),
      body: ResponsiveBody(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(context.t.blockTime.dateRange,
                  style: Theme.of(context).textTheme.titleSmall),
              const Gap(AppSpacing.sm),
              GestureDetector(
                onTap: _pickDateRange,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: c.surface,
                    border: Border.all(color: c.border),
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.date_range_outlined,
                          size: 20, color: c.primaryText),
                      const Gap(10),
                      Expanded(
                        child: Text(
                          _dateRange == null
                              ? context.t.blockTime.tapToSelect
                              : '${fmt.format(_dateRange!.start)} → ${fmt.format(_dateRange!.end)}',
                          style: TextStyle(
                            color: _dateRange == null
                                ? c.textSecondary
                                : c.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(AppSpacing.md),
              TextField(
                controller: _reasonController,
                decoration: InputDecoration(
                  labelText: context.t.blockTime.reason,
                  alignLabelWithHint: true,
                ),
                maxLines: 2,
              ),
              const Gap(12),
              SwitchListTile(
                title: Text(context.t.blockTime.notifyPatients),
                subtitle: Text(context.t.blockTime.notifyDesc),
                value: _notifyPatients,
                onChanged: (v) => setState(() => _notifyPatients = v),
                contentPadding: EdgeInsets.zero,
              ),
              if (_error != null) ...[
                const Gap(AppSpacing.sm),
                Text(_error!, style: const TextStyle(color: AppColors.error)),
              ],
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomActionBar(
        child: LoadingFilledButton(
          label: context.t.blockTime.blockButton,
          loading: _loading,
          onPressed: _submit,
        ),
      ),
    );
  }
}
