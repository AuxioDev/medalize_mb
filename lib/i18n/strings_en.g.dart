///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations

	/// en: 'Medalize'
	String get appName => 'Medalize';

	late final Translations$common$en common = Translations$common$en.internal(_root);
	late final Translations$auth$en auth = Translations$auth$en.internal(_root);
	late final Translations$forgotPassword$en forgotPassword = Translations$forgotPassword$en.internal(_root);
	late final Translations$resetPassword$en resetPassword = Translations$resetPassword$en.internal(_root);
	late final Translations$validation$en validation = Translations$validation$en.internal(_root);
	late final Translations$errors$en errors = Translations$errors$en.internal(_root);
	late final Translations$settings$en settings = Translations$settings$en.internal(_root);
	late final Translations$security$en security = Translations$security$en.internal(_root);
	late final Translations$status$en status = Translations$status$en.internal(_root);
	late final Translations$home$en home = Translations$home$en.internal(_root);
	late final Translations$appointments$en appointments = Translations$appointments$en.internal(_root);
	late final Translations$booking$en booking = Translations$booking$en.internal(_root);
	late final Translations$doctorSearch$en doctorSearch = Translations$doctorSearch$en.internal(_root);
	late final Translations$doctorDetail$en doctorDetail = Translations$doctorDetail$en.internal(_root);
	late final Translations$profile$en profile = Translations$profile$en.internal(_root);
	late final Translations$notifications$en notifications = Translations$notifications$en.internal(_root);
	late final Translations$workplaces$en workplaces = Translations$workplaces$en.internal(_root);
	late final Translations$addWorkplace$en addWorkplace = Translations$addWorkplace$en.internal(_root);
	late final Translations$workingHours$en workingHours = Translations$workingHours$en.internal(_root);
	late final Translations$blockTime$en blockTime = Translations$blockTime$en.internal(_root);
	late final Translations$onboarding$en onboarding = Translations$onboarding$en.internal(_root);
	late final Translations$pendingVerification$en pendingVerification = Translations$pendingVerification$en.internal(_root);
	late final Translations$phoneField$en phoneField = Translations$phoneField$en.internal(_root);
	late final Translations$splash$en splash = Translations$splash$en.internal(_root);
	late final Translations$appIntro$en appIntro = Translations$appIntro$en.internal(_root);
	late final Translations$agenda$en agenda = Translations$agenda$en.internal(_root);
	late final Translations$favorites$en favorites = Translations$favorites$en.internal(_root);
	late final Translations$assistant$en assistant = Translations$assistant$en.internal(_root);
	late final Translations$legal$en legal = Translations$legal$en.internal(_root);
}

// Path: common
class Translations$common$en {
	Translations$common$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Log Out'
	String get logout => 'Log Out';

	/// en: 'Doctor'
	String get doctor => 'Doctor';

	/// en: 'Patient'
	String get patient => 'Patient';

	/// en: 'Save'
	String get save => 'Save';

	/// en: 'Edit'
	String get edit => 'Edit';

	/// en: 'Retry'
	String get retry => 'Retry';

	/// en: 'Back'
	String get back => 'Back';

	/// en: 'OK'
	String get ok => 'OK';

	/// en: 'Delete'
	String get delete => 'Delete';

	/// en: 'Keep'
	String get keep => 'Keep';

	/// en: 'Confirm'
	String get confirm => 'Confirm';

	/// en: 'Decline'
	String get decline => 'Decline';

	/// en: 'Primary'
	String get primary => 'Primary';

	/// en: 'Something went wrong'
	String get somethingWrong => 'Something went wrong';

	/// en: 'See all'
	String get seeAll => 'See all';

	/// en: 'Sign Out'
	String get signOut => 'Sign Out';

	/// en: 'Search'
	String get search => 'Search';

	/// en: 'Please try again'
	String get tryAgain => 'Please try again';

	/// en: 'Required'
	String get required => 'Required';

	/// en: 'No ratings yet'
	String get noRatings => 'No ratings yet';
}

// Path: auth
class Translations$auth$en {
	Translations$auth$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Sign In'
	String get login => 'Sign In';

	/// en: 'Create Account'
	String get register => 'Create Account';

	/// en: 'Sign In'
	String get signIn => 'Sign In';

	/// en: 'Sign Up'
	String get signUp => 'Sign Up';

	/// en: 'Email'
	String get email => 'Email';

	/// en: 'Password'
	String get password => 'Password';

	/// en: 'Confirm Password'
	String get confirmPassword => 'Confirm Password';

	/// en: 'First Name'
	String get firstName => 'First Name';

	/// en: 'Last Name'
	String get lastName => 'Last Name';

	/// en: 'Remember me'
	String get rememberMe => 'Remember me';

	/// en: 'Forgot password?'
	String get forgotPassword => 'Forgot password?';

	/// en: 'Send Reset Code'
	String get sendResetLink => 'Send Reset Code';

	/// en: 'Don't have an account?'
	String get noAccount => 'Don\'t have an account?';

	/// en: 'Already have an account?'
	String get haveAccount => 'Already have an account?';

	/// en: 'Welcome back'
	String get welcomeBack => 'Welcome back';

	/// en: 'Sign in to your account to continue'
	String get signInToContinue => 'Sign in to your account to continue';

	/// en: 'Create your account'
	String get createYourAccount => 'Create your account';

	/// en: 'Join Medalize today'
	String get joinMedalize => 'Join Medalize today';

	/// en: 'I am a'
	String get iAmA => 'I am a';

	/// en: 'you@example.com'
	String get emailHint => 'you@example.com';

	/// en: '••••••••'
	String get passwordHint => '••••••••';

	/// en: 'Back to Sign In'
	String get backToSignIn => 'Back to Sign In';

	/// en: 'Verification code'
	String get verificationCode => 'Verification code';

	/// en: 'Continue with Google'
	String get continueWithGoogle => 'Continue with Google';

	/// en: 'Continue with Apple'
	String get continueWithApple => 'Continue with Apple';

	/// en: 'or'
	String get orDivider => 'or';
}

// Path: forgotPassword
class Translations$forgotPassword$en {
	Translations$forgotPassword$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Forgot Password?'
	String get title => 'Forgot Password?';

	/// en: 'Enter your email and we'll send you a 6-digit reset code'
	String get subtitle => 'Enter your email and we\'ll send you a 6-digit reset code';
}

// Path: resetPassword
class Translations$resetPassword$en {
	Translations$resetPassword$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Reset Password'
	String get title => 'Reset Password';

	/// en: 'Enter the code sent to your email and choose a new password'
	String get subtitle => 'Enter the code sent to your email and choose a new password';

	/// en: 'Reset Password'
	String get button => 'Reset Password';

	/// en: 'Password reset successfully. Please sign in.'
	String get success => 'Password reset successfully. Please sign in.';
}

// Path: validation
class Translations$validation$en {
	Translations$validation$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Email is required'
	String get emailRequired => 'Email is required';

	/// en: 'Enter a valid email address'
	String get emailInvalid => 'Enter a valid email address';

	/// en: 'Password is required'
	String get passwordRequired => 'Password is required';

	/// en: 'At least 8 characters required'
	String get passwordTooShort => 'At least 8 characters required';

	/// en: 'Include at least one letter'
	String get passwordNeedsLetter => 'Include at least one letter';

	/// en: 'Include at least one digit'
	String get passwordNeedsDigit => 'Include at least one digit';

	/// en: 'Passwords do not match'
	String get passwordMismatch => 'Passwords do not match';

	/// en: 'Please confirm your password'
	String get passwordConfirmRequired => 'Please confirm your password';

	/// en: 'Must be at least 2 characters'
	String get nameMinLength => 'Must be at least 2 characters';

	/// en: 'Please select a role'
	String get roleRequired => 'Please select a role';

	/// en: 'Phone number is required'
	String get phoneRequired => 'Phone number is required';

	/// en: 'Number is too short'
	String get phoneTooShort => 'Number is too short';

	/// en: 'Number is too long'
	String get phoneTooLong => 'Number is too long';

	/// en: '$field is required'
	String fieldRequired({required Object field}) => '${field} is required';

	/// en: '$field contains invalid characters'
	String fieldInvalid({required Object field}) => '${field} contains invalid characters';
}

// Path: errors
class Translations$errors$en {
	Translations$errors$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Network error. Check your connection.'
	String get network => 'Network error. Check your connection.';

	/// en: 'Too many attempts. Please wait and try again.'
	String get rateLimit => 'Too many attempts. Please wait and try again.';

	/// en: 'Too many attempts. Try again in $seconds s.'
	String rateLimitWithSeconds({required Object seconds}) => 'Too many attempts. Try again in ${seconds} s.';

	/// en: 'Invalid email or password'
	String get invalidCredentials => 'Invalid email or password';

