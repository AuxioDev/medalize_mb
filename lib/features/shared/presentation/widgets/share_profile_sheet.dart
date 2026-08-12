import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:medalize_mb/core/constants/app_spacing.dart';
import 'package:medalize_mb/core/theme/theme_colors.dart';
import 'package:medalize_mb/core/widgets/app_snack_bar.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

/// Bottom sheet offering both ways to share a profile: the native share
/// sheet (link) and a QR code someone can scan directly, side by side in one
/// sheet rather than a nested "show QR" sub-screen.
Future<void> showShareProfileSheet(
  BuildContext context, {
  required String url,
  required String subject,
}) {
  return showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (_) => _ShareProfileSheet(url: url, subject: subject),
  );
}

class _ShareProfileSheet extends StatelessWidget {
  const _ShareProfileSheet({required this.url, required this.subject});

  final String url;
  final String subject;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          0,
          AppSpacing.lg,
          AppSpacing.lg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.t.share.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Gap(20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppRadius.lg),
                border: Border.all(color: c.border),
              ),
              child: QrImageView(
                data: url,
                version: QrVersions.auto,
                size: 208,
                backgroundColor: Colors.white,
              ),
            ),
            const Gap(24),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                icon: const Icon(Icons.ios_share_rounded),
                label: Text(context.t.share.shareLink),
                onPressed: () {
                  Navigator.of(context).pop();
                  SharePlus.instance.share(
                    ShareParams(uri: Uri.parse(url), subject: subject),
                  );
                },
              ),
            ),
            const Gap(10),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.copy_outlined),
                label: Text(context.t.share.copyLink),
                onPressed: () async {
                  await Clipboard.setData(ClipboardData(text: url));
                  if (context.mounted) {
                    Navigator.of(context).pop();
                    AppSnackBar.show(context, context.t.share.linkCopied);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
