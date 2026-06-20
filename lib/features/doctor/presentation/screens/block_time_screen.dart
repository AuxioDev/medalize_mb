import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:medalize_mb/core/network/dio_client.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';

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
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(primary: AppColors.primary),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _dateRange = picked);
  }

  Future<void> _submit() async {
    if (_dateRange == null) {
      setState(() => _error = 'Please select a date range.');
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
      setState(() => _error = 'Failed to block time. Please try again.');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final fmt = DateFormat('d MMM y');
    return Scaffold(
      appBar: AppBar(title: const Text('Block Time')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Date Range', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: _pickDateRange,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _dateRange == null
                      ? 'Tap to select dates'
                      : '${fmt.format(_dateRange!.start)} → ${fmt.format(_dateRange!.end)}',
                  style: TextStyle(
                    color: _dateRange == null ? Colors.grey : Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _reasonController,
              decoration: const InputDecoration(
                labelText: 'Reason (optional)',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 12),
            SwitchListTile(
              title: const Text('Notify affected patients'),
              subtitle: const Text('Send notifications to patients with appointments in this period'),
              value: _notifyPatients,
              activeThumbColor: AppColors.primary,
              onChanged: (v) => setState(() => _notifyPatients = v),
              contentPadding: EdgeInsets.zero,
            ),
            if (_error != null) ...[
              const SizedBox(height: 8),
              Text(_error!, style: const TextStyle(color: Colors.red)),
            ],
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _loading ? null : _submit,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: _loading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : const Text('Block Period'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
