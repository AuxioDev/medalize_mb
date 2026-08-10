import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/core/widgets/animated_entrance.dart';
import 'package:medalize_mb/core/widgets/app_card.dart';
import 'package:medalize_mb/core/widgets/app_snack_bar.dart';
import 'package:medalize_mb/core/widgets/responsive_body.dart';
import 'package:medalize_mb/features/shared/presentation/widgets/app_bar_title.dart';
import 'package:medalize_mb/features/shared/presentation/widgets/legal_pdf_popup.dart';
import 'package:medalize_mb/i18n/strings.g.dart';
import 'package:url_launcher/url_launcher.dart';

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
      appBar: AppBar(
        title: AppBarTitle(t.title, icon: Icons.privacy_tip_outlined),
      ),
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
                  _ControllerNoticeText(text: t.controllerNotice),
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

/// Renders [text] with the literal `auxiodev.com` substring (present in
/// every locale's `legal.controllerNotice` — see `lib/i18n/*.i18n.json`,
/// the domain itself isn't translated) as a tappable external link,
/// styled like the Privacy/Terms links in `register_screen.dart`'s consent
/// row (`AppColors.primary` + `FontWeight.w600`). A `TapGestureRecognizer`
/// needs an explicit `dispose()` (unlike a plain `GestureDetector`), which
/// is why this is a small dedicated `StatefulWidget` rather than inlined
/// into `LegalScreen`'s otherwise-stateless `build()`.
class _ControllerNoticeText extends StatefulWidget {
  const _ControllerNoticeText({required this.text});

  final String text;

  @override
  State<_ControllerNoticeText> createState() => _ControllerNoticeTextState();
}

class _ControllerNoticeTextState extends State<_ControllerNoticeText> {
  static const _domain = 'auxiodev.com';

  late final TapGestureRecognizer _linkRecognizer;

  @override
  void initState() {
    super.initState();
    _linkRecognizer = TapGestureRecognizer()..onTap = _openWebsite;
  }

  @override
  void dispose() {
    _linkRecognizer.dispose();
    super.dispose();
  }

  Future<void> _openWebsite() async {
    final uri = Uri.https(_domain);
    final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!opened && mounted) {
      AppSnackBar.show(context, context.t.common.somethingWrong, type: SnackBarType.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final baseStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
          color: context.colors.textSecondary,
          fontStyle: FontStyle.italic,
        );
    final index = widget.text.indexOf(_domain);
    // Falls back to plain (non-linked) text if a future edit to any
    // locale's controllerNotice ever drops or renames the literal
    // substring — never worth a crash over a cosmetic link.
    if (index == -1) {
      return Text(widget.text, style: baseStyle);
    }
    return Text.rich(
      TextSpan(
        style: baseStyle,
        children: [
          TextSpan(text: widget.text.substring(0, index)),
          TextSpan(
            text: _domain,
            style: const TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
            ),
            recognizer: _linkRecognizer,
          ),
          TextSpan(text: widget.text.substring(index + _domain.length)),
        ],
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
