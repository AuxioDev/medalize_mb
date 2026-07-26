import 'dart:typed_data';

import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'package:medalize_mb/i18n/strings.g.dart';

/// Builds the Privacy Policy + Terms of Service PDF shown in-app (registration
/// consent popup, Settings > Legal). Content comes from the same `legal.*`
/// i18n keys used by [LegalScreen], so the two are always in sync.
///
/// Uses Noto Sans (Latin/Cyrillic) or Noto Sans SC (Chinese) via
/// `PdfGoogleFonts` rather than the pdf package's built-in base14 fonts,
/// which only cover plain ASCII/WinAnsi — not enough for ru/az/zh content.
/// The font is fetched once and cached on-device by `printing` afterward;
/// the first render of each language needs network access.
class LegalPdfBuilder {
  const LegalPdfBuilder._();

  static Future<Uint8List> build(Translations t, {required bool isChinese}) async {
    final regular = isChinese
        ? await PdfGoogleFonts.notoSansSCRegular()
        : await PdfGoogleFonts.notoSansRegular();
    final bold = isChinese
        ? await PdfGoogleFonts.notoSansSCBold()
        : await PdfGoogleFonts.notoSansBold();

    final doc = pw.Document(
      theme: pw.ThemeData.withFont(base: regular, bold: bold),
    );
    final legal = t.legal;
    // (title, body) records — the generated section classes
    // (Translations$legal$sections$identity$en, ...health$en, ...) don't
    // share a common type, so a plain list of them can't be iterated
    // generically; records sidestep that.
    final sections = <(String, String)>[
      (legal.sections.identity.title, legal.sections.identity.body),
      (legal.sections.health.title, legal.sections.health.body),
      (legal.sections.professional.title, legal.sections.professional.body),
      (legal.sections.location.title, legal.sections.location.body),
      (legal.sections.device.title, legal.sections.device.body),
      (legal.sections.payment.title, legal.sections.payment.body),
      (legal.sections.family.title, legal.sections.family.body),
      (legal.sections.purposes.title, legal.sections.purposes.body),
      (legal.sections.legalBasis.title, legal.sections.legalBasis.body),
      (legal.sections.thirdParties.title, legal.sections.thirdParties.body),
      (legal.sections.retention.title, legal.sections.retention.body),
      (legal.sections.rights.title, legal.sections.rights.body),
      (legal.sections.security.title, legal.sections.security.body),
      (legal.sections.permissions.title, legal.sections.permissions.body),
      (legal.sections.children.title, legal.sections.children.body),
    ];

    doc.addPage(
      pw.MultiPage(
        margin: const pw.EdgeInsets.all(32),
        build: (context) => [
          pw.Header(
            level: 0,
            child: pw.Text(
              legal.pdfDocumentTitle,
              style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.Text(
            legal.controllerNotice,
            style: pw.TextStyle(fontSize: 9, fontStyle: pw.FontStyle.italic),
          ),
          pw.SizedBox(height: 16),
          pw.Text(
            legal.privacyTitle,
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 6),
          pw.Text(legal.privacyIntro, style: const pw.TextStyle(fontSize: 10)),
          for (final (title, body) in sections) ...[
            pw.SizedBox(height: 12),
            pw.Text(
              title,
              style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 3),
            pw.Text(body, style: const pw.TextStyle(fontSize: 10)),
          ],
          pw.SizedBox(height: 20),
          pw.Text(
            legal.termsTitle,
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 6),
          pw.Text(legal.termsIntro, style: const pw.TextStyle(fontSize: 10)),
          pw.SizedBox(height: 6),
          pw.Text(legal.termsBody, style: const pw.TextStyle(fontSize: 10)),
          pw.SizedBox(height: 20),
          pw.Text(legal.contact, style: const pw.TextStyle(fontSize: 10)),
        ],
      ),
    );

    return doc.save();
  }
}
