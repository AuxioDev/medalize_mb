import 'package:flutter_test/flutter_test.dart';
import 'package:medalize_mb/features/appointments/data/models/appointment_model.dart';
import 'package:medalize_mb/features/auth/data/models/login_request.dart';
import 'package:medalize_mb/features/auth/data/models/register_request.dart';
import 'package:medalize_mb/features/auth/data/models/user_model.dart';
import 'package:medalize_mb/features/notifications/data/models/notification_model.dart';

void main() {
  group('UserModel.fromJson', () {
    test('parses a patient with nested profile', () {
      final user = UserModel.fromJson({
        'user_id': 'u1',
        'email': 'patient@test.com',
        'role': 'patient',
        'first_name': 'Jane',
        'last_name': 'Doe',
        'phone': '+994501234567',
        'profile': {'blood_type': 'O+', 'address': 'Baku'},
      });
      expect(user.role, 'patient');
      expect(user.phone, '+994501234567');
      expect(user.patientProfile, isNotNull);
      expect(user.patientProfile!.bloodType, 'O+');
      expect(user.doctorProfile, isNull);
    });

    test('parses a doctor with nested profile', () {
      final user = UserModel.fromJson({
        'user_id': 'd1',
        'email': 'doctor@test.com',
        'role': 'doctor',
        'first_name': 'John',
        'last_name': 'Smith',
        'onboarding_complete': false,
        'profile': {
          'specialization': 'cardiology',
          'specialization_display': 'Cardiology',
          'slot_duration_min': 20,
        },
      });
      expect(user.role, 'doctor');
      expect(user.onboardingComplete, isFalse);
      expect(user.doctorProfile, isNotNull);
      expect(user.doctorProfile!.specialization, 'cardiology');
      expect(user.doctorProfile!.slotDurationMin, 20);
      expect(user.patientProfile, isNull);
    });

    test('applies defaults for missing optional fields', () {
      final user = UserModel.fromJson({
        'user_id': 'u2',
        'email': 'x@test.com',
        'role': 'patient',
      });
      expect(user.firstName, '');
      expect(user.phone, '');
      expect(user.patientProfile, isNull);
    });
  });

  group('Request models toJson', () {
    test('LoginRequest serializes with snake_case keys', () {
      final json = const LoginRequest(
        email: 'a@b.com',
        password: 'Pass1234',
        rememberMe: true,
      ).toJson();
      expect(json, {
        'email': 'a@b.com',
        'password': 'Pass1234',
        'remember_me': true,
      });
    });

    test('RegisterRequest omits phone when empty', () {
      final json = const RegisterRequest(
        email: 'a@b.com',
        password: 'Pass1234',
        passwordConfirm: 'Pass1234',
        role: 'patient',
        firstName: 'Jane',
        lastName: 'Doe',
      ).toJson();
      expect(json.containsKey('phone'), isFalse);
      expect(json['password_confirm'], 'Pass1234');
    });

    test('RegisterRequest includes phone when present', () {
      final json = const RegisterRequest(
        email: 'a@b.com',
        password: 'Pass1234',
        passwordConfirm: 'Pass1234',
        role: 'patient',
        firstName: 'Jane',
        lastName: 'Doe',
        phone: '+994501234567',
      ).toJson();
      expect(json['phone'], '+994501234567');
    });
  });

  group('AppointmentModel', () {
    Map<String, dynamic> appointmentJson({
      String status = 'pending',
      required String startsAt,
    }) =>
        {
          'id': 'a1',
          'doctor': {
            'id': 'd1',
            'first_name': 'John',
            'last_name': 'Smith',
            'specialization': 'cardiology',
            'specialization_display': 'Cardiology',
          },
          'patient': {'id': 'p1', 'first_name': 'Jane', 'last_name': 'Doe'},
          'workplace': {
            'id': 'w1',
            'name': 'Clinic',
            'address': '123 St',
            'city': 'Baku',
          },
          'starts_at': startsAt,
          'ends_at': startsAt,
          'status': status,
          'reason': 'Checkup',
          'notes': '',
          'created_at': '2026-06-01T09:00:00Z',
        };

    test('parses nested doctor/patient/workplace', () {
      final appt = AppointmentModel.fromJson(
        appointmentJson(startsAt: '2099-01-01T10:00:00Z'),
      );
      expect(appt.doctor.fullName, 'John Smith');
      expect(appt.patient.fullName, 'Jane Doe');
      expect(appt.workplace.city, 'Baku');
      expect(appt.status, 'pending');
    });

    test('isUpcoming reflects status', () {
      final pending = AppointmentModel.fromJson(
        appointmentJson(status: 'pending', startsAt: '2099-01-01T10:00:00Z'),
      );
      final completed = AppointmentModel.fromJson(
        appointmentJson(status: 'completed', startsAt: '2099-01-01T10:00:00Z'),
      );
      expect(pending.isUpcoming, isTrue);
      expect(completed.isUpcoming, isFalse);
    });

    test('canCancel is true for a future confirmed appointment', () {
      final appt = AppointmentModel.fromJson(
        appointmentJson(status: 'confirmed', startsAt: '2099-01-01T10:00:00Z'),
      );
      expect(appt.canCancel, isTrue);
    });

    test('canCancel is false within 2 hours', () {
      final soon = DateTime.now()
          .add(const Duration(minutes: 30))
          .toUtc()
          .toIso8601String();
      final appt = AppointmentModel.fromJson(
        appointmentJson(status: 'confirmed', startsAt: soon),
      );
      expect(appt.canCancel, isFalse);
    });

    test('canCancel is false for completed appointments', () {
      final appt = AppointmentModel.fromJson(
        appointmentJson(status: 'completed', startsAt: '2099-01-01T10:00:00Z'),
      );
      expect(appt.canCancel, isFalse);
    });
  });

  group('NotificationModel.fromJson', () {
    test('parses a notification', () {
      final n = NotificationModel.fromJson({
        'id': 'n1',
        'type': 'booking_confirmed',
        'title': 'Confirmed',
        'message': 'Your booking is confirmed',
        'is_read': false,
        'sent_at': '2026-06-01T09:00:00Z',
        'appointment_id': 'a1',
      });
      expect(n.type, 'booking_confirmed');
      expect(n.isRead, isFalse);
      expect(n.appointmentId, 'a1');
    });

    test('tolerates missing optional fields', () {
      final n = NotificationModel.fromJson({
        'id': 'n2',
        'title': 'Hi',
        'message': 'Body',
        'sent_at': '2026-06-01T09:00:00Z',
      });
      expect(n.type, '');
      expect(n.isRead, isFalse);
      expect(n.appointmentId, isNull);
    });
  });
}