	/// en: 'Session expired. Please sign in again.'
	String get sessionExpired => 'Session expired. Please sign in again.';

	/// en: 'Authentication error. Please sign in again.'
	String get authError => 'Authentication error. Please sign in again.';

	/// en: 'Session was revoked. Please sign in again.'
	String get sessionRevoked => 'Session was revoked. Please sign in again.';

	/// en: 'You do not have permission to do this.'
	String get permissionDenied => 'You do not have permission to do this.';

	/// en: 'Validation error'
	String get validationError => 'Validation error';

	/// en: 'Server error ($code). Please try again.'
	String serverError({required Object code}) => 'Server error (${code}). Please try again.';

	/// en: 'Sign-in failed. Please try again or use your email and password.'
	String get socialLoginFailed => 'Sign-in failed. Please try again or use your email and password.';
}

// Path: settings
class Translations$settings$en {
	Translations$settings$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Settings'
	String get title => 'Settings';

	/// en: 'Account'
	String get account => 'Account';

	/// en: 'Profile'
	String get profile => 'Profile';

	/// en: 'Notifications'
	String get notifications => 'Notifications';

	/// en: 'Appearance'
	String get appearance => 'Appearance';

	/// en: 'System'
	String get themeSystem => 'System';

	/// en: 'Light'
	String get themeLight => 'Light';

	/// en: 'Dark'
	String get themeDark => 'Dark';

	/// en: 'Language'
	String get language => 'Language';

	/// en: 'System default'
	String get languageSystem => 'System default';

	/// en: 'Logout'
	String get logoutTitle => 'Logout';

	/// en: 'Are you sure you want to logout?'
	String get logoutConfirm => 'Are you sure you want to logout?';

	/// en: 'Medalize v1.0.0'
	String get version => 'Medalize v1.0.0';

	/// en: 'Privacy & Terms'
	String get legal => 'Privacy & Terms';
}

// Path: security
class Translations$security$en {
	Translations$security$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Security'
	String get title => 'Security';

	/// en: 'Biometric Login'
	String get biometricLogin => 'Biometric Login';

	/// en: 'Use Face ID / Touch ID to unlock the app'
	String get biometricLoginSubtitle => 'Use Face ID / Touch ID to unlock the app';

	/// en: 'Authenticate to access Medalize'
	String get biometricPrompt => 'Authenticate to access Medalize';

	/// en: 'Biometric authentication isn't available on this device'
	String get biometricUnavailable => 'Biometric authentication isn\'t available on this device';

	/// en: 'Couldn't verify your biometrics. Please try again.'
	String get biometricEnableFailed => 'Couldn\'t verify your biometrics. Please try again.';

	/// en: 'Active Sessions'
	String get activeSessions => 'Active Sessions';

	/// en: 'Devices currently signed in to your account'
	String get activeSessionsSubtitle => 'Devices currently signed in to your account';

	/// en: 'This device'
	String get thisDevice => 'This device';

	/// en: 'Last active $date'
	String lastActive({required Object date}) => 'Last active ${date}';

	/// en: 'Revoke'
	String get revoke => 'Revoke';

	/// en: 'Revoke device?'
	String get revokeConfirmTitle => 'Revoke device?';

	/// en: '$name will be signed out. It can sign in again with your account credentials.'
	String revokeConfirmMessage({required Object name}) => '${name} will be signed out. It can sign in again with your account credentials.';

	/// en: 'This is your current device — revoking it will sign you out immediately.'
	String get revokeCurrentConfirmMessage => 'This is your current device — revoking it will sign you out immediately.';

	/// en: 'Couldn't revoke this device. Please try again.'
	String get revokeFailed => 'Couldn\'t revoke this device. Please try again.';

	/// en: 'Sign out of all devices'
	String get signOutAllDevices => 'Sign out of all devices';

	/// en: 'Sign out everywhere?'
	String get signOutAllConfirmTitle => 'Sign out everywhere?';

	/// en: 'You will be signed out on every device, including this one.'
	String get signOutAllConfirmMessage => 'You will be signed out on every device, including this one.';

	/// en: 'Couldn't sign out of all devices. Please try again.'
	String get signOutAllFailed => 'Couldn\'t sign out of all devices. Please try again.';

	/// en: 'No active sessions found'
	String get noDevices => 'No active sessions found';

	/// en: 'Couldn't load your active sessions'
	String get loadFailed => 'Couldn\'t load your active sessions';

	/// en: 'Change Email'
	String get changeEmail => 'Change Email';

	/// en: 'We'll send a verification code to your new email address. After confirming, you'll sign in with the new email.'
	String get changeEmailSubtitle => 'We\'ll send a verification code to your new email address. After confirming, you\'ll sign in with the new email.';

	/// en: 'New email'
	String get newEmailLabel => 'New email';

	/// en: 'Send Code'
	String get sendCode => 'Send Code';

	/// en: 'Enter the 6-digit code we sent to $email'
	String codeSentTo({required Object email}) => 'Enter the 6-digit code we sent to ${email}';

	/// en: 'Confirm New Email'
	String get confirmNewEmail => 'Confirm New Email';

	/// en: 'Your email has been changed. Please sign in again with your new email.'
	String get changeEmailSuccess => 'Your email has been changed. Please sign in again with your new email.';

	/// en: 'Danger Zone'
	String get dangerZone => 'Danger Zone';

	/// en: 'Deactivate Account'
	String get deactivateAccount => 'Deactivate Account';

	/// en: 'Disable your account without deleting your data'
	String get deactivateAccountSubtitle => 'Disable your account without deleting your data';

	/// en: 'Deactivate account?'
	String get deactivateConfirmTitle => 'Deactivate account?';

	/// en: 'Your account will be deactivated and you will be signed out on all devices. Your data will not be deleted. Contact support to reactivate your account.'
	String get deactivateConfirmMessage => 'Your account will be deactivated and you will be signed out on all devices. Your data will not be deleted. Contact support to reactivate your account.';

	/// en: 'Deactivate'
	String get deactivate => 'Deactivate';

	/// en: 'Your account has been deactivated.'
	String get deactivateSuccess => 'Your account has been deactivated.';
}

// Path: status
class Translations$status$en {
	Translations$status$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Confirmed'
	String get confirmed => 'Confirmed';

	/// en: 'Pending'
	String get pending => 'Pending';

	/// en: 'Cancelled'
	String get cancelled => 'Cancelled';

	/// en: 'Declined'
	String get declined => 'Declined';

	/// en: 'Requires Rescheduling'
	String get requiresRescheduling => 'Requires Rescheduling';

	/// en: 'Completed'
	String get completed => 'Completed';

	/// en: 'No-show'
	String get noShow => 'No-show';
}

// Path: home
class Translations$home$en {
	Translations$home$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Hello, Dr. $name!'
	String helloDoctor({required Object name}) => 'Hello, Dr. ${name}!';

	/// en: 'Hello, $name!'
	String helloPatient({required Object name}) => 'Hello, ${name}!';

	/// en: 'Manage your schedule and appointments.'
	String get doctorSubtitle => 'Manage your schedule\nand appointments.';

	/// en: 'Find a doctor and book an appointment.'
	String get patientSubtitle => 'Find a doctor and\nbook an appointment.';

	/// en: 'Pending Requests'
	String get pendingRequests => 'Pending Requests';

	/// en: 'Upcoming'
	String get upcoming => 'Upcoming';

	/// en: 'Find Doctor'
	String get findDoctor => 'Find Doctor';

	/// en: 'AI Assistant'
	String get aiAssistant => 'AI Assistant';

	/// en: 'My Appointments'
	String get myAppointments => 'My Appointments';

	/// en: 'Appointments'
	String get appointments => 'Appointments';

	/// en: 'Workplaces'
	String get workplaces => 'Workplaces';

	/// en: 'Block Time'
	String get blockTime => 'Block Time';

	/// en: 'Profile'
	String get profile => 'Profile';

	/// en: 'All caught up'
	String get allCaughtUp => 'All caught up';

	/// en: 'No pending appointment requests'
	String get noPendingRequests => 'No pending appointment requests';

	/// en: 'Could not load appointments'
	String get couldNotLoadAppointments => 'Could not load appointments';

	/// en: 'No upcoming appointments'
	String get noUpcoming => 'No upcoming appointments';

	/// en: 'Book your first appointment with a doctor'
	String get bookFirst => 'Book your first appointment with a doctor';

	/// en: 'Find a Doctor'
	String get findADoctor => 'Find a Doctor';

	/// en: 'My Waitlist'
	String get myWaitlist => 'My Waitlist';

	/// en: 'Leave'
	String get leaveWaitlist => 'Leave';

	/// en: 'This month'
	String get statsThisMonth => 'This month';

