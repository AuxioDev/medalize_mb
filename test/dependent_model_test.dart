import 'package:flutter_test/flutter_test.dart';
import 'package:medalize_mb/features/family/data/models/dependent_model.dart';

void main() {
  group('DependentModel.fromJson', () {
    test('parses a full DependentSerializer payload', () {
      final d = DependentModel.fromJson({
        'id': 'd1',
        'first_name': 'Anna',
        'last_name': 'Doe',
        'relationship': 'child',
        'date_of_birth': '2020-03-15',
        'blood_type': 'O+',
        'allergies': 'Peanuts',
        'chronic_conditions': '',
        'medications': '',
        'contact_email': 'anna-contact@test.com',
        'contact_phone': '+994501234567',
        'consent_notice_sent_at': '2026-08-01T10:00:00Z',
        'is_active': true,
      });
      expect(d.fullName, 'Anna Doe');
      expect(d.relationship, DependentModel.relationshipChild);
      expect(d.dateOfBirth, DateTime(2020, 3, 15));
      expect(d.bloodType, 'O+');
      expect(d.allergies, 'Peanuts');
      expect(d.contactEmail, 'anna-contact@test.com');
      expect(d.contactPhone, '+994501234567');
      expect(d.consentNoticeSentAt, isNotNull);
      expect(d.isActive, isTrue);
    });

    test('defaults contact fields and consentNoticeSentAt when absent', () {
      final d = DependentModel.fromJson({
        'id': 'd1',
        'first_name': 'Anna',
        'relationship': 'child',
        'date_of_birth': '2020-03-15',
      });
      expect(d.contactEmail, '');
      expect(d.contactPhone, '');
      expect(d.consentNoticeSentAt, isNull);
    });

    test('parses the brief embed shape (id, first_name, last_name, '
        'relationship only) used on appointments/medications/records', () {
      final d = DependentModel.fromJson({
        'id': 'd2',
        'first_name': 'Mark',
        'last_name': 'Doe',
        'relationship': 'spouse',
      });
      expect(d.fullName, 'Mark Doe');
      expect(d.relationship, DependentModel.relationshipSpouse);
      // The brief embed never includes these — they default rather than
      // throwing so the same fromJson works for both shapes.
      expect(d.dateOfBirth, isNull);
      expect(d.age, isNull);
      expect(d.bloodType, '');
    });

    test('defaults relationship to "other" when absent', () {
      final d = DependentModel.fromJson({'id': 'd3', 'first_name': 'Sam'});
      expect(d.relationship, DependentModel.relationshipOther);
    });
  });

  group('DependentModel.age', () {
    test("is null when date of birth isn't known", () {
      const d = DependentModel(id: 'd1', firstName: 'Anna');
      expect(d.age, isNull);
    });

    test("decrements before this year's birthday has occurred", () {
      final now = DateTime.now();
      // December 31st: for any day other than itself, this year's
      // occurrence hasn't happened yet, so age is one less than the raw
      // year difference. On the (extremely rare) day this test runs on
      // Dec 31 itself, the birthday has just occurred, so it isn't.
      final dob = DateTime(now.year - 6, 12, 31);
      final d = DependentModel(id: 'd1', firstName: 'Anna', dateOfBirth: dob);
      final expected = (now.month == 12 && now.day == 31) ? 6 : 5;
      expect(d.age, expected);
    });

    test("does not decrement on/after this year's birthday", () {
      final now = DateTime.now();
      // January 1st has always already occurred (or is occurring) by any
      // date within the same year, so this is deterministic regardless of
      // when the test runs.
      final dob = DateTime(now.year - 6, 1, 1);
      final d = DependentModel(id: 'd1', firstName: 'Anna', dateOfBirth: dob);
      expect(d.age, 6);
    });
  });

  group('DependentModel.ageFromDob', () {
    // Static counterpart of DependentModel.age, used by
    // AddEditDependentScreen to gate the adult contact-email requirement
    // from the raw date-picker value before a DependentModel exists yet.
    test('is null for a null date of birth', () {
      expect(DependentModel.ageFromDob(null), isNull);
    });

    test('computes 18 for a date of birth exactly 18 years ago today', () {
      final now = DateTime.now();
      final dob = DateTime(now.year - 18, now.month, now.day);
      expect(DependentModel.ageFromDob(dob), 18);
    });

    test("has not yet turned 18 while this year's Dec 31 birthday hasn't occurred", () {
      // Same Dec-31-vs-Jan-1 technique as the DependentModel.age group
      // above, scaled to the 18-year threshold this screen actually gates
      // on.
      final now = DateTime.now();
      final dob = DateTime(now.year - 18, 12, 31);
      final expected = (now.month == 12 && now.day == 31) ? 18 : 17;
      expect(DependentModel.ageFromDob(dob), expected);
    });

    test('has turned 18 once this year\'s Jan 1 birthday has occurred', () {
      final now = DateTime.now();
      final dob = DateTime(now.year - 18, 1, 1);
      expect(DependentModel.ageFromDob(dob), 18);
    });

    test('agrees with the instance getter for the same date of birth', () {
      final dob = DateTime(DateTime.now().year - 30, 6, 15);
      final d = DependentModel(id: 'd1', firstName: 'Mark', dateOfBirth: dob);
      expect(DependentModel.ageFromDob(dob), d.age);
    });
  });
}
