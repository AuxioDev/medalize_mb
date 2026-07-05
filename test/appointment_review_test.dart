import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medalize_mb/core/theme/app_theme.dart';
import 'package:medalize_mb/features/appointments/data/models/appointment_model.dart';
import 'package:medalize_mb/features/appointments/data/models/review_model.dart';
import 'package:medalize_mb/features/appointments/data/repository/appointment_repository.dart';
import 'package:medalize_mb/features/patient/presentation/screens/appointment_detail_screen.dart';
import 'package:medalize_mb/i18n/strings.g.dart';

/// Records review calls instead of hitting the network.
class _FakeAppointmentRepository extends AppointmentRepository {
  _FakeAppointmentRepository() : super(Dio());

  String? updatedAppointmentId;
  int? updatedRating;
  String? updatedComment;
  String? deletedAppointmentId;

  @override
  Future<ReviewModel> updateReview(
      String appointmentId, int rating, String comment) async {
    updatedAppointmentId = appointmentId;
    updatedRating = rating;
    updatedComment = comment;
    return ReviewModel(
      id: 'r1',
      rating: rating,
      comment: comment,
      patientName: 'John Smith',
      createdAt: DateTime(2030, 1, 1),
      updatedAt: DateTime(2030, 1, 2),
    );
  }

  @override
  Future<void> deleteReview(String appointmentId) async {
    deletedAppointmentId = appointmentId;
  }
}

ReviewModel _review({int rating = 4, String comment = 'Great doctor'}) =>
    ReviewModel(
      id: 'r1',
      rating: rating,
      comment: comment,
      patientName: 'John Smith',
      createdAt: DateTime(2030, 1, 1),
    );

AppointmentModel _completedWithReview({required bool canEditReview}) =>
    AppointmentModel(
      id: 'a1',
      doctor: const AppointmentDoctor(
        id: 'd1',
        firstName: 'Jane',
        lastName: 'Doe',
        specialization: 'cardiologist',
        specializationDisplay: 'Cardiology',
      ),
      patient: const AppointmentPatient(
        id: 'p1',
        firstName: 'John',
        lastName: 'Smith',
      ),
      workplace: const AppointmentWorkplace(
        id: 'w1',
        name: 'City Clinic',
        address: '12 Main St',
        city: 'Baku',
      ),
      startsAt: DateTime(2026, 1, 1, 10, 0),
      endsAt: DateTime(2026, 1, 1, 10, 30),
      status: 'completed',
      reason: '',
      notes: '',
      createdAt: DateTime(2025, 12, 1),
      hasReview: true,
      review: _review(),
      canEditReview: canEditReview,
    );

Widget _app(AppointmentModel appt, _FakeAppointmentRepository repo) =>
    TranslationProvider(
      child: ProviderScope(
        overrides: [appointmentRepositoryProvider.overrideWithValue(repo)],
        child: MaterialApp(
          theme: AppTheme.light,
          home: AppointmentDetailScreen(appointment: appt),
        ),
      ),
    );

/// Lets any snackbar auto-dismiss timers finish so the test can end cleanly.
Future<void> _drainSnackBars(WidgetTester tester) async {
  await tester.pump(const Duration(seconds: 5));
  await tester.pumpAndSettle();
}

/// Pumps the detail screen on a phone-height surface so the review card and
/// its action buttons are on-screen and tappable.
Future<void> _pump(
  WidgetTester tester,
  AppointmentModel appt,
  _FakeAppointmentRepository repo,
) async {
  tester.view.physicalSize = const Size(480, 960);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(_app(appt, repo));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('reviewed appointment shows the review with Edit and Delete '
      'when the edit window is open', (tester) async {
    await _pump(tester, _completedWithReview(canEditReview: true),
        _FakeAppointmentRepository());

    expect(find.text('Your Review'.toUpperCase()), findsOneWidget);
    expect(find.text('Great doctor'), findsOneWidget);
    expect(find.text('Edit'), findsOneWidget);
    expect(find.text('Delete'), findsOneWidget);
    // Already reviewed → no "Leave a Review" call to action.
    expect(find.text('Leave a Review'), findsNothing);
  });

  testWidgets('expired edit window hides Edit but keeps Delete',
      (tester) async {
    await _pump(tester, _completedWithReview(canEditReview: false),
        _FakeAppointmentRepository());

    expect(find.text('Great doctor'), findsOneWidget);
    expect(find.text('Edit'), findsNothing);
    expect(find.text('Delete'), findsOneWidget);
  });

  testWidgets('editing opens a prefilled dialog and submits the update',
      (tester) async {
    final repo = _FakeAppointmentRepository();
    await _pump(tester, _completedWithReview(canEditReview: true), repo);

    await tester.tap(find.text('Edit'));
    await tester.pumpAndSettle();

    expect(find.text('Edit Review'), findsOneWidget);
    // Comment field is prefilled with the current review text.
    expect(find.widgetWithText(TextField, 'Great doctor'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'Even better on revisit');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(repo.updatedAppointmentId, 'a1');
    expect(repo.updatedRating, 4);
    expect(repo.updatedComment, 'Even better on revisit');
    // The card reflects the server's updated copy immediately.
    expect(find.text('Even better on revisit'), findsOneWidget);
    expect(find.text('Review updated.'), findsOneWidget);

    await _drainSnackBars(tester);
  });

  testWidgets('deleting asks for confirmation and returns to the '
      '"leave a review" state', (tester) async {
    final repo = _FakeAppointmentRepository();
    await _pump(tester, _completedWithReview(canEditReview: false), repo);

    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();

    expect(find.text('Delete Review'), findsOneWidget);
    expect(find.text('Are you sure you want to delete your review?'),
        findsOneWidget);

    // Dismissing keeps the review.
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(repo.deletedAppointmentId, isNull);
    expect(find.text('Great doctor'), findsOneWidget);

    // Confirming deletes it.
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete').last);
    await tester.pumpAndSettle();

    expect(repo.deletedAppointmentId, 'a1');
    expect(find.text('Great doctor'), findsNothing);
    // Completed and no longer reviewed → the review CTA is back.
    expect(find.text('Leave a Review'), findsOneWidget);

    await _drainSnackBars(tester);
  });
}