	/// en: 'Patients'
	String get statsPatients => 'Patients';

	/// en: 'Accept rate'
	String get statsAcceptRate => 'Accept rate';

	/// en: 'Pending'
	String get statsPending => 'Pending';

	/// en: 'Schedule'
	String get schedule => 'Schedule';
}

// Path: appointments
class Translations$appointments$en {
	Translations$appointments$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Appointments'
	String get title => 'Appointments';

	/// en: 'My Appointments'
	String get myTitle => 'My Appointments';

	/// en: 'Pending'
	String get tabPending => 'Pending';

	/// en: 'All'
	String get tabAll => 'All';

	/// en: 'Upcoming'
	String get tabUpcoming => 'Upcoming';

	/// en: 'Past'
	String get tabPast => 'Past';

	/// en: 'No pending requests'
	String get noPendingRequests => 'No pending requests';

	/// en: 'New appointment requests will appear here'
	String get newRequestsAppear => 'New appointment requests will appear here';

	/// en: 'No appointments'
	String get noAppointments => 'No appointments';

	/// en: 'Your appointments will appear here'
	String get appointmentsAppear => 'Your appointments will appear here';

	/// en: 'No upcoming appointments'
	String get noUpcoming => 'No upcoming appointments';

	/// en: 'Book your first appointment with a doctor'
	String get bookFirst => 'Book your first appointment with a doctor';

	/// en: 'No past appointments'
	String get noPast => 'No past appointments';

	/// en: 'Completed and cancelled appointments appear here'
	String get pastAppear => 'Completed and cancelled appointments appear here';

	/// en: 'Could not load appointments'
	String get couldNotLoad => 'Could not load appointments';

	/// en: 'Appointment'
	String get detailTitle => 'Appointment';

	/// en: 'Patient'
	String get patient => 'Patient';

	/// en: 'Doctor'
	String get doctor => 'Doctor';

	/// en: 'Workplace'
	String get workplace => 'Workplace';

	/// en: 'Date & Time'
	String get dateTime => 'Date & Time';

	/// en: 'Reason'
	String get reason => 'Reason';

	/// en: 'Doctor Notes'
	String get doctorNotes => 'Doctor Notes';

	/// en: 'Cancel Appointment'
	String get cancelTitle => 'Cancel Appointment';

	/// en: 'Are you sure you want to cancel this appointment?'
	String get cancelConfirm => 'Are you sure you want to cancel this appointment?';

	/// en: 'Cancel Appointment'
	String get cancelAction => 'Cancel Appointment';

	/// en: 'Booked!'
	String get bookedTitle => 'Booked!';

	/// en: 'Your appointment request has been sent.'
	String get bookedMessage => 'Your appointment request has been sent.';

	/// en: 'Reschedule'
	String get reschedule => 'Reschedule';

	/// en: 'Reschedule Appointment'
	String get rescheduleTitle => 'Reschedule Appointment';

	/// en: 'Leave a Review'
	String get reviewTitle => 'Leave a Review';

	/// en: 'Rating'
	String get reviewRating => 'Rating';

	/// en: 'Comment (optional)'
	String get reviewComment => 'Comment (optional)';

	/// en: 'Submit'
	String get reviewSubmit => 'Submit';

	/// en: 'Mark as Completed'
	String get markCompleted => 'Mark as Completed';

	/// en: 'Appointment rescheduled successfully.'
	String get rescheduledSuccess => 'Appointment rescheduled successfully.';

	/// en: 'Review submitted. Thank you!'
	String get reviewSubmitted => 'Review submitted. Thank you!';

	/// en: 'Your Review'
	String get yourReview => 'Your Review';

	/// en: 'Edit Review'
	String get editReviewTitle => 'Edit Review';

	/// en: 'Review updated.'
	String get reviewUpdated => 'Review updated.';

	/// en: 'Delete Review'
	String get deleteReviewTitle => 'Delete Review';

	/// en: 'Are you sure you want to delete your review?'
	String get deleteReviewConfirm => 'Are you sure you want to delete your review?';

	/// en: 'Review deleted.'
	String get reviewDeleted => 'Review deleted.';

	/// en: 'Request Reschedule'
	String get requestReschedule => 'Request Reschedule';

	/// en: 'Request Reschedule'
	String get requestRescheduleTitle => 'Request Reschedule';

	/// en: 'Ask the patient to pick a new time? The appointment will be marked as needing rescheduling.'
	String get requestRescheduleConfirm => 'Ask the patient to pick a new time? The appointment will be marked as needing rescheduling.';

	/// en: 'Reschedule requested. The patient will be notified.'
	String get requestRescheduleSuccess => 'Reschedule requested. The patient will be notified.';

	/// en: 'The doctor asked you to choose a new time.'
	String get rescheduleNeededHint => 'The doctor asked you to choose a new time.';

	/// en: 'Mark No-show'
	String get markNoShow => 'Mark No-show';

	/// en: 'Mark as No-show'
	String get markNoShowTitle => 'Mark as No-show';

	/// en: 'Mark this appointment as a no-show? This records that the patient did not attend.'
	String get markNoShowConfirm => 'Mark this appointment as a no-show? This records that the patient did not attend.';
}

// Path: booking
class Translations$booking$en {
	Translations$booking$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Book — $name'
	String bookWith({required Object name}) => 'Book — ${name}';

	/// en: 'Select Workplace'
	String get selectWorkplace => 'Select Workplace';

	/// en: 'Pick a date'
	String get pickDate => 'Pick a date';

	/// en: 'Available time slots will appear here'
	String get slotsAppear => 'Available time slots will appear here';

	/// en: 'Could not load slots'
	String get couldNotLoadSlots => 'Could not load slots';

	/// en: 'No available slots'
	String get noAvailableSlots => 'No available slots';

	/// en: 'No open slots for this date. Try another day.'
	String get noOpenSlots => 'No open slots for this date. Try another day.';

	/// en: 'Confirm Booking'
	String get confirmTitle => 'Confirm Booking';

	/// en: 'Reason for visit (optional)'
	String get reasonForVisit => 'Reason for visit (optional)';

	/// en: 'Confirm Booking'
	String get confirmButton => 'Confirm Booking';

	/// en: 'Doctor'
	String get doctorLabel => 'Doctor';

	/// en: 'Workplace'
	String get workplaceLabel => 'Workplace';

	/// en: 'Address'
	String get addressLabel => 'Address';

	/// en: 'Start'
	String get startLabel => 'Start';

	/// en: 'End'
	String get endLabel => 'End';

	/// en: 'Try a different date'
	String get tryDifferentDate => 'Try a different date';
}

// Path: doctorSearch
class Translations$doctorSearch$en {
	Translations$doctorSearch$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Find a Doctor'
	String get title => 'Find a Doctor';

	/// en: 'Search by name...'
	String get searchByName => 'Search by name...';

	/// en: 'City'
	String get city => 'City';

	/// en: 'Search'
	String get search => 'Search';

	/// en: 'No doctors found'
	String get noDoctorsFound => 'No doctors found';

	/// en: 'Try adjusting your search or filters'
	String get adjustSearch => 'Try adjusting your search or filters';

	/// en: 'Could not load doctors'
	String get couldNotLoadDoctors => 'Could not load doctors';

	late final Translations$doctorSearch$spec$en spec = Translations$doctorSearch$spec$en.internal(_root);

	/// en: 'No availability'
	String get noAvailability => 'No availability';

	/// en: 'Available today'
	String get availableToday => 'Available today';

	/// en: 'Available tomorrow'
	String get availableTomorrow => 'Available tomorrow';

	/// en: 'Available $date'
	String availableOn({required Object date}) => 'Available ${date}';

	/// en: 'Sort by'
	String get sortBy => 'Sort by';

	/// en: 'Relevance'
	String get sortDefault => 'Relevance';

	/// en: 'Top rated'
	String get sortRating => 'Top rated';

	/// en: 'Lowest price'
	String get sortPriceLow => 'Lowest price';

	/// en: 'Name (A–Z)'
	String get sortName => 'Name (A–Z)';

	/// en: 'Earliest available'
	String get sortNearestSlot => 'Earliest available';

	/// en: 'Nearest to me'
	String get sortDistance => 'Nearest to me';

	/// en: 'Location permission is needed to sort by distance. Allow it in Settings, or filter by city instead.'
	String get locationDenied => 'Location permission is needed to sort by distance. Allow it in Settings, or filter by city instead.';

	/// en: 'Couldn't get your location. Check that location services are on, or filter by city instead.'
	String get locationUnavailable => 'Couldn\'t get your location. Check that location services are on, or filter by city instead.';

	/// en: '$km km'
	String distanceKm({required Object km}) => '${km} km';
}

