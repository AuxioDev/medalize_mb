import 'package:medalize_mb/core/config/app_config.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

/// Builds the public medalize_web links shown as a share link / encoded into
/// a QR code (QR_SHARE_PROFILE_PLAN.md Phase 1/2) — the same six locale
/// segments as the app's own [AppLocale], so the page a recipient lands on
/// matches whatever language the sharer currently has the app set to.
abstract final class ShareUrls {
  static String doctor(String id) =>
      '${AppConfig.webBaseUrl}/${LocaleSettings.currentLocale.languageCode}/doctor/$id';

  static String hospital(String id) =>
      '${AppConfig.webBaseUrl}/${LocaleSettings.currentLocale.languageCode}/hospital/$id';
}
