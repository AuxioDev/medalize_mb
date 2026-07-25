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
        'is_active': true,
      });
      expect(d.fullName, 'Anna Doe');
      expect(d.relationship, DependentModel.relationshipChild);
      expect(d.dateOfBirth, DateTime(2020, 3, 15));
      expect(d.bloodType, 'O+');
      expect(d.allergies, 'Peanuts');
      expect(d.isActive, isTrue);
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
}
