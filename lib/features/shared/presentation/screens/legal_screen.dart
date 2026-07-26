import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/core/widgets/animated_entrance.dart';
import 'package:medalize_mb/core/widgets/app_card.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/features/shared/presentation/widgets/legal_pdf_popup.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

/// Privacy Policy + Terms of Service, also shown as a PDF popup from the
/// registration screen's consent checkbox (see [showLegalPdfPopup]) — both
/// read from the same `legal.*` i18n content, so they can never drift apart.
class LegalScreen extends StatelessWidget {
  const LegalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t.legal;
    final c = context.colors;

    final sections = <(String, String)>[
      (t.sections.identity.title, t.sections.identity.body),
      (t.sections.health.title, t.sections.health.body),
      (t.sections.professional.title, t.sections.professional.body),
      (t.sections.location.title, t.sections.location.body),
      (t.sections.device.title, t.sections.device.body),
      (t.sections.payment.title, t.sections.payment.body),
      (t.sections.family.title, t.sections.family.body),
      (t.sections.purposes.title, t.sections.purposes.body),
      (t.sections.legalBasis.title, t.sections.legalBasis.body),
      (t.sections.thirdParties.title, t.sections.thirdParties.body),
      (t.sections.retention.title, t.sections.retention.body),
      (t.sections.rights.title, t.sections.rights.body),
      (t.sections.security.title, t.sections.security.body),
      (t.sections.permissions.title, t.sections.permissions.body),
      (t.sections.children.title, t.sections.children.body),
    ];

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    t.controllerNotice,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: c.textSecondary,
                          fontStyle: FontStyle.italic,
                        ),
                  ),
                  const Gap(AppSpacing.sm),
                  OutlinedButton.icon(
                    onPressed: () => showLegalPdfPopup(context),
                    icon: const Icon(Icons.picture_as_pdf_outlined, size: 18),
                    label: Text(t.viewAsPdf),
                  ),
                ],
              ),
            ),
            const Gap(AppSpacing.md),
            AnimatedEntrance(
              index: 1,
              child: _LegalSection(title: t.privacyTitle, body: t.privacyIntro, isHeading: true),
            ),
            for (final (i, (title, body)) in sections.indexed) ...[
              const Gap(AppSpacing.sm),
              AnimatedEntrance(
                index: i + 2,
                child: _LegalSection(title: title, body: body),
              ),
            ],
            const Gap(AppSpacing.md),
            AnimatedEntrance(
              index: sections.length + 2,
              child: _LegalSection(title: t.termsTitle, body: '${t.termsIntro}\n\n${t.termsBody}', isHeading: true),
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
    required this.title,
    required this.body,
    this.isHeading = false,
  });

  final String title;
  final String body;
  final bool isHeading;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return AppCard(
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: isHeading
                ? Theme.of(context).textTheme.titleMedium
                : Theme.of(context).textTheme.titleSmall,
          ),
          const Gap(8),
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