// Path: doctorDetail
class Translations$doctorDetail$en {
	Translations$doctorDetail$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Doctor Profile'
	String get profileTitle => 'Doctor Profile';

	/// en: 'Could not load profile'
	String get couldNotLoadProfile => 'Could not load profile';

	/// en: 'About'
	String get about => 'About';

	/// en: 'Workplaces'
	String get workplaces => 'Workplaces';

	/// en: '$min min per slot'
	String minPerSlot({required Object min}) => '${min} min per slot';

	/// en: 'Book Appointment'
	String get bookAppointment => 'Book Appointment';

	/// en: 'Consultation fee'
	String get consultationFee => 'Consultation fee';

	/// en: 'Reviews'
	String get reviews => 'Reviews';

	/// en: '$count reviews'
	String reviewsCount({required Object count}) => '${count} reviews';

	/// en: 'Join waitlist'
	String get joinWaitlist => 'Join waitlist';

	/// en: 'Leave waitlist'
	String get leaveWaitlist => 'Leave waitlist';
}

// Path: profile
class Translations$profile$en {
	Translations$profile$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Profile'
	String get title => 'Profile';

	/// en: 'Change Password'
	String get changePassword => 'Change Password';

	/// en: 'Current Password'
	String get currentPassword => 'Current Password';

	/// en: 'New Password'
	String get newPassword => 'New Password';

	/// en: 'Confirm New Password'
	String get confirmNewPassword => 'Confirm New Password';

	/// en: 'First Name'
	String get firstName => 'First Name';

	/// en: 'Last Name'
	String get lastName => 'Last Name';

	/// en: 'Phone'
	String get phone => 'Phone';

	/// en: 'Failed to save profile.'
	String get failedToSave => 'Failed to save profile.';

	/// en: 'Professional Info'
	String get professionalInfo => 'Professional Info';

	/// en: 'Bio'
	String get bio => 'Bio';

	/// en: 'Short description of your experience'
	String get bioHint => 'Short description of your experience';

	/// en: 'Consultation fee'
	String get consultationFee => 'Consultation fee';

	/// en: 'Medical Information'
	String get medicalInfo => 'Medical Information';

	/// en: 'Allergies'
	String get allergies => 'Allergies';

	/// en: 'e.g. Penicillin, peanuts'
	String get allergiesHint => 'e.g. Penicillin, peanuts';

	/// en: 'Chronic conditions'
	String get chronicConditions => 'Chronic conditions';

	/// en: 'e.g. Diabetes, hypertension'
	String get chronicConditionsHint => 'e.g. Diabetes, hypertension';

	/// en: 'Current medications'
	String get medications => 'Current medications';

	/// en: 'e.g. Metformin 500mg'
	String get medicationsHint => 'e.g. Metformin 500mg';

	/// en: 'Appointment length'
	String get appointmentLength => 'Appointment length';

	/// en: 'Cancellation window'
	String get cancellationWindow => 'Cancellation window';

	/// en: 'How long before an appointment patients can still cancel or reschedule.'
	String get cancellationWindowHint => 'How long before an appointment patients can still cancel or reschedule.';

	/// en: '$h h'
	String hoursValue({required Object h}) => '${h} h';
}

// Path: notifications
class Translations$notifications$en {
	Translations$notifications$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Notifications'
	String get title => 'Notifications';

	/// en: 'No notifications'
	String get noNotifications => 'No notifications';

	/// en: 'You are all caught up'
	String get allCaughtUp => 'You are all caught up';

	/// en: 'Could not load notifications'
	String get couldNotLoad => 'Could not load notifications';

	/// en: 'Mark all read'
	String get markAllRead => 'Mark all read';

	/// en: 'Notification settings'
	String get settingsTitle => 'Notification settings';

	/// en: 'Push notifications'
	String get pushEnabled => 'Push notifications';

	/// en: 'Alerts on this device for bookings and updates'
	String get pushEnabledSubtitle => 'Alerts on this device for bookings and updates';

	/// en: 'Email notifications'
	String get emailEnabled => 'Email notifications';

	/// en: 'Updates sent to your email address'
	String get emailEnabledSubtitle => 'Updates sent to your email address';
}

// Path: workplaces
class Translations$workplaces$en {
	Translations$workplaces$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'My Workplaces'
	String get title => 'My Workplaces';

	/// en: 'No workplaces yet'
	String get noWorkplacesYet => 'No workplaces yet';

	/// en: 'Tap + to add your first workplace'
	String get tapToAdd => 'Tap + to add your first workplace';

	/// en: 'Could not load workplaces'
	String get couldNotLoad => 'Could not load workplaces';

	/// en: 'Delete Workplace'
	String get deleteTitle => 'Delete Workplace';

	/// en: 'Delete "$name"?'
	String deleteConfirm({required Object name}) => 'Delete "${name}"?';

	/// en: 'Cannot delete workplace'
	String get cannotDelete => 'Cannot delete workplace';

	/// en: 'Working Hours'
	String get workingHours => 'Working Hours';

	/// en: 'Set as Primary'
	String get setAsPrimary => 'Set as Primary';
}

// Path: addWorkplace
class Translations$addWorkplace$en {
	Translations$addWorkplace$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Add Workplace'
	String get addTitle => 'Add Workplace';

	/// en: 'Edit Workplace'
	String get editTitle => 'Edit Workplace';

	/// en: 'Name'
	String get name => 'Name';

	/// en: 'Address'
	String get address => 'Address';

	/// en: 'City'
	String get city => 'City';

	/// en: 'Type'
	String get type => 'Type';

	/// en: 'Clinic'
	String get clinic => 'Clinic';

	/// en: 'Hospital'
	String get hospital => 'Hospital';

	/// en: 'Private Practice'
	String get privatePractice => 'Private Practice';

	/// en: 'Failed to save workplace.'
	String get failedToSave => 'Failed to save workplace.';

	/// en: 'Add Workplace'
	String get addButton => 'Add Workplace';

	/// en: 'Save Changes'
	String get saveChanges => 'Save Changes';
}

// Path: workingHours
class Translations$workingHours$en {
	Translations$workingHours$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Working Hours'
	String get title => 'Working Hours';

	/// en: 'Working hours saved'
	String get saved => 'Working hours saved';

	/// en: 'Failed to save working hours'
	String get failedToSave => 'Failed to save working hours';

	late final Translations$workingHours$days$en days = Translations$workingHours$days$en.internal(_root);
}

// Path: blockTime
class Translations$blockTime$en {
	Translations$blockTime$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Block Time'
	String get title => 'Block Time';

	/// en: 'Date Range'
	String get dateRange => 'Date Range';

	/// en: 'Tap to select dates'
	String get tapToSelect => 'Tap to select dates';

	/// en: 'Reason (optional)'
	String get reason => 'Reason (optional)';

	/// en: 'Notify affected patients'
	String get notifyPatients => 'Notify affected patients';

	/// en: 'Send notifications to patients with appointments in this period'
	String get notifyDesc => 'Send notifications to patients with appointments in this period';

	/// en: 'Please select a date range.'
	String get selectDateRange => 'Please select a date range.';

	/// en: 'Failed to block time. Please try again.'
	String get failedToBlock => 'Failed to block time. Please try again.';

	/// en: 'Block Period'
	String get blockButton => 'Block Period';
}

// Path: onboarding
class Translations$onboarding$en {
	Translations$onboarding$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Complete Your Profile'
	String get title => 'Complete Your Profile';

	/// en: 'Professional information'
	String get professionalInfo => 'Professional information';

	/// en: 'Tell patients about your practice.'
	String get tellPatients => 'Tell patients about your practice.';

	/// en: 'Specialization'
	String get specialization => 'Specialization';

	/// en: 'Select your specialization'
	String get selectSpecialization => 'Select your specialization';

	/// en: 'Could not load specializations. Pull back and retry.'
	String get couldNotLoadSpecs => 'Could not load specializations. Pull back and retry.';

	/// en: 'License number'
	String get licenseNumber => 'License number';

	/// en: 'e.g. AZ-123456'
	String get licenseHint => 'e.g. AZ-123456';

	/// en: 'Bio (optional)'
	String get bio => 'Bio (optional)';

	/// en: 'A short introduction patients will see on your profile.'
	String get bioHint => 'A short introduction patients will see on your profile.';

	/// en: 'Appointment length'
	String get appointmentLength => 'Appointment length';

	/// en: 'How long is a single appointment slot?'
	String get slotQuestion => 'How long is a single appointment slot?';

	/// en: 'You can change this later from your profile.'
	String get changeLater => 'You can change this later from your profile.';

	/// en: '$min min'
	String minutes({required Object min}) => '${min} min';

	/// en: 'Verification document'
	String get verificationDoc => 'Verification document';

