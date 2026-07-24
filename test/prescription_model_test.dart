import 'package:flutter_test/flutter_test.dart';
import 'package:medalize_mb/features/prescriptions/data/models/prescription_model.dart';

void main() {
  group('PrescriptionItemModel', () {
    test('fromJson parses all fields', () {
      final item = PrescriptionItemModel.fromJson({
        'id': 'i1',
        'drug_name': 'Amoxicillin',
        'dosage': '500mg',
        'frequency': 'Twice a day',
        'duration': '7 days',
        'instructions': 'Take with food',
      });
      expect(item.drugName, 'Amoxicillin');
      expect(item.dosage, '500mg');
      expect(item.frequency, 'Twice a day');
      expect(item.duration, '7 days');
      expect(item.instructions, 'Take with food');
    });

    test('toJson omits the read-only id', () {
      const item = PrescriptionItemModel(id: 'i1', drugName: 'Ibuprofen', dosage: '200mg');
      final json = item.toJson();
      expect(json.containsKey('id'), isFalse);
      expect(json['drug_name'], 'Ibuprofen');
      expect(json['dosage'], '200mg');
    });
  });

  group('PrescriptionModel', () {
    test('fromJson parses nested items and computed names', () {
      final prescription = PrescriptionModel.fromJson({
        'id': 'p1',
        'doctor_name': 'Jane Doe',
        'patient_name': 'John Smith',
        'notes': 'Follow up in 2 weeks',
        'issued_at': '2026-07-01T10:00:00Z',
        'items': [
          {'id': 'i1', 'drug_name': 'Amoxicillin'},
          {'id': 'i2', 'drug_name': 'Paracetamol'},
        ],
      });
      expect(prescription.doctorName, 'Jane Doe');
      expect(prescription.patientName, 'John Smith');
      expect(prescription.items, hasLength(2));
      expect(prescription.items[0].drugName, 'Amoxicillin');
    });

    test('tolerates a missing appointment id', () {
      final prescription = PrescriptionModel.fromJson({
        'id': 'p1',
        'issued_at': '2026-07-01T10:00:00Z',
      });
      expect(prescription.appointmentId, '');
      expect(prescription.items, isEmpty);
    });
  });
}
