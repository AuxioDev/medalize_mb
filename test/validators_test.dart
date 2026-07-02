import 'package:flutter_test/flutter_test.dart';
import 'package:medalize_mb/core/utils/validators.dart';

void main() {
  group('Validators.email', () {
    test('accepts valid addresses', () {
      expect(Validators.email('user@example.com'), isNull);
      expect(Validators.email('a.b+c@sub.domain.co'), isNull);
    });

    test('rejects empty and malformed addresses', () {
      expect(Validators.email(''), isNotNull);
      expect(Validators.email(null), isNotNull);
      expect(Validators.email('not-an-email'), isNotNull);
      expect(Validators.email('missing@tld'), isNotNull);
      expect(Validators.email('@nolocal.com'), isNotNull);
    });

    test('trims surrounding whitespace', () {
      expect(Validators.email('  user@example.com  '), isNull);
    });
  });

  group('Validators.password', () {
    test('accepts 8+ chars with a letter and a digit', () {
      expect(Validators.password('Pass1234'), isNull);
    });

    test('rejects when too short', () {
      expect(Validators.password('Ab1'), isNotNull);
    });

    test('rejects when missing a digit', () {
      expect(Validators.password('OnlyLetters'), isNotNull);
    });

    test('rejects when missing a letter', () {
      expect(Validators.password('12345678'), isNotNull);
    });

    test('rejects empty/null', () {
      expect(Validators.password(''), isNotNull);
      expect(Validators.password(null), isNotNull);
    });
  });

  group('Validators.confirmPassword', () {
    test('passes when matching', () {
      expect(Validators.confirmPassword('Pass1234', 'Pass1234'), isNull);
    });

    test('fails when different', () {
      expect(Validators.confirmPassword('Pass1234', 'Other123'), isNotNull);
    });

    test('fails when empty', () {
      expect(Validators.confirmPassword('', 'Pass1234'), isNotNull);
    });
  });

  group('Validators.name', () {
    test('accepts normal and accented names', () {
      expect(Validators.name('John', label: 'Name'), isNull);
      expect(Validators.name('José-María', label: 'Name'), isNull);
      expect(Validators.name("O'Brien", label: 'Name'), isNull);
    });

    test('rejects too short or empty', () {
      expect(Validators.name('A', label: 'Name'), isNotNull);
      expect(Validators.name('', label: 'Name'), isNotNull);
    });

    test('rejects invalid characters', () {
      expect(Validators.name('John123', label: 'Name'), isNotNull);
      expect(Validators.name('<script>', label: 'Name'), isNotNull);
    });

    test('uses the provided label in the message', () {
      expect(Validators.name('', label: 'First name'), contains('First name'));
    });
  });

  group('Validators.phone', () {
    test('accepts 7–15 digit numbers, ignoring formatting', () {
      expect(Validators.phone('50 123 45 67'), isNull); // 9 digits, formatted
      expect(Validators.phone('1234567'), isNull); // 7 digits (lower bound)
      expect(Validators.phone('13800138000'), isNull); // 11 digits (e.g. CN mobile)
    });

    test('rejects too short or too long', () {
      expect(Validators.phone('+123'), isNotNull); // 3 digits, too short
      expect(Validators.phone('1234567890123456'), isNotNull); // 16 digits, too long
    });

    test('rejects empty/null', () {
      expect(Validators.phone(''), isNotNull);
      expect(Validators.phone(null), isNotNull);
    });
  });

  group('Live boolean helpers', () {
    test('emailOk mirrors email()', () {
      expect(Validators.emailOk('user@example.com'), isTrue);
      expect(Validators.emailOk('bad'), isFalse);
    });

    test('passwordOk mirrors password()', () {
      expect(Validators.passwordOk('Pass1234'), isTrue);
      expect(Validators.passwordOk('short'), isFalse);
    });

    test('phoneOk treats empty as ok (optional field)', () {
      expect(Validators.phoneOk(''), isTrue);
      expect(Validators.phoneOk('1234567'), isTrue);
      expect(Validators.phoneOk('+123'), isFalse);
    });
  });
}
