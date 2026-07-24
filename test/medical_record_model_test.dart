import 'package:flutter_test/flutter_test.dart';
import 'package:medalize_mb/features/records/data/models/medical_record_model.dart';

void main() {
  group('MedicalRecordModel.fromJson', () {
    test('parses the signed file URL and clinical date', () {
      final record = MedicalRecordModel.fromJson({
        'id': 'r1',
        'record_type': 'lab_result',
        'title': 'Blood Panel',
        'file': 'https://res.cloudinary.com/demo/raw/authenticated/records/x.pdf?sig=abc',
        'record_date': '2026-06-15',
        'notes': 'Fasting sample',
        'created_at': '2026-06-16T09:00:00Z',
      });
      expect(record.recordType, 'lab_result');
      expect(record.title, 'Blood Panel');
      expect(record.fileUrl, contains('res.cloudinary.com'));
      expect(record.recordDate, DateTime(2026, 6, 15));
      expect(record.notes, 'Fasting sample');
    });

    test('defaults record_type to other and record_date to null when absent', () {
      final record = MedicalRecordModel.fromJson({
        'id': 'r2',
        'title': 'Untitled',
      });
      expect(record.recordType, MedicalRecordModel.typeOther);
      expect(record.recordDate, isNull);
      expect(record.fileUrl, '');
    });
  });
}