	/// en: 'Upload your medical diploma or license. An admin reviews it before your account is verified.'
	String get uploadDiploma => 'Upload your medical diploma or license. An admin reviews it before your account is verified.';

	/// en: 'Tap to choose a file'
	String get tapToChoose => 'Tap to choose a file';

	/// en: 'Tap to replace'
	String get tapToReplace => 'Tap to replace';

	/// en: 'Any file type, up to 10 MB'
	String get anyFileType => 'Any file type, up to 10 MB';

	/// en: 'Please select your specialization.'
	String get selectSpecError => 'Please select your specialization.';

	/// en: 'Please enter your license number.'
	String get licenseError => 'Please enter your license number.';

	/// en: 'Please attach your diploma.'
	String get diplomaError => 'Please attach your diploma.';

	/// en: 'Please check your details and try again.'
	String get checkDetails => 'Please check your details and try again.';

	/// en: 'Continue'
	String get continueButton => 'Continue';

	/// en: 'Finish'
	String get finish => 'Finish';
}

// Path: pendingVerification
class Translations$pendingVerification$en {
	Translations$pendingVerification$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Verification Pending'
	String get title => 'Verification Pending';

	/// en: 'Your account is under review. We will notify you once it is verified.'
	String get message => 'Your account is under review. We will notify you once it is verified.';

	/// en: 'Check Status'
	String get checkStatus => 'Check Status';

	/// en: 'Still under review. We'll notify you once it's verified.'
	String get stillPending => 'Still under review. We\'ll notify you once it\'s verified.';
}

// Path: phoneField
class Translations$phoneField$en {
	Translations$phoneField$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Phone Number'
	String get label => 'Phone Number';

	/// en: 'Phone Number (Optional)'
	String get labelOptional => 'Phone Number (Optional)';

	/// en: 'Select Country'
	String get selectCountry => 'Select Country';

	/// en: 'Search country or code…'
	String get searchCountry => 'Search country or code…';

	/// en: 'No countries found'
	String get noCountriesFound => 'No countries found';
}

// Path: splash
class Translations$splash$en {
	Translations$splash$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Your health, simplified'
	String get tagline => 'Your health, simplified';
}

// Path: appIntro
class Translations$appIntro$en {
	Translations$appIntro$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Find the right doctor'
	String get page1Title => 'Find the right doctor';

	/// en: 'Search by specialty, city, and rating — then book a time that works for you.'
	String get page1Subtitle => 'Search by specialty, city, and rating — then book a time that works for you.';

	/// en: 'Ask our AI health assistant'
	String get page2Title => 'Ask our AI health assistant';

	/// en: 'Describe your symptoms and get pointed toward the right specialist, any time.'
	String get page2Subtitle => 'Describe your symptoms and get pointed toward the right specialist, any time.';

	/// en: 'Everything in one place'
	String get page3Title => 'Everything in one place';

	/// en: 'Manage appointments, track your care, and use the app in your language — safely and securely.'
	String get page3Subtitle => 'Manage appointments, track your care, and use the app in your language — safely and securely.';

	/// en: 'Skip'
	String get skip => 'Skip';

	/// en: 'Next'
	String get next => 'Next';

	/// en: 'Get Started'
	String get getStarted => 'Get Started';
}

// Path: agenda
class Translations$agenda$en {
	Translations$agenda$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Schedule'
	String get title => 'Schedule';

	/// en: 'Today'
	String get today => 'Today';

	/// en: 'No appointments'
	String get empty => 'No appointments';

	/// en: 'Nothing scheduled for this day'
	String get emptySubtitle => 'Nothing scheduled for this day';
}

// Path: favorites
class Translations$favorites$en {
	Translations$favorites$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Favorites'
	String get title => 'Favorites';

	/// en: 'No favorites yet'
	String get empty => 'No favorites yet';

	/// en: 'Tap the heart on a doctor to save them here'
	String get emptySubtitle => 'Tap the heart on a doctor to save them here';

	/// en: 'Add to favorites'
	String get add => 'Add to favorites';

	/// en: 'Remove from favorites'
	String get remove => 'Remove from favorites';
}

// Path: assistant
class Translations$assistant$en {
	Translations$assistant$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'AI Assistant'
	String get title => 'AI Assistant';

	/// en: 'New Chat'
	String get newChat => 'New Chat';

	/// en: 'No conversations yet'
	String get empty => 'No conversations yet';

	/// en: 'Describe your symptoms and the assistant will suggest which doctor to see'
	String get emptySubtitle => 'Describe your symptoms and the assistant will suggest which doctor to see';

	/// en: 'Could not load conversations'
	String get couldNotLoad => 'Could not load conversations';

	/// en: 'Could not load this conversation'
	String get couldNotLoadChat => 'Could not load this conversation';

	/// en: 'New conversation'
	String get newConversation => 'New conversation';

	/// en: 'Delete conversation?'
	String get deleteTitle => 'Delete conversation?';

	/// en: 'This conversation and all its messages will be deleted.'
	String get deleteConfirm => 'This conversation and all its messages will be deleted.';

	/// en: 'Describe your symptoms…'
	String get inputHint => 'Describe your symptoms…';

	/// en: 'Send'
	String get send => 'Send';

	/// en: 'Message could not be sent. Please try again.'
	String get sendFailed => 'Message could not be sent. Please try again.';

	/// en: 'Assistant is typing…'
	String get typing => 'Assistant is typing…';

	/// en: 'How can I help?'
	String get startTitle => 'How can I help?';

	/// en: 'Describe what is bothering you to get started'
	String get startSubtitle => 'Describe what is bothering you to get started';

	/// en: 'Book'
	String get book => 'Book';

	/// en: 'Report this response'
	String get reportTooltip => 'Report this response';

	/// en: 'Report response'
	String get reportTitle => 'Report response';

	/// en: 'Reason (optional)'
	String get reportHint => 'Reason (optional)';

	/// en: 'Report'
	String get reportSubmit => 'Report';

	/// en: 'Thank you, the response was reported.'
	String get reportSuccess => 'Thank you, the response was reported.';

	/// en: 'Could not report the response. Please try again.'
	String get reportFailed => 'Could not report the response. Please try again.';
}

// Path: legal
class Translations$legal$en {
	Translations$legal$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Privacy & Terms'
	String get title => 'Privacy & Terms';

	/// en: 'Privacy Policy'
	String get privacyTitle => 'Privacy Policy';

	/// en: 'Medalize handles your personal and health information so you can book and manage medical appointments. We do not sell your data. The full Privacy Policy will be published here before the public launch.'
	String get privacyBody => 'Medalize handles your personal and health information so you can book and manage medical appointments. We do not sell your data. The full Privacy Policy will be published here before the public launch.';

	/// en: 'Terms of Service'
	String get termsTitle => 'Terms of Service';

	/// en: 'By using Medalize you agree to use the service responsibly for booking and managing appointments. The full Terms of Service will be published here before the public launch.'
	String get termsBody => 'By using Medalize you agree to use the service responsibly for booking and managing appointments. The full Terms of Service will be published here before the public launch.';

	/// en: 'Draft — pending final legal review.'
	String get draftNotice => 'Draft — pending final legal review.';

	/// en: 'Questions about your data? Contact support@medalize.app'
	String get contact => 'Questions about your data? Contact support@medalize.app';
}

// Path: doctorSearch.spec
class Translations$doctorSearch$spec$en {
	Translations$doctorSearch$spec$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'General'
	String get general => 'General';

	/// en: 'Cardiology'
	String get cardiology => 'Cardiology';

	/// en: 'Dermatology'
	String get dermatology => 'Dermatology';

	/// en: 'Neurology'
	String get neurology => 'Neurology';

	/// en: 'Orthopedics'
	String get orthopedics => 'Orthopedics';

	/// en: 'Pediatrics'
	String get pediatrics => 'Pediatrics';

	/// en: 'Psychiatry'
	String get psychiatry => 'Psychiatry';

	/// en: 'Gynecology'
	String get gynecology => 'Gynecology';

	/// en: 'Urology'
	String get urology => 'Urology';

	/// en: 'Ophthalmology'
	String get ophthalmology => 'Ophthalmology';

	/// en: 'ENT'
	String get ent => 'ENT';
}

// Path: workingHours.days
class Translations$workingHours$days$en {
	Translations$workingHours$days$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Monday'
	String get monday => 'Monday';

	/// en: 'Tuesday'
	String get tuesday => 'Tuesday';

	/// en: 'Wednesday'
	String get wednesday => 'Wednesday';

	/// en: 'Thursday'
	String get thursday => 'Thursday';

	/// en: 'Friday'
	String get friday => 'Friday';

	/// en: 'Saturday'
	String get saturday => 'Saturday';

