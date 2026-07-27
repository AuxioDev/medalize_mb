import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:dio/dio.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/network/dio_client.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/core/widgets/app_snack_bar.dart';
import 'package:medalize_mb/core/widgets/shimmer_skeleton.dart';
import 'package:medalize_mb/features/doctor/presentation/widgets/working_hours_fields.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

class WorkingHoursEditorScreen extends ConsumerStatefulWidget {
  const WorkingHoursEditorScreen({super.key, required this.workplaceId});
  final String workplaceId;

  @override
  ConsumerState<WorkingHoursEditorScreen> createState() =>
      _WorkingHoursEditorState();
}

class _WorkingHoursEditorState extends ConsumerState<WorkingHoursEditorScreen> {
  bool _loading = true;
  bool _saving = false;
  List<WorkingHoursDay> _days = WorkingHoursDay.defaultWeek();

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final dio = ref.read(dioClientProvider);
    try {
      final res = await dio.get(
        '/doctor/workplaces/${widget.workplaceId}/hours/',
      );
      setState(() {
        _days = WorkingHoursDay.fromApiList(res.data as List<dynamic>);
        _loading = false;
      });
    } on DioException catch (e) {
      if (mounted) {
        setState(() => _loading = false);
        AppSnackBar.show(
          context,
          mapDioError(e).userMessage,
          type: SnackBarType.error,
        );
      }
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _save() async {
    if (WorkingHoursDay.hasInvalidRange(_days)) {
      AppSnackBar.show(
        context,
        context.t.workingHours.invalidRange,
        type: SnackBarType.error,
      );
      return;
    }
    setState(() => _saving = true);
    final dio = ref.read(dioClientProvider);
    try {
      await dio.put(
        '/doctor/workplaces/${widget.workplaceId}/hours/',
        data: WorkingHoursDay.toPayload(_days),
      );
      if (mounted) {
        AppSnackBar.show(
          context,
          context.t.workingHours.saved,
          type: SnackBarType.success,
        );
        context.pop(true);
      }
    } on DioException catch (e) {
      if (mounted) {
        AppSnackBar.show(
          context,
          mapDioError(e).userMessage,
          type: SnackBarType.error,
        );
      }
    } catch (_) {
      if (mounted) {
        AppSnackBar.show(
          context,
          context.t.workingHours.failedToSave,
          type: SnackBarType.error,
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.t.workingHours.title),
        actions: [
          TextButton(
            onPressed: _saving ? null : _save,
            child: _saving
                ? const SizedBox(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(context.t.common.save),
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
            : SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: WorkingHoursFields(
                  days: _days,
                  onChanged: (days) => setState(() => _days = days),
                ),
              ),
      ),
    );
  }
}
