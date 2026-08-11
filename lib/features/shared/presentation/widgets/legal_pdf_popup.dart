import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

import 'package:medalize_mb/features/shared/data/legal_pdf_builder.dart';
import 'package:medalize_mb/features/shared/presentation/widgets/app_bar_title.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

/// Shows the Privacy Policy + Terms PDF in an in-app popup (a near-full-height
/// modal sheet) rather than handing off to an external browser or PDF viewer
/// — used both from the registration consent checkbox and from
/// Settings > Legal.
Future<void> showLegalPdfPopup(BuildContext context) {
  final t = context.t;
  final isChinese = LocaleSettings.currentLocale == AppLocale.zh;

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (sheetContext) => FractionallySizedBox(
      heightFactor: 0.92,
      child: Scaffold(
        appBar: AppBar(
          title: AppBarTitle(t.legal.title, icon: Icons.privacy_tip_outlined),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(sheetContext).pop(),
          ),
        ),
        body: PdfPreview(
          build: (format) => LegalPdfBuilder.build(t, isChinese: isChinese),
          allowPrinting: false,
          canChangePageFormat: false,
          canChangeOrientation: false,
          canDebug: false,
          pdfFileName: 'docline_privacy_policy.pdf',
          loadingWidget: const Center(child: CircularProgressIndicator()),
          onError: (context, error) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                t.legal.pdfLoadError,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
