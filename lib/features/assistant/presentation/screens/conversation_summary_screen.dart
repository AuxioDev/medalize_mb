import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/errors/api_exception.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/core/widgets/app_card.dart';
import 'package:medalize_mb/core/widgets/empty_state.dart';
import 'package:medalize_mb/core/widgets/primary_button.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/core/widgets/section_header.dart';
import 'package:medalize_mb/core/widgets/shimmer_skeleton.dart';
import 'package:medalize_mb/features/assistant/data/models/assistant_models.dart';
import 'package:medalize_mb/features/assistant/providers/assistant_provider.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

/// Structured, exportable report generated on demand from the whole
/// conversation (Phase 2, Section 2). Reached only from
/// `assistant_chat_screen.dart`'s "Get Summary" action.
class ConversationSummaryScreen extends ConsumerWidget {
  const ConversationSummaryScreen({super.key, required this.conversationId});

  final String conversationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(conversationSummaryProvider(conversationId));

    return Scaffold(
      appBar: AppBar(title: Text(context.t.assistant.summaryTitle)),
      body: ResponsiveBody(
        child: async.when(
          loading: () => const _LoadingSkeleton(),
          error: (err, _) => EmptyState(
            icon: Icons.cloud_off_outlined,
            title: context.t.common.somethingWrong,
            subtitle: err is ApiException ? err.userMessage : context.t.common.tryAgain,
            actionLabel: context.t.common.retry,
            onAction: () => ref.invalidate(conversationSummaryProvider(conversationId)),
          ),
          data: (detail) {
            final summary = detail.summary;
            if (summary == null) {
              return EmptyState(
                icon: Icons.summarize_outlined,
                title: context.t.assistant.summaryNotReadyYet,
                subtitle: '',
              );
            }
            return _SummaryBody(summary: summary);
          },
        ),
      ),
    );
  }
}

class _SummaryBody extends StatelessWidget {
  const _SummaryBody({required this.summary});

  final ConversationSummaryModel summary;

  Future<void> _share(BuildContext context) async {
    final t = context.t.assistant;
    final buffer = StringBuffer()
      ..writeln(t.summaryTitle)
      ..writeln()
      ..writeln(summary.summaryText);

    if (summary.possibleConditions.isNotEmpty) {
      buffer
        ..writeln()
        ..writeln('${t.possibleConditions}:');
      for (final c in summary.possibleConditions) {
        final likelihood = _likelihoodLabel(context, c.likelihood);
        buffer.writeln('- ${c.name} ($likelihood)${c.note.isEmpty ? '' : ': ${c.note}'}');
      }
    }

    buffer
      ..writeln()
      ..writeln(_urgencyLabel(context, summary.urgency))
      ..writeln('${t.recommendedSpecialization}: '
          '${_specializationLabel(context, summary.recommendedSpecialization)}');

    await SharePlus.instance.share(ShareParams(text: buffer.toString(), subject: t.summaryTitle));
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _UrgencyBanner(urgency: summary.urgency),
          const Gap(AppSpacing.lg - 4),
          Text(
            summary.summaryText,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: c.textPrimary,
                  height: 1.5,
                ),
          ),
          if (summary.possibleConditions.isNotEmpty) ...[
            const Gap(AppSpacing.lg),
            SectionHeader(title: context.t.assistant.possibleConditions),
            const Gap(AppSpacing.sm),
            for (final condition in summary.possibleConditions)
              _ConditionCard(condition: condition),
          ],
          const Gap(AppSpacing.lg),
          _SpecializationCard(code: summary.recommendedSpecialization),
          const Gap(AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: LoadingFilledButton(
                  label: context.t.assistant.findDoctors,
                  icon: Icons.search_rounded,
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    context.push('/patient/doctor-search');
                  },
                ),
              ),
              const Gap(10),
              SizedBox(
                width: 48,
                height: 48,
                child: IconButton.outlined(
                  tooltip: context.t.assistant.share,
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    _share(context);
                  },
                  icon: const Icon(Icons.ios_share_rounded),
                ),
              ),
            ],
          ),
          const Gap(24),
        ],
      ),
    );
  }
}

/// The most prominent element on the screen: 4 distinct visual states for
/// [ConversationSummaryModel.urgency], escalating from calm (routine) to a
/// hard warning (emergency).
class _UrgencyBanner extends StatelessWidget {
  const _UrgencyBanner({required this.urgency});

  final String urgency;

