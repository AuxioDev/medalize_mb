import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/core/widgets/animated_entrance.dart';
import 'package:medalize_mb/core/widgets/app_card.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

/// Privacy Policy + Terms of Service. Currently shows placeholder copy with a
/// clear draft notice; replace the bodies (or point them at hosted URLs) before
/// the public launch.
class LegalScreen extends StatelessWidget {
  const LegalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t.legal;
    final c = context.colors;

    return Scaffold(
      appBar: AppBar(title: Text(t.title)),
      body: ResponsiveBody(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.md,
            AppSpacing.md,
            AppSpacing.md,
            96,
          ),
          children: [
            AnimatedEntrance(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: AppColors.warning.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(
                    color: AppColors.warning.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.info_outline,
                      size: 18,
                      color: AppColors.warning,
                    ),
                    const Gap(8),
                    Expanded(
                      child: Text(
                        t.draftNotice,
                        style: TextStyle(fontSize: 12, color: c.textPrimary),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Gap(AppSpacing.md),
            AnimatedEntrance(
              index: 1,
              child: _LegalSection(
                icon: Icons.privacy_tip_outlined,
                title: t.privacyTitle,
                body: t.privacyBody,
              ),
            ),
            const Gap(AppSpacing.md),
            AnimatedEntrance(
              index: 2,
              child: _LegalSection(
                icon: Icons.description_outlined,
                title: t.termsTitle,
                body: t.termsBody,
              ),
            ),
            const Gap(AppSpacing.lg),
            Center(
              child: Text(
                t.contact,
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: c.textSecondary),
              ),
            ),
            const Gap(AppSpacing.md),
          ],
        ),
      ),
    );
  }
}

class _LegalSection extends StatelessWidget {
  const _LegalSection({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return AppCard(
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: c.primaryText),
              const Gap(8),
              Text(title, style: Theme.of(context).textTheme.titleSmall),
            ],
          ),
          const Gap(10),
          Text(
            body,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: c.textPrimary, height: 1.5),
          ),
        ],
      ),
    );
  }
}
