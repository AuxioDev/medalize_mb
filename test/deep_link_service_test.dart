import 'package:flutter_test/flutter_test.dart';
import 'package:medalize_mb/core/services/deep_link_service.dart';

void main() {
  group('DeepLinkService.targetRouteFor', () {
    test('parses a doctor share link, ignoring the locale segment', () {
      final target = DeepLinkService.targetRouteFor(
        Uri.parse('https://medoroapp.com/en/doctor/doc-1'),
      );
      expect(target, '/patient/doctor-detail/doc-1');
    });

    test('parses a hospital share link', () {
      final target = DeepLinkService.targetRouteFor(
        Uri.parse('https://medoroapp.com/ru/hospital/h1'),
      );
      expect(target, '/patient/hospital-detail/h1');
    });

    test('an unrelated path (e.g. the marketing homepage) is ignored', () {
      expect(
        DeepLinkService.targetRouteFor(Uri.parse('https://medoroapp.com/en')),
        isNull,
      );
      expect(
        DeepLinkService.targetRouteFor(Uri.parse('https://medoroapp.com/')),
        isNull,
      );
    });

    test('an unrecognized kind segment is ignored', () {
      expect(
        DeepLinkService.targetRouteFor(
          Uri.parse('https://medoroapp.com/en/waitlist/x'),
        ),
        isNull,
      );
    });
  });
}