  @override
  Widget build(BuildContext context) {
    final (color, icon) = _urgencyStyle(urgency);
    final isEmergency = urgency == ConversationSummaryModel.urgencyEmergency;
    final label = _urgencyLabel(context, urgency);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: color.withValues(alpha: 0.4),
          width: isEmergency ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 30),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 16),
                ),
                if (isEmergency) ...[
                  const Gap(4),
                  Text(
                    context.t.assistant.emergencyWarning,
                    style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ConditionCard extends StatelessWidget {
  const _ConditionCard({required this.condition});

  final PossibleConditionModel condition;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final color = _likelihoodColor(condition.likelihood);

    return AppCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(condition.name, style: Theme.of(context).textTheme.labelLarge),
                if (condition.note.isNotEmpty) ...[
                  const Gap(3),
                  Text(
                    condition.note,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: c.textSecondary),
                  ),
                ],
              ],
            ),
          ),
          const Gap(8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppRadius.xl),
            ),
            child: Text(
              _likelihoodLabel(context, condition.likelihood),
              style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class _SpecializationCard extends StatelessWidget {
  const _SpecializationCard({required this.code});

  final String code;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: c.primarySurface,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        children: [
          Icon(Icons.medical_services_outlined, color: c.primaryText, size: 20),
          const Gap(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.t.assistant.recommendedSpecialization,
                  style: TextStyle(fontSize: 11, color: c.textSecondary),
                ),
                Text(
                  _specializationLabel(context, code),
                  style: TextStyle(color: c.primaryText, fontWeight: FontWeight.w700, fontSize: 15),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadingSkeleton extends StatelessWidget {
  const _LoadingSkeleton();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: const [
        ShimmerSkeleton(height: 90),
        ShimmerSkeleton(height: 60),
        ShimmerSkeleton(height: 70),
        ShimmerSkeleton(height: 70),
      ],
    );
  }
}

(Color, IconData) _urgencyStyle(String urgency) => switch (urgency) {
      ConversationSummaryModel.urgencySoon => (AppColors.primary, Icons.event_available_outlined),
      ConversationSummaryModel.urgencyUrgent => (AppColors.warning, Icons.warning_amber_rounded),
      ConversationSummaryModel.urgencyEmergency => (AppColors.error, Icons.emergency_outlined),
      // Includes 'routine' and any unrecognized value — degrade to the calmest state.
      _ => (AppColors.success, Icons.check_circle_outline_rounded),
    };

String _urgencyLabel(BuildContext context, String urgency) {
  final t = context.t.assistant;
  return switch (urgency) {
    ConversationSummaryModel.urgencySoon => t.urgencySoon,
    ConversationSummaryModel.urgencyUrgent => t.urgencyUrgent,
    ConversationSummaryModel.urgencyEmergency => t.urgencyEmergency,
    _ => t.urgencyRoutine,
  };
}

/// Own color scale for likelihood — deliberately not [StatusChip], which is
/// scoped to appointment statuses and would be a semantic mismatch here.
Color _likelihoodColor(String likelihood) => switch (likelihood) {
      PossibleConditionModel.likelihoodHigh => AppColors.error,
      PossibleConditionModel.likelihoodMedium => AppColors.warning,
      _ => AppColors.success,
    };

String _likelihoodLabel(BuildContext context, String likelihood) {
  final t = context.t.assistant;
  return switch (likelihood) {
    PossibleConditionModel.likelihoodHigh => t.likelihoodHigh,
    PossibleConditionModel.likelihoodMedium => t.likelihoodMedium,
    _ => t.likelihoodLow,
  };
}

/// The backend's specialization enum (`_SPECIALIZATION_CODES` in
/// `apps/assistant/service.py`) is wider than the codes
/// `doctorSearch.spec.*` currently has translations for — fall back to a
/// humanized version of the raw code for the rest, the same pattern
/// `StatusChip.labelFor` uses for unmapped statuses.
String _specializationLabel(BuildContext context, String code) {
  final s = context.t.doctorSearch.spec;
  return switch (code) {
    'general_practice' => s.general,
    'cardiology' => s.cardiology,
    'dermatology' => s.dermatology,
    'neurology' => s.neurology,
    'orthopedics' => s.orthopedics,
    'pediatrics' => s.pediatrics,
    'psychiatry' => s.psychiatry,
    'gynecology' => s.gynecology,
    'urology' => s.urology,
    'ophthalmology' => s.ophthalmology,
    'ent' => s.ent,
    _ => code
        .split('_')
        .map((w) => w.isEmpty ? '' : w[0].toUpperCase() + w.substring(1))
        .join(' '),
  };
}
