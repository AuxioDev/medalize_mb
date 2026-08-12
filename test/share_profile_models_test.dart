import 'package:flutter_test/flutter_test.dart';
import 'package:medalize_mb/features/doctors/data/models/doctor_model.dart';
import 'package:medalize_mb/features/hospital/data/models/hospital_model.dart';

void main() {
  group('DoctorWorkplace.fromJson', () {
    test('parses a hospital-linked workplace\'s hospital id', () {
      final wp = DoctorWorkplace.fromJson({
        'id': 'w1',
        'name': 'City Clinic',
        'city': 'baku',
        'address': '1 Main St',
        'type': 'hospital',
        'is_primary': true,
        'hospital': 'h1',
      });
      expect(wp.hospitalId, 'h1');
    });

    test('a private-practice workplace has no hospital id', () {
      final wp = DoctorWorkplace.fromJson({
        'id': 'w1',
        'name': 'My Private Office',
        'city': 'baku',
        'address': '1 Main St',
        'type': 'clinic',
        'is_primary': true,
      });
      expect(wp.hospitalId, isNull);
    });
  });

  group('HospitalModel.fromJson', () {
    test('parses the logo url when present', () {
      final hospital = HospitalModel.fromJson({
        'id': 'h1',
        'name': 'City Hospital',
        'city': 'baku',
        'logo': 'https://res.cloudinary.com/demo/logo.png',
      });
      expect(hospital.logoUrl, 'https://res.cloudinary.com/demo/logo.png');
    });

    test('logo url is null when the hospital has none', () {
      final hospital = HospitalModel.fromJson({
        'id': 'h1',
        'name': 'City Hospital',
        'city': 'baku',
      });
      expect(hospital.logoUrl, isNull);
    });
  });
}