	/// en: 'Sunday'
	String get sunday => 'Sunday';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'appName' => 'Medalize',
			'common.cancel' => 'Cancel',
			'common.logout' => 'Log Out',
			'common.doctor' => 'Doctor',
			'common.patient' => 'Patient',
			'common.save' => 'Save',
			'common.edit' => 'Edit',
			'common.retry' => 'Retry',
			'common.back' => 'Back',
			'common.ok' => 'OK',
			'common.delete' => 'Delete',
			'common.keep' => 'Keep',
			'common.confirm' => 'Confirm',
			'common.decline' => 'Decline',
			'common.primary' => 'Primary',
			'common.somethingWrong' => 'Something went wrong',
			'common.seeAll' => 'See all',
			'common.signOut' => 'Sign Out',
			'common.search' => 'Search',
			'common.tryAgain' => 'Please try again',
			'common.required' => 'Required',
			'common.noRatings' => 'No ratings yet',
			'auth.login' => 'Sign In',
			'auth.register' => 'Create Account',
			'auth.signIn' => 'Sign In',
			'auth.signUp' => 'Sign Up',
			'auth.email' => 'Email',
			'auth.password' => 'Password',
			'auth.confirmPassword' => 'Confirm Password',
			'auth.firstName' => 'First Name',
			'auth.lastName' => 'Last Name',
			'auth.rememberMe' => 'Remember me',
			'auth.forgotPassword' => 'Forgot password?',
			'auth.sendResetLink' => 'Send Reset Code',
			'auth.noAccount' => 'Don\'t have an account?',
			'auth.haveAccount' => 'Already have an account?',
			'auth.welcomeBack' => 'Welcome back',
			'auth.signInToContinue' => 'Sign in to your account to continue',
			'auth.createYourAccount' => 'Create your account',
			'auth.joinMedalize' => 'Join Medalize today',
			'auth.iAmA' => 'I am a',
			'auth.emailHint' => 'you@example.com',
			'auth.passwordHint' => '••••••••',
			'auth.backToSignIn' => 'Back to Sign In',
			'auth.verificationCode' => 'Verification code',
			'auth.continueWithGoogle' => 'Continue with Google',
			'auth.continueWithApple' => 'Continue with Apple',
			'auth.orDivider' => 'or',
			'forgotPassword.title' => 'Forgot Password?',
			'forgotPassword.subtitle' => 'Enter your email and we\'ll send you a 6-digit reset code',
			'resetPassword.title' => 'Reset Password',
			'resetPassword.subtitle' => 'Enter the code sent to your email and choose a new password',
			'resetPassword.button' => 'Reset Password',
			'resetPassword.success' => 'Password reset successfully. Please sign in.',
			'validation.emailRequired' => 'Email is required',
			'validation.emailInvalid' => 'Enter a valid email address',
			'validation.passwordRequired' => 'Password is required',
			'validation.passwordTooShort' => 'At least 8 characters required',
			'validation.passwordNeedsLetter' => 'Include at least one letter',
			'validation.passwordNeedsDigit' => 'Include at least one digit',
			'validation.passwordMismatch' => 'Passwords do not match',
			'validation.passwordConfirmRequired' => 'Please confirm your password',
			'validation.nameMinLength' => 'Must be at least 2 characters',
			'validation.roleRequired' => 'Please select a role',
			'validation.phoneRequired' => 'Phone number is required',
			'validation.phoneTooShort' => 'Number is too short',
			'validation.phoneTooLong' => 'Number is too long',
			'validation.fieldRequired' => ({required Object field}) => '${field} is required',
			'validation.fieldInvalid' => ({required Object field}) => '${field} contains invalid characters',
			'errors.network' => 'Network error. Check your connection.',
			'errors.rateLimit' => 'Too many attempts. Please wait and try again.',
			'errors.rateLimitWithSeconds' => ({required Object seconds}) => 'Too many attempts. Try again in ${seconds} s.',
			'errors.invalidCredentials' => 'Invalid email or password',
			'errors.sessionExpired' => 'Session expired. Please sign in again.',
			'errors.authError' => 'Authentication error. Please sign in again.',
			'errors.sessionRevoked' => 'Session was revoked. Please sign in again.',
			'errors.permissionDenied' => 'You do not have permission to do this.',
			'errors.validationError' => 'Validation error',
			'errors.serverError' => ({required Object code}) => 'Server error (${code}). Please try again.',
			'errors.socialLoginFailed' => 'Sign-in failed. Please try again or use your email and password.',
			'settings.title' => 'Settings',
			'settings.account' => 'Account',
			'settings.profile' => 'Profile',
			'settings.notifications' => 'Notifications',
			'settings.appearance' => 'Appearance',
			'settings.themeSystem' => 'System',
			'settings.themeLight' => 'Light',
			'settings.themeDark' => 'Dark',
			'settings.language' => 'Language',
			'settings.languageSystem' => 'System default',
			'settings.logoutTitle' => 'Logout',
			'settings.logoutConfirm' => 'Are you sure you want to logout?',
			'settings.version' => 'Medalize v1.0.0',
			'settings.legal' => 'Privacy & Terms',
			'security.title' => 'Security',
			'security.biometricLogin' => 'Biometric Login',
			'security.biometricLoginSubtitle' => 'Use Face ID / Touch ID to unlock the app',
			'security.biometricPrompt' => 'Authenticate to access Medalize',
			'security.biometricUnavailable' => 'Biometric authentication isn\'t available on this device',
			'security.biometricEnableFailed' => 'Couldn\'t verify your biometrics. Please try again.',
			'security.activeSessions' => 'Active Sessions',
			'security.activeSessionsSubtitle' => 'Devices currently signed in to your account',
			'security.thisDevice' => 'This device',
			'security.lastActive' => ({required Object date}) => 'Last active ${date}',
			'security.revoke' => 'Revoke',
			'security.revokeConfirmTitle' => 'Revoke device?',
			'security.revokeConfirmMessage' => ({required Object name}) => '${name} will be signed out. It can sign in again with your account credentials.',
			'security.revokeCurrentConfirmMessage' => 'This is your current device — revoking it will sign you out immediately.',
			'security.revokeFailed' => 'Couldn\'t revoke this device. Please try again.',
			'security.signOutAllDevices' => 'Sign out of all devices',
			'security.signOutAllConfirmTitle' => 'Sign out everywhere?',
			'security.signOutAllConfirmMessage' => 'You will be signed out on every device, including this one.',
			'security.signOutAllFailed' => 'Couldn\'t sign out of all devices. Please try again.',
			'security.noDevices' => 'No active sessions found',
			'security.loadFailed' => 'Couldn\'t load your active sessions',
			'security.changeEmail' => 'Change Email',
			'security.changeEmailSubtitle' => 'We\'ll send a verification code to your new email address. After confirming, you\'ll sign in with the new email.',
			'security.newEmailLabel' => 'New email',
			'security.sendCode' => 'Send Code',
			'security.codeSentTo' => ({required Object email}) => 'Enter the 6-digit code we sent to ${email}',
			'security.confirmNewEmail' => 'Confirm New Email',
			'security.changeEmailSuccess' => 'Your email has been changed. Please sign in again with your new email.',
			'security.dangerZone' => 'Danger Zone',
			'security.deactivateAccount' => 'Deactivate Account',
			'security.deactivateAccountSubtitle' => 'Disable your account without deleting your data',
			'security.deactivateConfirmTitle' => 'Deactivate account?',
			'security.deactivateConfirmMessage' => 'Your account will be deactivated and you will be signed out on all devices. Your data will not be deleted. Contact support to reactivate your account.',
			'security.deactivate' => 'Deactivate',
			'security.deactivateSuccess' => 'Your account has been deactivated.',
			'status.confirmed' => 'Confirmed',
			'status.pending' => 'Pending',
			'status.cancelled' => 'Cancelled',
			'status.declined' => 'Declined',
			'status.requiresRescheduling' => 'Requires Rescheduling',
			'status.completed' => 'Completed',
			'status.noShow' => 'No-show',
			'home.helloDoctor' => ({required Object name}) => 'Hello, Dr. ${name}!',
			'home.helloPatient' => ({required Object name}) => 'Hello, ${name}!',
			'home.doctorSubtitle' => 'Manage your schedule\nand appointments.',
			'home.patientSubtitle' => 'Find a doctor and\nbook an appointment.',
			'home.pendingRequests' => 'Pending Requests',
			'home.upcoming' => 'Upcoming',
			'home.findDoctor' => 'Find Doctor',
			'home.aiAssistant' => 'AI Assistant',
			'home.myAppointments' => 'My Appointments',
			'home.appointments' => 'Appointments',
			'home.workplaces' => 'Workplaces',
			'home.blockTime' => 'Block Time',
			'home.profile' => 'Profile',
			'home.allCaughtUp' => 'All caught up',
			'home.noPendingRequests' => 'No pending appointment requests',
			'home.couldNotLoadAppointments' => 'Could not load appointments',
			'home.noUpcoming' => 'No upcoming appointments',
			'home.bookFirst' => 'Book your first appointment with a doctor',
			'home.findADoctor' => 'Find a Doctor',
			'home.myWaitlist' => 'My Waitlist',
			'home.leaveWaitlist' => 'Leave',
			'home.statsThisMonth' => 'This month',
			'home.statsPatients' => 'Patients',
			'home.statsAcceptRate' => 'Accept rate',
			'home.statsPending' => 'Pending',
			'home.schedule' => 'Schedule',
			'appointments.title' => 'Appointments',
			'appointments.myTitle' => 'My Appointments',
			'appointments.tabPending' => 'Pending',
			'appointments.tabAll' => 'All',
			'appointments.tabUpcoming' => 'Upcoming',
			'appointments.tabPast' => 'Past',
			'appointments.noPendingRequests' => 'No pending requests',
			'appointments.newRequestsAppear' => 'New appointment requests will appear here',
			'appointments.noAppointments' => 'No appointments',
			'appointments.appointmentsAppear' => 'Your appointments will appear here',
			'appointments.noUpcoming' => 'No upcoming appointments',
			'appointments.bookFirst' => 'Book your first appointment with a doctor',
			'appointments.noPast' => 'No past appointments',
			'appointments.pastAppear' => 'Completed and cancelled appointments appear here',
			'appointments.couldNotLoad' => 'Could not load appointments',
			'appointments.detailTitle' => 'Appointment',
			'appointments.patient' => 'Patient',
			'appointments.doctor' => 'Doctor',
			'appointments.workplace' => 'Workplace',
			'appointments.dateTime' => 'Date & Time',
			'appointments.reason' => 'Reason',
			'appointments.doctorNotes' => 'Doctor Notes',
			'appointments.cancelTitle' => 'Cancel Appointment',
			'appointments.cancelConfirm' => 'Are you sure you want to cancel this appointment?',
			'appointments.cancelAction' => 'Cancel Appointment',
			'appointments.bookedTitle' => 'Booked!',
			'appointments.bookedMessage' => 'Your appointment request has been sent.',
			'appointments.reschedule' => 'Reschedule',
			'appointments.rescheduleTitle' => 'Reschedule Appointment',
			'appointments.reviewTitle' => 'Leave a Review',
			'appointments.reviewRating' => 'Rating',
			'appointments.reviewComment' => 'Comment (optional)',
			'appointments.reviewSubmit' => 'Submit',
			'appointments.markCompleted' => 'Mark as Completed',
			'appointments.rescheduledSuccess' => 'Appointment rescheduled successfully.',
			'appointments.reviewSubmitted' => 'Review submitted. Thank you!',
			'appointments.yourReview' => 'Your Review',
			'appointments.editReviewTitle' => 'Edit Review',
			'appointments.reviewUpdated' => 'Review updated.',
			'appointments.deleteReviewTitle' => 'Delete Review',
			'appointments.deleteReviewConfirm' => 'Are you sure you want to delete your review?',
			'appointments.reviewDeleted' => 'Review deleted.',
			'appointments.requestReschedule' => 'Request Reschedule',
			'appointments.requestRescheduleTitle' => 'Request Reschedule',
			'appointments.requestRescheduleConfirm' => 'Ask the patient to pick a new time? The appointment will be marked as needing rescheduling.',
			'appointments.requestRescheduleSuccess' => 'Reschedule requested. The patient will be notified.',
			'appointments.rescheduleNeededHint' => 'The doctor asked you to choose a new time.',
			'appointments.markNoShow' => 'Mark No-show',
			'appointments.markNoShowTitle' => 'Mark as No-show',
			'appointments.markNoShowConfirm' => 'Mark this appointment as a no-show? This records that the patient did not attend.',
			'booking.bookWith' => ({required Object name}) => 'Book — ${name}',
			'booking.selectWorkplace' => 'Select Workplace',
			'booking.pickDate' => 'Pick a date',
			'booking.slotsAppear' => 'Available time slots will appear here',
			'booking.couldNotLoadSlots' => 'Could not load slots',
			'booking.noAvailableSlots' => 'No available slots',
			'booking.noOpenSlots' => 'No open slots for this date. Try another day.',
			'booking.confirmTitle' => 'Confirm Booking',
			'booking.reasonForVisit' => 'Reason for visit (optional)',
			'booking.confirmButton' => 'Confirm Booking',
			'booking.doctorLabel' => 'Doctor',
			'booking.workplaceLabel' => 'Workplace',
			'booking.addressLabel' => 'Address',
			'booking.startLabel' => 'Start',
			'booking.endLabel' => 'End',
			'booking.tryDifferentDate' => 'Try a different date',
			'doctorSearch.title' => 'Find a Doctor',
			'doctorSearch.searchByName' => 'Search by name...',
			'doctorSearch.city' => 'City',
			'doctorSearch.search' => 'Search',
			'doctorSearch.noDoctorsFound' => 'No doctors found',
			'doctorSearch.adjustSearch' => 'Try adjusting your search or filters',
			'doctorSearch.couldNotLoadDoctors' => 'Could not load doctors',
			'doctorSearch.spec.general' => 'General',
			'doctorSearch.spec.cardiology' => 'Cardiology',
			'doctorSearch.spec.dermatology' => 'Dermatology',
			'doctorSearch.spec.neurology' => 'Neurology',
			'doctorSearch.spec.orthopedics' => 'Orthopedics',
			'doctorSearch.spec.pediatrics' => 'Pediatrics',
			'doctorSearch.spec.psychiatry' => 'Psychiatry',
			'doctorSearch.spec.gynecology' => 'Gynecology',
			'doctorSearch.spec.urology' => 'Urology',
			'doctorSearch.spec.ophthalmology' => 'Ophthalmology',
			'doctorSearch.spec.ent' => 'ENT',
			'doctorSearch.noAvailability' => 'No availability',
			'doctorSearch.availableToday' => 'Available today',
			'doctorSearch.availableTomorrow' => 'Available tomorrow',
			'doctorSearch.availableOn' => ({required Object date}) => 'Available ${date}',
			'doctorSearch.sortBy' => 'Sort by',
			'doctorSearch.sortDefault' => 'Relevance',
			'doctorSearch.sortRating' => 'Top rated',
			'doctorSearch.sortPriceLow' => 'Lowest price',
			'doctorSearch.sortName' => 'Name (A–Z)',
			'doctorSearch.sortNearestSlot' => 'Earliest available',
			'doctorSearch.sortDistance' => 'Nearest to me',
			'doctorSearch.locationDenied' => 'Location permission is needed to sort by distance. Allow it in Settings, or filter by city instead.',
			'doctorSearch.locationUnavailable' => 'Couldn\'t get your location. Check that location services are on, or filter by city instead.',
			'doctorSearch.distanceKm' => ({required Object km}) => '${km} km',
			'doctorDetail.profileTitle' => 'Doctor Profile',
			'doctorDetail.couldNotLoadProfile' => 'Could not load profile',
			'doctorDetail.about' => 'About',
			'doctorDetail.workplaces' => 'Workplaces',
			'doctorDetail.minPerSlot' => ({required Object min}) => '${min} min per slot',
			'doctorDetail.bookAppointment' => 'Book Appointment',
			'doctorDetail.consultationFee' => 'Consultation fee',
			'doctorDetail.reviews' => 'Reviews',
			'doctorDetail.reviewsCount' => ({required Object count}) => '${count} reviews',
			'doctorDetail.joinWaitlist' => 'Join waitlist',
			'doctorDetail.leaveWaitlist' => 'Leave waitlist',
			'profile.title' => 'Profile',
			'profile.changePassword' => 'Change Password',
			'profile.currentPassword' => 'Current Password',
			'profile.newPassword' => 'New Password',
			'profile.confirmNewPassword' => 'Confirm New Password',
			'profile.firstName' => 'First Name',
			'profile.lastName' => 'Last Name',
			'profile.phone' => 'Phone',
			'profile.failedToSave' => 'Failed to save profile.',
			'profile.professionalInfo' => 'Professional Info',
			'profile.bio' => 'Bio',
			'profile.bioHint' => 'Short description of your experience',
			'profile.consultationFee' => 'Consultation fee',
			'profile.medicalInfo' => 'Medical Information',
			'profile.allergies' => 'Allergies',
			'profile.allergiesHint' => 'e.g. Penicillin, peanuts',
			'profile.chronicConditions' => 'Chronic conditions',
			'profile.chronicConditionsHint' => 'e.g. Diabetes, hypertension',
			'profile.medications' => 'Current medications',
			'profile.medicationsHint' => 'e.g. Metformin 500mg',
			'profile.appointmentLength' => 'Appointment length',
			'profile.cancellationWindow' => 'Cancellation window',
			'profile.cancellationWindowHint' => 'How long before an appointment patients can still cancel or reschedule.',
			'profile.hoursValue' => ({required Object h}) => '${h} h',
			'notifications.title' => 'Notifications',
			'notifications.noNotifications' => 'No notifications',
			'notifications.allCaughtUp' => 'You are all caught up',
			'notifications.couldNotLoad' => 'Could not load notifications',
			'notifications.markAllRead' => 'Mark all read',
			'notifications.settingsTitle' => 'Notification settings',
			'notifications.pushEnabled' => 'Push notifications',
			'notifications.pushEnabledSubtitle' => 'Alerts on this device for bookings and updates',
			'notifications.emailEnabled' => 'Email notifications',
			'notifications.emailEnabledSubtitle' => 'Updates sent to your email address',
			'workplaces.title' => 'My Workplaces',
			'workplaces.noWorkplacesYet' => 'No workplaces yet',
			'workplaces.tapToAdd' => 'Tap + to add your first workplace',
			'workplaces.couldNotLoad' => 'Could not load workplaces',
			'workplaces.deleteTitle' => 'Delete Workplace',
			'workplaces.deleteConfirm' => ({required Object name}) => 'Delete "${name}"?',
			'workplaces.cannotDelete' => 'Cannot delete workplace',
			'workplaces.workingHours' => 'Working Hours',
			'workplaces.setAsPrimary' => 'Set as Primary',
			'addWorkplace.addTitle' => 'Add Workplace',
			'addWorkplace.editTitle' => 'Edit Workplace',
			'addWorkplace.name' => 'Name',
			'addWorkplace.address' => 'Address',
			'addWorkplace.city' => 'City',
			'addWorkplace.type' => 'Type',
			'addWorkplace.clinic' => 'Clinic',
			'addWorkplace.hospital' => 'Hospital',
			'addWorkplace.privatePractice' => 'Private Practice',
			'addWorkplace.failedToSave' => 'Failed to save workplace.',
			'addWorkplace.addButton' => 'Add Workplace',
			'addWorkplace.saveChanges' => 'Save Changes',
			'workingHours.title' => 'Working Hours',
			'workingHours.saved' => 'Working hours saved',
			'workingHours.failedToSave' => 'Failed to save working hours',
			'workingHours.days.monday' => 'Monday',
			'workingHours.days.tuesday' => 'Tuesday',
			'workingHours.days.wednesday' => 'Wednesday',
			'workingHours.days.thursday' => 'Thursday',
			'workingHours.days.friday' => 'Friday',
			'workingHours.days.saturday' => 'Saturday',
			'workingHours.days.sunday' => 'Sunday',
			'blockTime.title' => 'Block Time',
			'blockTime.dateRange' => 'Date Range',
			'blockTime.tapToSelect' => 'Tap to select dates',
			'blockTime.reason' => 'Reason (optional)',
			'blockTime.notifyPatients' => 'Notify affected patients',
			'blockTime.notifyDesc' => 'Send notifications to patients with appointments in this period',
			'blockTime.selectDateRange' => 'Please select a date range.',
			'blockTime.failedToBlock' => 'Failed to block time. Please try again.',
			'blockTime.blockButton' => 'Block Period',
			'onboarding.title' => 'Complete Your Profile',
			'onboarding.professionalInfo' => 'Professional information',
			'onboarding.tellPatients' => 'Tell patients about your practice.',
			'onboarding.specialization' => 'Specialization',
			'onboarding.selectSpecialization' => 'Select your specialization',
			'onboarding.couldNotLoadSpecs' => 'Could not load specializations. Pull back and retry.',
			'onboarding.licenseNumber' => 'License number',
			'onboarding.licenseHint' => 'e.g. AZ-123456',
			'onboarding.bio' => 'Bio (optional)',
			'onboarding.bioHint' => 'A short introduction patients will see on your profile.',
			'onboarding.appointmentLength' => 'Appointment length',
			'onboarding.slotQuestion' => 'How long is a single appointment slot?',
			'onboarding.changeLater' => 'You can change this later from your profile.',
			'onboarding.minutes' => ({required Object min}) => '${min} min',
			'onboarding.verificationDoc' => 'Verification document',
			'onboarding.uploadDiploma' => 'Upload your medical diploma or license. An admin reviews it before your account is verified.',
			'onboarding.tapToChoose' => 'Tap to choose a file',
			'onboarding.tapToReplace' => 'Tap to replace',
			'onboarding.anyFileType' => 'Any file type, up to 10 MB',
			'onboarding.selectSpecError' => 'Please select your specialization.',
			'onboarding.licenseError' => 'Please enter your license number.',
			'onboarding.diplomaError' => 'Please attach your diploma.',
			'onboarding.checkDetails' => 'Please check your details and try again.',
			'onboarding.continueButton' => 'Continue',
			'onboarding.finish' => 'Finish',
			'pendingVerification.title' => 'Verification Pending',
			'pendingVerification.message' => 'Your account is under review. We will notify you once it is verified.',
			'pendingVerification.checkStatus' => 'Check Status',
			'pendingVerification.stillPending' => 'Still under review. We\'ll notify you once it\'s verified.',
			'phoneField.label' => 'Phone Number',
			'phoneField.labelOptional' => 'Phone Number (Optional)',
			'phoneField.selectCountry' => 'Select Country',
			'phoneField.searchCountry' => 'Search country or code…',
			'phoneField.noCountriesFound' => 'No countries found',
			'splash.tagline' => 'Your health, simplified',
			'appIntro.page1Title' => 'Find the right doctor',
			'appIntro.page1Subtitle' => 'Search by specialty, city, and rating — then book a time that works for you.',
			'appIntro.page2Title' => 'Ask our AI health assistant',
			'appIntro.page2Subtitle' => 'Describe your symptoms and get pointed toward the right specialist, any time.',
			'appIntro.page3Title' => 'Everything in one place',
			'appIntro.page3Subtitle' => 'Manage appointments, track your care, and use the app in your language — safely and securely.',
			'appIntro.skip' => 'Skip',
			'appIntro.next' => 'Next',
			'appIntro.getStarted' => 'Get Started',
			'agenda.title' => 'Schedule',
			'agenda.today' => 'Today',
			'agenda.empty' => 'No appointments',
			'agenda.emptySubtitle' => 'Nothing scheduled for this day',
			'favorites.title' => 'Favorites',
			'favorites.empty' => 'No favorites yet',
			'favorites.emptySubtitle' => 'Tap the heart on a doctor to save them here',
			'favorites.add' => 'Add to favorites',
			'favorites.remove' => 'Remove from favorites',
			'assistant.title' => 'AI Assistant',
			'assistant.newChat' => 'New Chat',
			'assistant.empty' => 'No conversations yet',
			'assistant.emptySubtitle' => 'Describe your symptoms and the assistant will suggest which doctor to see',
			'assistant.couldNotLoad' => 'Could not load conversations',
			'assistant.couldNotLoadChat' => 'Could not load this conversation',
			'assistant.newConversation' => 'New conversation',
			'assistant.deleteTitle' => 'Delete conversation?',
			'assistant.deleteConfirm' => 'This conversation and all its messages will be deleted.',
			'assistant.inputHint' => 'Describe your symptoms…',
			'assistant.send' => 'Send',
			'assistant.sendFailed' => 'Message could not be sent. Please try again.',
			'assistant.typing' => 'Assistant is typing…',
			'assistant.startTitle' => 'How can I help?',
			'assistant.startSubtitle' => 'Describe what is bothering you to get started',
			'assistant.book' => 'Book',
			'assistant.reportTooltip' => 'Report this response',
			'assistant.reportTitle' => 'Report response',
			'assistant.reportHint' => 'Reason (optional)',
			'assistant.reportSubmit' => 'Report',
			'assistant.reportSuccess' => 'Thank you, the response was reported.',
			'assistant.reportFailed' => 'Could not report the response. Please try again.',
			'legal.title' => 'Privacy & Terms',
			'legal.privacyTitle' => 'Privacy Policy',
			'legal.privacyBody' => 'Medalize handles your personal and health information so you can book and manage medical appointments. We do not sell your data. The full Privacy Policy will be published here before the public launch.',
			'legal.termsTitle' => 'Terms of Service',
			'legal.termsBody' => 'By using Medalize you agree to use the service responsibly for booking and managing appointments. The full Terms of Service will be published here before the public launch.',
			'legal.draftNotice' => 'Draft — pending final legal review.',
			'legal.contact' => 'Questions about your data? Contact support@medalize.app',
			_ => null,
		};
	}
}
