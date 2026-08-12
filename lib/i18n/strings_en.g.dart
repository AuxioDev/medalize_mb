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

	/// en: 'DocLine'
	String get appName => 'DocLine';

	late final Translations$common$en common = Translations$common$en.internal(_root);
	late final Translations$auth$en auth = Translations$auth$en.internal(_root);
	late final Translations$forgotPassword$en forgotPassword = Translations$forgotPassword$en.internal(_root);
	late final Translations$resetPassword$en resetPassword = Translations$resetPassword$en.internal(_root);
	late final Translations$verifyPhone$en verifyPhone = Translations$verifyPhone$en.internal(_root);
	late final Translations$socialComplete$en socialComplete = Translations$socialComplete$en.internal(_root);
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
	late final Translations$locations$en locations = Translations$locations$en.internal(_root);
	late final Translations$splash$en splash = Translations$splash$en.internal(_root);
	late final Translations$appIntro$en appIntro = Translations$appIntro$en.internal(_root);
	late final Translations$agenda$en agenda = Translations$agenda$en.internal(_root);
	late final Translations$favorites$en favorites = Translations$favorites$en.internal(_root);
	late final Translations$assistant$en assistant = Translations$assistant$en.internal(_root);
	late final Translations$messaging$en messaging = Translations$messaging$en.internal(_root);
	late final Translations$legal$en legal = Translations$legal$en.internal(_root);
	late final Translations$medications$en medications = Translations$medications$en.internal(_root);
	late final Translations$prescriptions$en prescriptions = Translations$prescriptions$en.internal(_root);
	late final Translations$records$en records = Translations$records$en.internal(_root);
	late final Translations$payments$en payments = Translations$payments$en.internal(_root);
	late final Translations$family$en family = Translations$family$en.internal(_root);
	late final Translations$subscription$en subscription = Translations$subscription$en.internal(_root);
	late final Translations$hospitalPicker$en hospitalPicker = Translations$hospitalPicker$en.internal(_root);
	late final Translations$hospitalRegistration$en hospitalRegistration = Translations$hospitalRegistration$en.internal(_root);
	late final Translations$hospitalHome$en hospitalHome = Translations$hospitalHome$en.internal(_root);
	late final Translations$hospitalDoctors$en hospitalDoctors = Translations$hospitalDoctors$en.internal(_root);
	late final Translations$hospitalInvite$en hospitalInvite = Translations$hospitalInvite$en.internal(_root);
	late final Translations$hospitalAppointments$en hospitalAppointments = Translations$hospitalAppointments$en.internal(_root);
	late final Translations$hospitalProfile$en hospitalProfile = Translations$hospitalProfile$en.internal(_root);
	late final Translations$hospitalDoctorHours$en hospitalDoctorHours = Translations$hospitalDoctorHours$en.internal(_root);
	late final Translations$doctorHospitals$en doctorHospitals = Translations$doctorHospitals$en.internal(_root);
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

	/// en: 'Hospital'
	String get hospital => 'Hospital';
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

	/// en: 'Join DocLine today'
	String get joinMedalize => 'Join DocLine today';

	/// en: 'I am a'
	String get iAmA => 'I am a';

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

	/// en: 'Enter your phone number and we'll send you a 6-digit reset code'
	String get subtitle => 'Enter your phone number and we\'ll send you a 6-digit reset code';
}

// Path: resetPassword
class Translations$resetPassword$en {
	Translations$resetPassword$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Reset Password'
	String get title => 'Reset Password';

	/// en: 'Enter the code sent to your phone and choose a new password'
	String get subtitle => 'Enter the code sent to your phone and choose a new password';

	/// en: 'Reset Password'
	String get button => 'Reset Password';

	/// en: 'Password reset successfully. Please sign in.'
	String get success => 'Password reset successfully. Please sign in.';
}

// Path: verifyPhone
class Translations$verifyPhone$en {
	Translations$verifyPhone$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Verify Your Phone'
	String get title => 'Verify Your Phone';

	/// en: 'We've sent a 6-digit code to $phone'
	String subtitle({required Object phone}) => 'We\'ve sent a 6-digit code to ${phone}';

	/// en: 'Verify'
	String get button => 'Verify';

	/// en: 'Resend code'
	String get resend => 'Resend code';

	/// en: 'A new code has been sent.'
	String get resendSent => 'A new code has been sent.';
}

// Path: socialComplete
class Translations$socialComplete$en {
	Translations$socialComplete$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Almost there'
	String get title => 'Almost there';

	/// en: 'Enter and verify a phone number to finish creating your account.'
	String get subtitle => 'Enter and verify a phone number to finish creating your account.';

	/// en: 'Continue'
	String get button => 'Continue';
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

	/// en: 'Invalid phone number or password'
	String get invalidCredentials => 'Invalid phone number or password';

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

	/// en: 'Sign-in failed. Please try again or use your phone number and password.'
	String get socialLoginFailed => 'Sign-in failed. Please try again or use your phone number and password.';

	/// en: 'This action can't be completed right now.'
	String get conflict => 'This action can\'t be completed right now.';

	/// en: 'Please complete all required fields before finishing onboarding.'
	String get onboardingIncomplete => 'Please complete all required fields before finishing onboarding.';

	/// en: 'You've reached your plan's limit. Upgrade to add more.'
	String get planLimitReached => 'You\'ve reached your plan\'s limit. Upgrade to add more.';

	/// en: 'This doctor doesn't offer chat on their current plan.'
	String get chatUnavailable => 'This doctor doesn\'t offer chat on their current plan.';

	/// en: 'Please verify your phone number before signing in.'
	String get phoneNotVerified => 'Please verify your phone number before signing in.';
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

	/// en: 'DocLine v1.0.0'
	String get version => 'DocLine v1.0.0';

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

	/// en: 'Authenticate to access DocLine'
	String get biometricPrompt => 'Authenticate to access DocLine';

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

	/// en: 'Change Phone Number'
	String get changePhone => 'Change Phone Number';

	/// en: 'We'll send a verification code to your new phone number. After confirming, you'll sign in with the new number.'
	String get changePhoneSubtitle => 'We\'ll send a verification code to your new phone number. After confirming, you\'ll sign in with the new number.';

	/// en: 'Send Code'
	String get sendCode => 'Send Code';

	/// en: 'Enter the 6-digit code we sent to $phone'
	String codeSentTo({required Object phone}) => 'Enter the 6-digit code we sent to ${phone}';

	/// en: 'Confirm New Phone Number'
	String get confirmNewPhone => 'Confirm New Phone Number';

	/// en: 'Your phone number has been changed. Please sign in again with your new number.'
	String get changePhoneSuccess => 'Your phone number has been changed. Please sign in again with your new number.';

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

	/// en: 'Delete Account Permanently'
	String get deleteAccount => 'Delete Account Permanently';

	/// en: 'Erase your data. This cannot be undone.'
	String get deleteAccountSubtitle => 'Erase your data. This cannot be undone.';

	/// en: 'Delete your account permanently?'
	String get deleteConfirmTitle => 'Delete your account permanently?';

	/// en: 'This action is permanent and cannot be undone.'
	String get deleteConfirmWarning => 'This action is permanent and cannot be undone.';

	/// en: 'Your profile, medical records, prescriptions, and messages will be permanently erased. Any upcoming appointments will be cancelled and refunded where eligible. Payment records are kept in anonymized form for accounting purposes as required by law.'
	String get deleteConfirmMessage => 'Your profile, medical records, prescriptions, and messages will be permanently erased. Any upcoming appointments will be cancelled and refunded where eligible. Payment records are kept in anonymized form for accounting purposes as required by law.';

	/// en: 'Your account has been permanently deleted.'
	String get deleteAccountSuccess => 'Your account has been permanently deleted.';
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

	/// en: 'Appointment cancelled.'
	String get cancelledSuccess => 'Appointment cancelled.';

	/// en: 'Appointment cancelled. Your payment has been refunded.'
	String get cancelledRefunded => 'Appointment cancelled. Your payment has been refunded.';

	/// en: 'Appointment cancelled. No refund was issued — this was too close to the appointment time.'
	String get cancelledNoRefund => 'Appointment cancelled. No refund was issued — this was too close to the appointment time.';

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

	/// en: 'Dispute this'
	String get disputeNoShow => 'Dispute this';

	/// en: 'Dispute No-show'
	String get disputeNoShowTitle => 'Dispute No-show';

	/// en: 'Tell us why you think this was marked incorrectly — our support team will review it.'
	String get disputeNoShowHint => 'Tell us why you think this was marked incorrectly — our support team will review it.';

	/// en: 'Submit'
	String get disputeNoShowSubmit => 'Submit';

	/// en: 'Your dispute has been submitted. We'll review it and get back to you.'
	String get disputeNoShowSubmitted => 'Your dispute has been submitted. We\'ll review it and get back to you.';

	/// en: 'Dispute submitted — under review'
	String get disputeNoShowOpen => 'Dispute submitted — under review';
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

	/// en: 'Load more'
	String get loadMore => 'Load more';

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

	/// en: 'Push categories'
	String get categoriesTitle => 'Push categories';

	/// en: 'Appointments & care'
	String get careCategory => 'Appointments & care';

	/// en: 'Bookings, reminders, prescriptions'
	String get careCategorySubtitle => 'Bookings, reminders, prescriptions';

	/// en: 'Messages'
	String get messagesCategory => 'Messages';

	/// en: 'New chat messages'
	String get messagesCategorySubtitle => 'New chat messages';

	/// en: 'Account & billing'
	String get accountCategory => 'Account & billing';

	/// en: 'Verification, payments, subscription'
	String get accountCategorySubtitle => 'Verification, payments, subscription';

	/// en: 'Quiet hours'
	String get quietHoursTitle => 'Quiet hours';

	/// en: 'Enable quiet hours'
	String get quietHoursEnabled => 'Enable quiet hours';

	/// en: 'Pause push notifications during this window'
	String get quietHoursSubtitle => 'Pause push notifications during this window';

	/// en: 'Start'
	String get quietHoursStart => 'Start';

	/// en: 'End'
	String get quietHoursEnd => 'End';
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

	/// en: 'Street Address'
	String get address => 'Street Address';

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

	/// en: 'Pick on Map'
	String get pickOnMap => 'Pick on Map';

	/// en: 'Choose Location'
	String get mapPickerTitle => 'Choose Location';

	/// en: 'Use my location'
	String get useMyLocation => 'Use my location';

	/// en: 'Confirm Location'
	String get confirmLocation => 'Confirm Location';

	/// en: 'Location set from map ✓'
	String get locationSet => 'Location set from map ✓';

	/// en: 'Location permission is needed to use your current position. You can still move the map manually.'
	String get locationPermissionDenied => 'Location permission is needed to use your current position. You can still move the map manually.';

	/// en: 'Couldn't get your location. You can still move the map manually.'
	String get locationUnavailable => 'Couldn\'t get your location. You can still move the map manually.';
}

// Path: workingHours
class Translations$workingHours$en {
	Translations$workingHours$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Working Hours'
	String get title => 'Working Hours';

	/// en: 'Set the days and hours patients can book you at this location.'
	String get sectionHint => 'Set the days and hours patients can book you at this location.';

	/// en: 'End time must be after start time for each active day.'
	String get invalidRange => 'End time must be after start time for each active day.';

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

	/// en: 'Select Country'
	String get selectCountry => 'Select Country';

	/// en: 'Search country or code…'
	String get searchCountry => 'Search country or code…';

	/// en: 'No countries found'
	String get noCountriesFound => 'No countries found';
}

// Path: locations
class Translations$locations$en {
	Translations$locations$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Select City'
	String get pickCity => 'Select City';

	/// en: 'Search city or region…'
	String get searchHint => 'Search city or region…';

	/// en: 'No cities found'
	String get noResultsFound => 'No cities found';

	/// en: 'Could not load cities. Tap to retry.'
	String get couldNotLoad => 'Could not load cities. Tap to retry.';

	/// en: 'All cities'
	String get allCities => 'All cities';
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

	/// en: 'Topics'
	String get topicsTooltip => 'Topics';

	/// en: 'Choose a topic'
	String get topicsSheetTitle => 'Choose a topic';
}

// Path: messaging
class Translations$messaging$en {
	Translations$messaging$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Messages'
	String get title => 'Messages';

	/// en: 'Message'
	String get sendMessage => 'Message';

	/// en: 'Type a message…'
	String get typeMessage => 'Type a message…';

	/// en: 'Send'
	String get send => 'Send';

	/// en: 'No conversations yet'
	String get empty => 'No conversations yet';

	/// en: 'Your conversations will appear here.'
	String get emptySubtitle => 'Your conversations will appear here.';

	/// en: 'This is not an emergency line. For urgent issues, call emergency services.'
	String get disclaimer => 'This is not an emergency line. For urgent issues, call emergency services.';

	/// en: 'You can message a doctor once you have a shared appointment history.'
	String get noSharedHistory => 'You can message a doctor once you have a shared appointment history.';

	/// en: 'You have a new message'
	String get newMessage => 'You have a new message';
}

// Path: legal
class Translations$legal$en {
	Translations$legal$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Privacy & Terms'
	String get title => 'Privacy & Terms';

	/// en: 'DocLine is created and operated by AuxioDev (auxiodev.com), Azerbaijan ("we", "us"). Last updated: July 2026.'
	String get controllerNotice => 'DocLine is created and operated by AuxioDev (auxiodev.com), Azerbaijan ("we", "us"). Last updated: July 2026.';

	/// en: 'Privacy Policy'
	String get privacyTitle => 'Privacy Policy';

	/// en: 'This policy explains what personal data DocLine collects, why, and how it is protected. Booking and managing medical appointments necessarily involves health information about you, so we explain that in detail below.'
	String get privacyIntro => 'This policy explains what personal data DocLine collects, why, and how it is protected. Booking and managing medical appointments necessarily involves health information about you, so we explain that in detail below.';

	late final Translations$legal$sections$en sections = Translations$legal$sections$en.internal(_root);

	/// en: 'Terms of Service'
	String get termsTitle => 'Terms of Service';

	/// en: 'By creating an account, you agree to the following.'
	String get termsIntro => 'By creating an account, you agree to the following.';

	/// en: 'Provide accurate information about yourself. Use DocLine only for finding, booking, and managing medical appointments. Keep your login credentials confidential. DocLine connects you with independent, licensed medical professionals — we are not a medical provider ourselves, and the AI symptom-checking assistant does not replace professional medical diagnosis or advice. In a medical emergency, contact emergency services directly, not this app. We may suspend or terminate accounts that violate these terms or misuse the platform.'
	String get termsBody => 'Provide accurate information about yourself. Use DocLine only for finding, booking, and managing medical appointments. Keep your login credentials confidential. DocLine connects you with independent, licensed medical professionals — we are not a medical provider ourselves, and the AI symptom-checking assistant does not replace professional medical diagnosis or advice. In a medical emergency, contact emergency services directly, not this app. We may suspend or terminate accounts that violate these terms or misuse the platform.';

	/// en: 'Questions about your data? Contact support@auxiodev.com'
	String get contact => 'Questions about your data? Contact support@auxiodev.com';

	/// en: 'I have read and agree to the '
	String get consentPrefix => 'I have read and agree to the ';

	/// en: 'Privacy Policy'
	String get consentPrivacyLink => 'Privacy Policy';

	/// en: ' and '
	String get consentMiddle => ' and ';

	/// en: 'Terms of Service'
	String get consentTermsLink => 'Terms of Service';

	/// en: ', and I explicitly consent to the processing of my health data as described.'
	String get consentSuffix => ', and I explicitly consent to the processing of my health data as described.';

	/// en: 'View as PDF'
	String get viewAsPdf => 'View as PDF';

	/// en: 'DocLine — Privacy Policy & Terms of Service'
	String get pdfDocumentTitle => 'DocLine — Privacy Policy & Terms of Service';

	/// en: 'Could not load the document. Please check your internet connection and try again.'
	String get pdfLoadError => 'Could not load the document. Please check your internet connection and try again.';
}

// Path: medications
class Translations$medications$en {
	Translations$medications$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Medications'
	String get title => 'Medications';

	/// en: 'Edit Medication'
	String get editMedication => 'Edit Medication';

	/// en: 'Name'
	String get name => 'Name';

	/// en: 'Dosage'
	String get dosage => 'Dosage';

	/// en: 'Notes'
	String get notes => 'Notes';

	/// en: 'Form'
	String get form => 'Form';

	/// en: 'Pill'
	String get formPill => 'Pill';

	/// en: 'Capsule'
	String get formCapsule => 'Capsule';

	/// en: 'Liquid'
	String get formLiquid => 'Liquid';

	/// en: 'Injection'
	String get formInjection => 'Injection';

	/// en: 'Other'
	String get formOther => 'Other';

	/// en: 'Schedule'
	String get schedule => 'Schedule';

	/// en: 'Times'
	String get times => 'Times';

	/// en: 'Add Time'
	String get addTime => 'Add Time';

	/// en: 'Days of Week'
	String get daysOfWeek => 'Days of Week';

	/// en: 'Every day'
	String get everyDay => 'Every day';

	/// en: 'Start Date'
	String get startDate => 'Start Date';

	/// en: 'End Date'
	String get endDate => 'End Date';

	/// en: 'Save'
	String get save => 'Save';

	/// en: 'Delete'
	String get delete => 'Delete';

	/// en: 'Delete Medication'
	String get deleteConfirmTitle => 'Delete Medication';

	/// en: 'Are you sure you want to delete this medication? Its dose history will be kept.'
	String get deleteConfirmBody => 'Are you sure you want to delete this medication? Its dose history will be kept.';

	/// en: 'No medications yet'
	String get emptyTitle => 'No medications yet';

	/// en: 'Medications your doctor prescribes will appear here after your appointment.'
	String get emptySubtitle => 'Medications your doctor prescribes will appear here after your appointment.';

	/// en: 'Today's Doses'
	String get todaysDoses => 'Today\'s Doses';

	/// en: 'Taken'
	String get markTaken => 'Taken';

	/// en: 'Skip'
	String get markSkipped => 'Skip';

	/// en: 'Taken'
	String get statusTaken => 'Taken';

	/// en: 'Skipped'
	String get statusSkipped => 'Skipped';

	/// en: 'Pending'
	String get statusPending => 'Pending';

	/// en: 'Time to take $name'
	String reminderTitle({required Object name}) => 'Time to take ${name}';

	/// en: 'Dose: $dosage'
	String reminderBody({required Object dosage}) => 'Dose: ${dosage}';

	/// en: 'Active'
	String get tabActive => 'Active';

	/// en: 'Archive'
	String get tabArchive => 'Archive';

	/// en: 'From prescription'
	String get fromPrescription => 'From prescription';

	/// en: 'No schedule set — tap to add reminder times'
	String get noSchedule => 'No schedule set — tap to add reminder times';

	/// en: 'Mon'
	String get dayMon => 'Mon';

	/// en: 'Tue'
	String get dayTue => 'Tue';

	/// en: 'Wed'
	String get dayWed => 'Wed';

	/// en: 'Thu'
	String get dayThu => 'Thu';

	/// en: 'Fri'
	String get dayFri => 'Fri';

	/// en: 'Sat'
	String get daySat => 'Sat';

	/// en: 'Sun'
	String get daySun => 'Sun';

	/// en: 'Medication updated.'
	String get updatedSuccess => 'Medication updated.';

	/// en: 'Medication deleted.'
	String get deletedSuccess => 'Medication deleted.';

	/// en: 'Add at least one reminder time'
	String get atLeastOneTime => 'Add at least one reminder time';
}

// Path: prescriptions
class Translations$prescriptions$en {
	Translations$prescriptions$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Prescriptions'
	String get title => 'Prescriptions';

	/// en: 'Write Prescription'
	String get writeTitle => 'Write Prescription';

	/// en: 'Add Drug'
	String get addDrug => 'Add Drug';

	/// en: 'Drug Name'
	String get drugName => 'Drug Name';

	/// en: 'Dosage'
	String get dosage => 'Dosage';

	/// en: 'Frequency'
	String get frequency => 'Frequency';

	/// en: 'Duration'
	String get duration => 'Duration';

	/// en: 'Instructions'
	String get instructions => 'Instructions';

	/// en: 'Notes'
	String get notes => 'Notes';

	/// en: 'Save'
	String get save => 'Save';

	/// en: 'No prescriptions yet'
	String get empty => 'No prescriptions yet';

	/// en: 'Prescriptions your doctor issues will appear here.'
	String get emptySubtitle => 'Prescriptions your doctor issues will appear here.';

	/// en: 'View Details'
	String get viewDetails => 'View Details';

	/// en: 'Issued by Dr. $name'
	String issuedBy({required Object name}) => 'Issued by Dr. ${name}';

	/// en: 'Issued on $date'
	String issuedOn({required Object date}) => 'Issued on ${date}';

	/// en: 'Add to My Medications'
	String get applyToMedications => 'Add to My Medications';

	/// en: 'Added to your medications. Set up reminder times to get notified.'
	String get applySuccess => 'Added to your medications. Set up reminder times to get notified.';

	/// en: 'Already added to your medications'
	String get alreadyApplied => 'Already added to your medications';

	/// en: 'No prescription for this appointment yet'
	String get noPrescriptionYet => 'No prescription for this appointment yet';

	/// en: 'Write Prescription'
	String get writePrescription => 'Write Prescription';

	/// en: 'Prescription issued.'
	String get prescriptionIssued => 'Prescription issued.';

	/// en: 'Remove'
	String get removeDrug => 'Remove';

	/// en: 'Add at least one drug'
	String get atLeastOneDrug => 'Add at least one drug';

	/// en: 'Drug name is required'
	String get drugNameRequired => 'Drug name is required';

	/// en: 'Prescription'
	String get summaryTitle => 'Prescription';

	/// en: '$count medications'
	String itemsCount({required Object count}) => '${count} medications';

	/// en: 'New Prescription'
	String get newPrescription => 'New Prescription';

	/// en: 'This appointment has a prescription'
	String get youHavePrescription => 'This appointment has a prescription';
}

// Path: records
class Translations$records$en {
	Translations$records$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Health Records'
	String get title => 'Health Records';

	/// en: 'Upload Record'
	String get upload => 'Upload Record';

	/// en: 'Record Type'
	String get recordType => 'Record Type';

	/// en: 'Lab Result'
	String get typeLabResult => 'Lab Result';

	/// en: 'Imaging'
	String get typeImaging => 'Imaging';

	/// en: 'Document'
	String get typeDocument => 'Document';

	/// en: 'Other'
	String get typeOther => 'Other';

	/// en: 'Title'
	String get recordTitle => 'Title';

	/// en: 'Date'
	String get recordDate => 'Date';

	/// en: 'Notes'
	String get notes => 'Notes';

	/// en: 'Choose File'
	String get chooseFile => 'Choose File';

	/// en: 'Change File'
	String get changeFile => 'Change File';

	/// en: 'No file chosen'
	String get noFileChosen => 'No file chosen';

	/// en: 'Save'
	String get save => 'Save';

	/// en: 'Delete'
	String get delete => 'Delete';

	/// en: 'Delete Record'
	String get deleteConfirmTitle => 'Delete Record';

	/// en: 'Are you sure you want to delete this record? This cannot be undone.'
	String get deleteConfirmBody => 'Are you sure you want to delete this record? This cannot be undone.';

	/// en: 'No health records yet'
	String get empty => 'No health records yet';

	/// en: 'Upload lab results, imaging, or other documents to keep them all in one place.'
	String get emptySubtitle => 'Upload lab results, imaging, or other documents to keep them all in one place.';

	/// en: 'View'
	String get view => 'View';

	/// en: 'Choose a file to upload'
	String get fileRequired => 'Choose a file to upload';

	/// en: 'File is too large (max 15 MB)'
	String get fileTooLarge => 'File is too large (max 15 MB)';

	/// en: 'Title is required'
	String get titleRequired => 'Title is required';

	/// en: 'Record uploaded.'
	String get uploadSuccess => 'Record uploaded.';

	/// en: 'Record deleted.'
	String get deletedSuccess => 'Record deleted.';

	/// en: 'Could not open the file'
	String get couldNotOpen => 'Could not open the file';
}

// Path: payments
class Translations$payments$en {
	Translations$payments$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Payment'
	String get title => 'Payment';

	/// en: 'Amount'
	String get amount => 'Amount';

	/// en: 'Pay Now'
	String get payNow => 'Pay Now';

	/// en: 'Pay Later'
	String get payLater => 'Pay Later';

	/// en: 'Payment Pending'
	String get statusPending => 'Payment Pending';

	/// en: 'Paid'
	String get statusPaid => 'Paid';

	/// en: 'Payment Failed'
	String get statusFailed => 'Payment Failed';

	/// en: 'Cancelled'
	String get statusCancelled => 'Cancelled';

	/// en: 'Refunded'
	String get statusRefunded => 'Refunded';

	/// en: 'Refund Failed'
	String get statusRefundFailed => 'Refund Failed';

	/// en: 'Payment confirmed. Thank you!'
	String get paymentConfirmed => 'Payment confirmed. Thank you!';

	/// en: 'Opening your browser…'
	String get openingBrowser => 'Opening your browser…';

	/// en: 'Check Status'
	String get checkStatus => 'Check Status';
}

// Path: family
class Translations$family$en {
	Translations$family$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Family'
	String get title => 'Family';

	/// en: 'Myself'
	String get myself => 'Myself';

	/// en: 'Add Family Member'
	String get addFamilyMember => 'Add Family Member';

	/// en: 'Edit Family Member'
	String get editFamilyMember => 'Edit Family Member';

	/// en: 'First Name'
	String get firstName => 'First Name';

	/// en: 'Last Name'
	String get lastName => 'Last Name';

	/// en: 'Relationship'
	String get relationship => 'Relationship';

	/// en: 'Child'
	String get relationshipChild => 'Child';

	/// en: 'Spouse'
	String get relationshipSpouse => 'Spouse';

	/// en: 'Parent'
	String get relationshipParent => 'Parent';

	/// en: 'Sibling'
	String get relationshipSibling => 'Sibling';

	/// en: 'Other'
	String get relationshipOther => 'Other';

	/// en: 'Date of Birth'
	String get dateOfBirth => 'Date of Birth';

	/// en: 'Blood Type'
	String get bloodType => 'Blood Type';

	/// en: 'Allergies'
	String get allergies => 'Allergies';

	/// en: 'Chronic conditions'
	String get chronicConditions => 'Chronic conditions';

	/// en: 'Current medications'
	String get medications => 'Current medications';

	/// en: 'Save'
	String get save => 'Save';

	/// en: 'Delete'
	String get delete => 'Delete';

	/// en: 'Remove Family Member'
	String get deleteConfirmTitle => 'Remove Family Member';

	/// en: 'Remove this family member? Their appointment, medication, and record history will be kept.'
	String get deleteConfirmBody => 'Remove this family member? Their appointment, medication, and record history will be kept.';

	/// en: 'No family members yet'
	String get empty => 'No family members yet';

	/// en: 'Add a child, spouse, or other family member to manage their appointments, medications, and records.'
	String get emptySubtitle => 'Add a child, spouse, or other family member to manage their appointments, medications, and records.';

	/// en: 'Who is this appointment for?'
	String get bookingForQuestion => 'Who is this appointment for?';

	/// en: 'Booking for: $name'
	String bookingForLabel({required Object name}) => 'Booking for: ${name}';

	/// en: 'for $name'
	String forLabel({required Object name}) => 'for ${name}';

	/// en: '$age years old'
	String ageYears({required Object age}) => '${age} years old';

	/// en: 'Booked by $name'
	String bookedByLabel({required Object name}) => 'Booked by ${name}';

	/// en: 'Contact Email'
	String get contactEmail => 'Contact Email';

	/// en: 'We'll let them know they were added, with an easy way to opt out.'
	String get contactEmailHelp => 'We\'ll let them know they were added, with an easy way to opt out.';

	/// en: 'Contact Phone (optional)'
	String get contactPhoneOptional => 'Contact Phone (optional)';

	/// en: 'An email address is required so we can notify this family member'
	String get contactEmailRequiredForAdult => 'An email address is required so we can notify this family member';

	/// en: 'Since they're 18 or older, we'll email them to let them know you added them — they don't need the app, and they can disconnect this connection at any time.'
	String get adultConsentNotice => 'Since they\'re 18 or older, we\'ll email them to let them know you added them — they don\'t need the app, and they can disconnect this connection at any time.';

	/// en: 'We've let them know they were added. They can disconnect this connection at any time.'
	String get noticeAlreadySent => 'We\'ve let them know they were added. They can disconnect this connection at any time.';

	/// en: 'Notice sent'
	String get noticePendingBadge => 'Notice sent';
}

// Path: subscription
class Translations$subscription$en {
	Translations$subscription$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Subscription'
	String get title => 'Subscription';

	/// en: 'Starter'
	String get planNameBasic => 'Starter';

	/// en: 'Professional'
	String get planNamePro => 'Professional';

	/// en: 'Couldn't load your subscription.'
	String get couldNotLoad => 'Couldn\'t load your subscription.';

	/// en: 'Your subscription is now active!'
	String get nowActive => 'Your subscription is now active!';

	/// en: 'Subscriptions aren't available right now. Please try again later.'
	String get unavailable => 'Subscriptions aren\'t available right now. Please try again later.';

	/// en: 'Free trial — $days day(s) left'
	String trialDaysLeft({required Object days}) => 'Free trial — ${days} day(s) left';

	/// en: 'Grace period — $days day(s) left to renew'
	String graceDaysLeft({required Object days}) => 'Grace period — ${days} day(s) left to renew';

	/// en: 'Your subscription has expired. Subscribe to become visible to patients again.'
	String get expiredNotice => 'Your subscription has expired. Subscribe to become visible to patients again.';

	/// en: 'Your subscription is active.'
	String get activeNotice => 'Your subscription is active.';

	/// en: 'Choose a plan to get started.'
	String get choosePlan => 'Choose a plan to get started.';

	/// en: 'Current Plan'
	String get currentPlan => 'Current Plan';

	/// en: 'Most Popular'
	String get mostPopular => 'Most Popular';

	/// en: 'per month'
	String get perMonth => 'per month';

	/// en: 'Manage your subscription at auxiodev.com'
	String get manageOnWeb => 'Manage your subscription at auxiodev.com';

	/// en: 'Unlimited clinics'
	String get featureUnlimitedWorkplaces => 'Unlimited clinics';

	/// en: 'Up to $count clinic(s)'
	String featureWorkplaces({required Object count}) => 'Up to ${count} clinic(s)';

	/// en: 'Unlimited monthly bookings'
	String get featureUnlimitedBookings => 'Unlimited monthly bookings';

	/// en: 'Up to $count bookings per month'
	String featureBookingsPerMonth({required Object count}) => 'Up to ${count} bookings per month';

	/// en: 'Patient chat'
	String get featureChat => 'Patient chat';

	/// en: 'Priority placement + "Peşəkar" badge'
	String get featurePromoted => 'Priority placement + "Peşəkar" badge';

	/// en: 'Renew'
	String get renew => 'Renew';

	/// en: 'Subscribe'
	String get subscribe => 'Subscribe';

	/// en: 'Clinic'
	String get planNameHospitalBasic => 'Clinic';

	/// en: 'Clinic Plus'
	String get planNameHospitalPro => 'Clinic Plus';

	/// en: 'Up to $count doctor(s)'
	String featureDoctors({required Object count}) => 'Up to ${count} doctor(s)';

	/// en: 'Unlimited doctors'
	String get featureUnlimitedDoctors => 'Unlimited doctors';

	/// en: 'Advanced statistics'
	String get featureAdvancedStats => 'Advanced statistics';
}

// Path: hospitalPicker
class Translations$hospitalPicker$en {
	Translations$hospitalPicker$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Select Hospital'
	String get title => 'Select Hospital';

	/// en: 'Search hospital name…'
	String get searchHint => 'Search hospital name…';

	/// en: 'No hospitals found'
	String get noResultsFound => 'No hospitals found';

	/// en: 'Select a city first'
	String get selectCityFirst => 'Select a city first';

	/// en: 'Add "$name"'
	String addVariant({required Object name}) => 'Add "${name}"';

	/// en: 'Pending review'
	String get pendingReview => 'Pending review';
}

// Path: hospitalRegistration
class Translations$hospitalRegistration$en {
	Translations$hospitalRegistration$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Hospital Details'
	String get title => 'Hospital Details';

	/// en: 'Select your city, then find your hospital below or add it.'
	String get subtitle => 'Select your city, then find your hospital below or add it.';

	/// en: '1. City'
	String get cityStep => '1. City';

	/// en: '2. Hospital'
	String get hospitalStep => '2. Hospital';

	/// en: 'Search hospital name…'
	String get searchHint => 'Search hospital name…';

	/// en: 'No hospitals found'
	String get noResultsFound => 'No hospitals found';

	/// en: 'Can't find your hospital?'
	String get notFoundPrompt => 'Can\'t find your hospital?';

	/// en: 'Add it manually'
	String get addManually => 'Add it manually';

	/// en: 'Search instead'
	String get useSearchInstead => 'Search instead';

	/// en: 'Hospital name'
	String get newHospitalName => 'Hospital name';

	/// en: 'Selected:'
	String get selectedPrefix => 'Selected:';

	/// en: 'New hospitals are reviewed by our team before appearing elsewhere.'
	String get pendingReviewNotice => 'New hospitals are reviewed by our team before appearing elsewhere.';

	/// en: 'Create Account'
	String get submit => 'Create Account';

	/// en: 'Select or add your hospital to continue'
	String get hospitalRequired => 'Select or add your hospital to continue';
}

// Path: hospitalHome
class Translations$hospitalHome$en {
	Translations$hospitalHome$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Hello, $name'
	String greeting({required Object name}) => 'Hello, ${name}';

	/// en: 'Manage your doctors and appointments'
	String get subtitle => 'Manage your doctors and appointments';

	/// en: 'Doctors'
	String get doctors => 'Doctors';

	/// en: 'Invite Doctor'
	String get inviteDoctor => 'Invite Doctor';

	/// en: 'Appointments'
	String get appointments => 'Appointments';

	/// en: 'Profile'
	String get profile => 'Profile';

	/// en: '$count pending request(s)'
	String pendingRequests({required Object count}) => '${count} pending request(s)';
}

// Path: hospitalDoctors
class Translations$hospitalDoctors$en {
	Translations$hospitalDoctors$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Doctors'
	String get title => 'Doctors';

	/// en: 'Confirmed'
	String get tabConfirmed => 'Confirmed';

	/// en: 'Requests'
	String get tabRequests => 'Requests';

	/// en: 'Invited'
	String get tabInvited => 'Invited';

	/// en: 'No confirmed doctors yet'
	String get noConfirmedDoctors => 'No confirmed doctors yet';

	/// en: 'No pending requests'
	String get noRequests => 'No pending requests';

	/// en: 'No pending invites'
	String get noInvited => 'No pending invites';

	/// en: 'Approve'
	String get approve => 'Approve';

	/// en: 'Reject'
	String get reject => 'Reject';

	/// en: 'Remove'
	String get remove => 'Remove';

	/// en: 'Remove doctor?'
	String get removeConfirmTitle => 'Remove doctor?';

	/// en: '$name will no longer be affiliated with your hospital. Their workplace and appointments are not affected.'
	String removeConfirmMessage({required Object name}) => '${name} will no longer be affiliated with your hospital. Their workplace and appointments are not affected.';

	/// en: 'Requested to join'
	String get requestedToJoin => 'Requested to join';

	/// en: 'Invited — awaiting response'
	String get invitedAwaiting => 'Invited — awaiting response';

	/// en: 'Edit hours'
	String get editHours => 'Edit hours';
}

// Path: hospitalInvite
class Translations$hospitalInvite$en {
	Translations$hospitalInvite$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Invite a Doctor'
	String get title => 'Invite a Doctor';

	/// en: 'Search by name or specialization…'
	String get searchHint => 'Search by name or specialization…';

	/// en: 'No doctors found'
	String get noResultsFound => 'No doctors found';

	/// en: 'Invite'
	String get invite => 'Invite';

	/// en: 'Invited'
	String get invited => 'Invited';
}

// Path: hospitalAppointments
class Translations$hospitalAppointments$en {
	Translations$hospitalAppointments$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Appointments'
	String get title => 'Appointments';

	/// en: 'No appointments yet'
	String get empty => 'No appointments yet';
}

// Path: hospitalProfile
class Translations$hospitalProfile$en {
	Translations$hospitalProfile$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Hospital Profile'
	String get title => 'Hospital Profile';

	/// en: '$count of $limit doctors'
	String usageDoctors({required Object count, required Object limit}) => '${count} of ${limit} doctors';

	/// en: '$count doctors (unlimited)'
	String usageDoctorsUnlimited({required Object count}) => '${count} doctors (unlimited)';

	/// en: 'Manage Subscription'
	String get manageSubscription => 'Manage Subscription';
}

// Path: hospitalDoctorHours
class Translations$hospitalDoctorHours$en {
	Translations$hospitalDoctorHours$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Working Hours'
	String get title => 'Working Hours';

	/// en: 'Select a workplace'
	String get selectWorkplace => 'Select a workplace';

	/// en: 'Hours saved'
	String get saved => 'Hours saved';
}

// Path: doctorHospitals
class Translations$doctorHospitals$en {
	Translations$doctorHospitals$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'My Hospitals'
	String get title => 'My Hospitals';

	/// en: 'Invitations'
	String get tabInvitations => 'Invitations';

	/// en: 'Requests'
	String get tabRequests => 'Requests';

	/// en: 'Hospitals'
	String get tabConfirmed => 'Hospitals';

	/// en: 'No pending invitations'
	String get noInvitations => 'No pending invitations';

	/// en: 'No pending requests'
	String get noRequests => 'No pending requests';

	/// en: 'You're not affiliated with any hospital yet'
	String get noConfirmed => 'You\'re not affiliated with any hospital yet';

	/// en: 'Accept'
	String get accept => 'Accept';

	/// en: 'Decline'
	String get decline => 'Decline';

	/// en: 'Cancel request'
	String get cancelRequest => 'Cancel request';

	/// en: 'Invited you to join'
	String get invitedYouToJoin => 'Invited you to join';

	/// en: 'Awaiting hospital approval'
	String get awaitingApproval => 'Awaiting hospital approval';
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

// Path: legal.sections
class Translations$legal$sections$en {
	Translations$legal$sections$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$legal$sections$identity$en identity = Translations$legal$sections$identity$en.internal(_root);
	late final Translations$legal$sections$health$en health = Translations$legal$sections$health$en.internal(_root);
	late final Translations$legal$sections$professional$en professional = Translations$legal$sections$professional$en.internal(_root);
	late final Translations$legal$sections$location$en location = Translations$legal$sections$location$en.internal(_root);
	late final Translations$legal$sections$device$en device = Translations$legal$sections$device$en.internal(_root);
	late final Translations$legal$sections$payment$en payment = Translations$legal$sections$payment$en.internal(_root);
	late final Translations$legal$sections$family$en family = Translations$legal$sections$family$en.internal(_root);
	late final Translations$legal$sections$purposes$en purposes = Translations$legal$sections$purposes$en.internal(_root);
	late final Translations$legal$sections$legalBasis$en legalBasis = Translations$legal$sections$legalBasis$en.internal(_root);
	late final Translations$legal$sections$thirdParties$en thirdParties = Translations$legal$sections$thirdParties$en.internal(_root);
	late final Translations$legal$sections$retention$en retention = Translations$legal$sections$retention$en.internal(_root);
	late final Translations$legal$sections$rights$en rights = Translations$legal$sections$rights$en.internal(_root);
	late final Translations$legal$sections$security$en security = Translations$legal$sections$security$en.internal(_root);
	late final Translations$legal$sections$permissions$en permissions = Translations$legal$sections$permissions$en.internal(_root);
	late final Translations$legal$sections$children$en children = Translations$legal$sections$children$en.internal(_root);
}

// Path: legal.sections.identity
class Translations$legal$sections$identity$en {
	Translations$legal$sections$identity$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Identity data'
	String get title => 'Identity data';

	/// en: 'Full name, email address, phone number (optional), your password (stored as an irreversible hash, never in plain text), and your preferred app language.'
	String get body => 'Full name, email address, phone number (optional), your password (stored as an irreversible hash, never in plain text), and your preferred app language.';
}

// Path: legal.sections.health
class Translations$legal$sections$health$en {
	Translations$legal$sections$health$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Health data'
	String get title => 'Health data';

	/// en: 'As a patient: blood type, allergies, chronic conditions, current medications, the reason you give when booking an appointment, medical documents you upload (lab results, imaging, other records), prescriptions issued to you, and the content of your messages with your doctor. If you use the AI symptom-checking assistant, your questions and its responses are processed the same way. Health data receives the highest level of protection under Azerbaijani law, and we only collect it with your separate, explicit consent (see "Legal basis" below).'
	String get body => 'As a patient: blood type, allergies, chronic conditions, current medications, the reason you give when booking an appointment, medical documents you upload (lab results, imaging, other records), prescriptions issued to you, and the content of your messages with your doctor. If you use the AI symptom-checking assistant, your questions and its responses are processed the same way. Health data receives the highest level of protection under Azerbaijani law, and we only collect it with your separate, explicit consent (see "Legal basis" below).';
}

// Path: legal.sections.professional
class Translations$legal$sections$professional$en {
	Translations$legal$sections$professional$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Professional data (doctors)'
	String get title => 'Professional data (doctors)';

	/// en: 'Medical specialization, licence number, diploma or other verification document, workplace details, and consultation fee. This is reviewed by our team before your profile becomes visible to patients.'
	String get body => 'Medical specialization, licence number, diploma or other verification document, workplace details, and consultation fee. This is reviewed by our team before your profile becomes visible to patients.';
}

// Path: legal.sections.location
class Translations$legal$sections$location$en {
	Translations$legal$sections$location$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Location'
	String get title => 'Location';

	/// en: 'With your permission, an approximate or precise location so we can sort doctors by distance from you. Used only while the app is open — never stored on our servers.'
	String get body => 'With your permission, an approximate or precise location so we can sort doctors by distance from you. Used only while the app is open — never stored on our servers.';
}

// Path: legal.sections.device
class Translations$legal$sections$device$en {
	Translations$legal$sections$device$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Device & technical data'
	String get title => 'Device & technical data';

	/// en: 'Device identifiers and session information, so you can see and revoke your active logins from Settings, and a push-notification token so we can deliver appointment reminders and messages to your device.'
	String get body => 'Device identifiers and session information, so you can see and revoke your active logins from Settings, and a push-notification token so we can deliver appointment reminders and messages to your device.';
}

// Path: legal.sections.payment
class Translations$legal$sections$payment$en {
	Translations$legal$sections$payment$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Payment data'
	String get title => 'Payment data';

	/// en: 'If you pay for a consultation in-app, payment is processed entirely by our payment partner, Payriff — we never see or store your card number. We keep the payment amount, status, and a reference id for your appointment history.'
	String get body => 'If you pay for a consultation in-app, payment is processed entirely by our payment partner, Payriff — we never see or store your card number. We keep the payment amount, status, and a reference id for your appointment history.';
}

// Path: legal.sections.family
class Translations$legal$sections$family$en {
	Translations$legal$sections$family$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Family / dependent profiles'
	String get title => 'Family / dependent profiles';

	/// en: 'If you manage a family member's profile (a child, or a dependent without their own login), the same health data categories above may be recorded for them under your account. By adding a dependent, you confirm you are their parent, guardian, or otherwise authorized to manage their healthcare information on their behalf.'
	String get body => 'If you manage a family member\'s profile (a child, or a dependent without their own login), the same health data categories above may be recorded for them under your account. By adding a dependent, you confirm you are their parent, guardian, or otherwise authorized to manage their healthcare information on their behalf.';
}

// Path: legal.sections.purposes
class Translations$legal$sections$purposes$en {
	Translations$legal$sections$purposes$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Why we use your data'
	String get title => 'Why we use your data';

	/// en: 'To let you find and book appointments with doctors; let doctors manage their schedule and patients; send appointment reminders and updates; process payments for consultations; provide the optional AI symptom-checking feature; and keep your account secure.'
	String get body => 'To let you find and book appointments with doctors; let doctors manage their schedule and patients; send appointment reminders and updates; process payments for consultations; provide the optional AI symptom-checking feature; and keep your account secure.';
}

// Path: legal.sections.legalBasis
class Translations$legal$sections$legalBasis$en {
	Translations$legal$sections$legalBasis$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Legal basis and your consent'
	String get title => 'Legal basis and your consent';

	/// en: 'We process your data on the basis of your consent, given when you register. Health data is a special category of personal data under the Law of the Republic of Azerbaijan "On Personal Data" (No. 998-IIIQ), which requires your explicit, written consent before we collect it — this is what the checkbox on the registration screen records. You may withdraw consent at any time by deleting your account, though we may keep limited records where required by law (for example, financial records for tax purposes).'
	String get body => 'We process your data on the basis of your consent, given when you register. Health data is a special category of personal data under the Law of the Republic of Azerbaijan "On Personal Data" (No. 998-IIIQ), which requires your explicit, written consent before we collect it — this is what the checkbox on the registration screen records. You may withdraw consent at any time by deleting your account, though we may keep limited records where required by law (for example, financial records for tax purposes).';
}

// Path: legal.sections.thirdParties
class Translations$legal$sections$thirdParties$en {
	Translations$legal$sections$thirdParties$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Who else processes your data'
	String get title => 'Who else processes your data';

	/// en: 'Trusted service providers acting only on our instructions, for the purposes described here: Cloudinary (secure file storage — documents and photos are never publicly accessible, only through signed, time-limited links); Firebase/Google (push notifications, and Google sign-in if you choose it); Apple (Sign in with Apple, if you choose it); Payriff (in-app payments). We do not sell your personal data.'
	String get body => 'Trusted service providers acting only on our instructions, for the purposes described here: Cloudinary (secure file storage — documents and photos are never publicly accessible, only through signed, time-limited links); Firebase/Google (push notifications, and Google sign-in if you choose it); Apple (Sign in with Apple, if you choose it); Payriff (in-app payments). We do not sell your personal data.';
}

// Path: legal.sections.retention
class Translations$legal$sections$retention$en {
	Translations$legal$sections$retention$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'How long we keep your data'
	String get title => 'How long we keep your data';

	/// en: 'For as long as your account is active. If you delete your account, we remove your personal data within a reasonable period, except records we are legally required to keep (for example, payment records for tax purposes).'
	String get body => 'For as long as your account is active. If you delete your account, we remove your personal data within a reasonable period, except records we are legally required to keep (for example, payment records for tax purposes).';
}

// Path: legal.sections.rights
class Translations$legal$sections$rights$en {
	Translations$legal$sections$rights$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Your rights'
	String get title => 'Your rights';

	/// en: 'You may access the data we hold about you, request correction of inaccurate data, request deletion of your account and data, and withdraw consent at any time. Most of this is available directly under Profile > Settings; for anything else, contact us below.'
	String get body => 'You may access the data we hold about you, request correction of inaccurate data, request deletion of your account and data, and withdraw consent at any time. Most of this is available directly under Profile > Settings; for anything else, contact us below.';
}

// Path: legal.sections.security
class Translations$legal$sections$security$en {
	Translations$legal$sections$security$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'How we protect your data'
	String get title => 'How we protect your data';

	/// en: 'Messages between you and your doctor, and AI assistant conversations, are encrypted. Uploaded documents and photos are stored privately, accessible only through secure signed links, never as public files. Passwords are never stored in readable form.'
	String get body => 'Messages between you and your doctor, and AI assistant conversations, are encrypted. Uploaded documents and photos are stored privately, accessible only through secure signed links, never as public files. Passwords are never stored in readable form.';
}

// Path: legal.sections.permissions
class Translations$legal$sections$permissions$en {
	Translations$legal$sections$permissions$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Permissions we ask for'
	String get title => 'Permissions we ask for';

	/// en: 'Camera and photo library — to set a profile picture and upload medical documents. Location — to sort doctors by distance from you. Notifications — to deliver appointment reminders and messages. Biometrics (Face ID / fingerprint) — an optional, faster way to unlock the app; your biometric data never leaves your device, we only receive a yes/no confirmation from its operating system.'
	String get body => 'Camera and photo library — to set a profile picture and upload medical documents. Location — to sort doctors by distance from you. Notifications — to deliver appointment reminders and messages. Biometrics (Face ID / fingerprint) — an optional, faster way to unlock the app; your biometric data never leaves your device, we only receive a yes/no confirmation from its operating system.';
}

// Path: legal.sections.children
class Translations$legal$sections$children$en {
	Translations$legal$sections$children$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Age requirement'
	String get title => 'Age requirement';

	/// en: 'DocLine accounts are intended for adults. If you are under 18, please have a parent or guardian create and manage an account on your behalf using the family/dependent profile feature.'
	String get body => 'DocLine accounts are intended for adults. If you are under 18, please have a parent or guardian create and manage an account on your behalf using the family/dependent profile feature.';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'appName' => 'DocLine',
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
			'common.hospital' => 'Hospital',
			'auth.login' => 'Sign In',
			'auth.register' => 'Create Account',
			'auth.signIn' => 'Sign In',
			'auth.signUp' => 'Sign Up',
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
			'auth.joinMedalize' => 'Join DocLine today',
			'auth.iAmA' => 'I am a',
			'auth.passwordHint' => '••••••••',
			'auth.backToSignIn' => 'Back to Sign In',
			'auth.verificationCode' => 'Verification code',
			'auth.continueWithGoogle' => 'Continue with Google',
			'auth.continueWithApple' => 'Continue with Apple',
			'auth.orDivider' => 'or',
			'forgotPassword.title' => 'Forgot Password?',
			'forgotPassword.subtitle' => 'Enter your phone number and we\'ll send you a 6-digit reset code',
			'resetPassword.title' => 'Reset Password',
			'resetPassword.subtitle' => 'Enter the code sent to your phone and choose a new password',
			'resetPassword.button' => 'Reset Password',
			'resetPassword.success' => 'Password reset successfully. Please sign in.',
			'verifyPhone.title' => 'Verify Your Phone',
			'verifyPhone.subtitle' => ({required Object phone}) => 'We\'ve sent a 6-digit code to ${phone}',
			'verifyPhone.button' => 'Verify',
			'verifyPhone.resend' => 'Resend code',
			'verifyPhone.resendSent' => 'A new code has been sent.',
			'socialComplete.title' => 'Almost there',
			'socialComplete.subtitle' => 'Enter and verify a phone number to finish creating your account.',
			'socialComplete.button' => 'Continue',
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
			'errors.invalidCredentials' => 'Invalid phone number or password',
			'errors.sessionExpired' => 'Session expired. Please sign in again.',
			'errors.authError' => 'Authentication error. Please sign in again.',
			'errors.sessionRevoked' => 'Session was revoked. Please sign in again.',
			'errors.permissionDenied' => 'You do not have permission to do this.',
			'errors.validationError' => 'Validation error',
			'errors.serverError' => ({required Object code}) => 'Server error (${code}). Please try again.',
			'errors.socialLoginFailed' => 'Sign-in failed. Please try again or use your phone number and password.',
			'errors.conflict' => 'This action can\'t be completed right now.',
			'errors.onboardingIncomplete' => 'Please complete all required fields before finishing onboarding.',
			'errors.planLimitReached' => 'You\'ve reached your plan\'s limit. Upgrade to add more.',
			'errors.chatUnavailable' => 'This doctor doesn\'t offer chat on their current plan.',
			'errors.phoneNotVerified' => 'Please verify your phone number before signing in.',
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
			'settings.version' => 'DocLine v1.0.0',
			'settings.legal' => 'Privacy & Terms',
			'security.title' => 'Security',
			'security.biometricLogin' => 'Biometric Login',
			'security.biometricLoginSubtitle' => 'Use Face ID / Touch ID to unlock the app',
			'security.biometricPrompt' => 'Authenticate to access DocLine',
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
			'security.changePhone' => 'Change Phone Number',
			'security.changePhoneSubtitle' => 'We\'ll send a verification code to your new phone number. After confirming, you\'ll sign in with the new number.',
			'security.sendCode' => 'Send Code',
			'security.codeSentTo' => ({required Object phone}) => 'Enter the 6-digit code we sent to ${phone}',
			'security.confirmNewPhone' => 'Confirm New Phone Number',
			'security.changePhoneSuccess' => 'Your phone number has been changed. Please sign in again with your new number.',
			'security.dangerZone' => 'Danger Zone',
			'security.deactivateAccount' => 'Deactivate Account',
			'security.deactivateAccountSubtitle' => 'Disable your account without deleting your data',
			'security.deactivateConfirmTitle' => 'Deactivate account?',
			'security.deactivateConfirmMessage' => 'Your account will be deactivated and you will be signed out on all devices. Your data will not be deleted. Contact support to reactivate your account.',
			'security.deactivate' => 'Deactivate',
			'security.deactivateSuccess' => 'Your account has been deactivated.',
			'security.deleteAccount' => 'Delete Account Permanently',
			'security.deleteAccountSubtitle' => 'Erase your data. This cannot be undone.',
			'security.deleteConfirmTitle' => 'Delete your account permanently?',
			'security.deleteConfirmWarning' => 'This action is permanent and cannot be undone.',
			'security.deleteConfirmMessage' => 'Your profile, medical records, prescriptions, and messages will be permanently erased. Any upcoming appointments will be cancelled and refunded where eligible. Payment records are kept in anonymized form for accounting purposes as required by law.',
			'security.deleteAccountSuccess' => 'Your account has been permanently deleted.',
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
			'appointments.cancelledSuccess' => 'Appointment cancelled.',
			'appointments.cancelledRefunded' => 'Appointment cancelled. Your payment has been refunded.',
			'appointments.cancelledNoRefund' => 'Appointment cancelled. No refund was issued — this was too close to the appointment time.',
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
			'appointments.disputeNoShow' => 'Dispute this',
			'appointments.disputeNoShowTitle' => 'Dispute No-show',
			'appointments.disputeNoShowHint' => 'Tell us why you think this was marked incorrectly — our support team will review it.',
			'appointments.disputeNoShowSubmit' => 'Submit',
			'appointments.disputeNoShowSubmitted' => 'Your dispute has been submitted. We\'ll review it and get back to you.',
			'appointments.disputeNoShowOpen' => 'Dispute submitted — under review',
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
			'doctorSearch.loadMore' => 'Load more',
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
			'notifications.categoriesTitle' => 'Push categories',
			'notifications.careCategory' => 'Appointments & care',
			'notifications.careCategorySubtitle' => 'Bookings, reminders, prescriptions',
			'notifications.messagesCategory' => 'Messages',
			'notifications.messagesCategorySubtitle' => 'New chat messages',
			'notifications.accountCategory' => 'Account & billing',
			'notifications.accountCategorySubtitle' => 'Verification, payments, subscription',
			'notifications.quietHoursTitle' => 'Quiet hours',
			'notifications.quietHoursEnabled' => 'Enable quiet hours',
			'notifications.quietHoursSubtitle' => 'Pause push notifications during this window',
			'notifications.quietHoursStart' => 'Start',
			'notifications.quietHoursEnd' => 'End',
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
			'addWorkplace.address' => 'Street Address',
			'addWorkplace.city' => 'City',
			'addWorkplace.type' => 'Type',
			'addWorkplace.clinic' => 'Clinic',
			'addWorkplace.hospital' => 'Hospital',
			'addWorkplace.privatePractice' => 'Private Practice',
			'addWorkplace.failedToSave' => 'Failed to save workplace.',
			'addWorkplace.addButton' => 'Add Workplace',
			'addWorkplace.saveChanges' => 'Save Changes',
			'addWorkplace.pickOnMap' => 'Pick on Map',
			'addWorkplace.mapPickerTitle' => 'Choose Location',
			'addWorkplace.useMyLocation' => 'Use my location',
			'addWorkplace.confirmLocation' => 'Confirm Location',
			'addWorkplace.locationSet' => 'Location set from map ✓',
			'addWorkplace.locationPermissionDenied' => 'Location permission is needed to use your current position. You can still move the map manually.',
			'addWorkplace.locationUnavailable' => 'Couldn\'t get your location. You can still move the map manually.',
			'workingHours.title' => 'Working Hours',
			'workingHours.sectionHint' => 'Set the days and hours patients can book you at this location.',
			'workingHours.invalidRange' => 'End time must be after start time for each active day.',
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
			'phoneField.selectCountry' => 'Select Country',
			'phoneField.searchCountry' => 'Search country or code…',
			'phoneField.noCountriesFound' => 'No countries found',
			'locations.pickCity' => 'Select City',
			'locations.searchHint' => 'Search city or region…',
			'locations.noResultsFound' => 'No cities found',
			'locations.couldNotLoad' => 'Could not load cities. Tap to retry.',
			'locations.allCities' => 'All cities',
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
			'assistant.topicsTooltip' => 'Topics',
			'assistant.topicsSheetTitle' => 'Choose a topic',
			'messaging.title' => 'Messages',
			'messaging.sendMessage' => 'Message',
			'messaging.typeMessage' => 'Type a message…',
			'messaging.send' => 'Send',
			'messaging.empty' => 'No conversations yet',
			'messaging.emptySubtitle' => 'Your conversations will appear here.',
			'messaging.disclaimer' => 'This is not an emergency line. For urgent issues, call emergency services.',
			'messaging.noSharedHistory' => 'You can message a doctor once you have a shared appointment history.',
			'messaging.newMessage' => 'You have a new message',
			'legal.title' => 'Privacy & Terms',
			'legal.controllerNotice' => 'DocLine is created and operated by AuxioDev (auxiodev.com), Azerbaijan ("we", "us"). Last updated: July 2026.',
			'legal.privacyTitle' => 'Privacy Policy',
			'legal.privacyIntro' => 'This policy explains what personal data DocLine collects, why, and how it is protected. Booking and managing medical appointments necessarily involves health information about you, so we explain that in detail below.',
			'legal.sections.identity.title' => 'Identity data',
			'legal.sections.identity.body' => 'Full name, email address, phone number (optional), your password (stored as an irreversible hash, never in plain text), and your preferred app language.',
			'legal.sections.health.title' => 'Health data',
			'legal.sections.health.body' => 'As a patient: blood type, allergies, chronic conditions, current medications, the reason you give when booking an appointment, medical documents you upload (lab results, imaging, other records), prescriptions issued to you, and the content of your messages with your doctor. If you use the AI symptom-checking assistant, your questions and its responses are processed the same way. Health data receives the highest level of protection under Azerbaijani law, and we only collect it with your separate, explicit consent (see "Legal basis" below).',
			'legal.sections.professional.title' => 'Professional data (doctors)',
			'legal.sections.professional.body' => 'Medical specialization, licence number, diploma or other verification document, workplace details, and consultation fee. This is reviewed by our team before your profile becomes visible to patients.',
			'legal.sections.location.title' => 'Location',
			'legal.sections.location.body' => 'With your permission, an approximate or precise location so we can sort doctors by distance from you. Used only while the app is open — never stored on our servers.',
			'legal.sections.device.title' => 'Device & technical data',
			'legal.sections.device.body' => 'Device identifiers and session information, so you can see and revoke your active logins from Settings, and a push-notification token so we can deliver appointment reminders and messages to your device.',
			'legal.sections.payment.title' => 'Payment data',
			'legal.sections.payment.body' => 'If you pay for a consultation in-app, payment is processed entirely by our payment partner, Payriff — we never see or store your card number. We keep the payment amount, status, and a reference id for your appointment history.',
			'legal.sections.family.title' => 'Family / dependent profiles',
			'legal.sections.family.body' => 'If you manage a family member\'s profile (a child, or a dependent without their own login), the same health data categories above may be recorded for them under your account. By adding a dependent, you confirm you are their parent, guardian, or otherwise authorized to manage their healthcare information on their behalf.',
			'legal.sections.purposes.title' => 'Why we use your data',
			'legal.sections.purposes.body' => 'To let you find and book appointments with doctors; let doctors manage their schedule and patients; send appointment reminders and updates; process payments for consultations; provide the optional AI symptom-checking feature; and keep your account secure.',
			'legal.sections.legalBasis.title' => 'Legal basis and your consent',
			'legal.sections.legalBasis.body' => 'We process your data on the basis of your consent, given when you register. Health data is a special category of personal data under the Law of the Republic of Azerbaijan "On Personal Data" (No. 998-IIIQ), which requires your explicit, written consent before we collect it — this is what the checkbox on the registration screen records. You may withdraw consent at any time by deleting your account, though we may keep limited records where required by law (for example, financial records for tax purposes).',
			'legal.sections.thirdParties.title' => 'Who else processes your data',
			'legal.sections.thirdParties.body' => 'Trusted service providers acting only on our instructions, for the purposes described here: Cloudinary (secure file storage — documents and photos are never publicly accessible, only through signed, time-limited links); Firebase/Google (push notifications, and Google sign-in if you choose it); Apple (Sign in with Apple, if you choose it); Payriff (in-app payments). We do not sell your personal data.',
			'legal.sections.retention.title' => 'How long we keep your data',
			'legal.sections.retention.body' => 'For as long as your account is active. If you delete your account, we remove your personal data within a reasonable period, except records we are legally required to keep (for example, payment records for tax purposes).',
			'legal.sections.rights.title' => 'Your rights',
			'legal.sections.rights.body' => 'You may access the data we hold about you, request correction of inaccurate data, request deletion of your account and data, and withdraw consent at any time. Most of this is available directly under Profile > Settings; for anything else, contact us below.',
			'legal.sections.security.title' => 'How we protect your data',
			_ => null,
		} ?? switch (path) {
			'legal.sections.security.body' => 'Messages between you and your doctor, and AI assistant conversations, are encrypted. Uploaded documents and photos are stored privately, accessible only through secure signed links, never as public files. Passwords are never stored in readable form.',
			'legal.sections.permissions.title' => 'Permissions we ask for',
			'legal.sections.permissions.body' => 'Camera and photo library — to set a profile picture and upload medical documents. Location — to sort doctors by distance from you. Notifications — to deliver appointment reminders and messages. Biometrics (Face ID / fingerprint) — an optional, faster way to unlock the app; your biometric data never leaves your device, we only receive a yes/no confirmation from its operating system.',
			'legal.sections.children.title' => 'Age requirement',
			'legal.sections.children.body' => 'DocLine accounts are intended for adults. If you are under 18, please have a parent or guardian create and manage an account on your behalf using the family/dependent profile feature.',
			'legal.termsTitle' => 'Terms of Service',
			'legal.termsIntro' => 'By creating an account, you agree to the following.',
			'legal.termsBody' => 'Provide accurate information about yourself. Use DocLine only for finding, booking, and managing medical appointments. Keep your login credentials confidential. DocLine connects you with independent, licensed medical professionals — we are not a medical provider ourselves, and the AI symptom-checking assistant does not replace professional medical diagnosis or advice. In a medical emergency, contact emergency services directly, not this app. We may suspend or terminate accounts that violate these terms or misuse the platform.',
			'legal.contact' => 'Questions about your data? Contact support@auxiodev.com',
			'legal.consentPrefix' => 'I have read and agree to the ',
			'legal.consentPrivacyLink' => 'Privacy Policy',
			'legal.consentMiddle' => ' and ',
			'legal.consentTermsLink' => 'Terms of Service',
			'legal.consentSuffix' => ', and I explicitly consent to the processing of my health data as described.',
			'legal.viewAsPdf' => 'View as PDF',
			'legal.pdfDocumentTitle' => 'DocLine — Privacy Policy & Terms of Service',
			'legal.pdfLoadError' => 'Could not load the document. Please check your internet connection and try again.',
			'medications.title' => 'Medications',
			'medications.editMedication' => 'Edit Medication',
			'medications.name' => 'Name',
			'medications.dosage' => 'Dosage',
			'medications.notes' => 'Notes',
			'medications.form' => 'Form',
			'medications.formPill' => 'Pill',
			'medications.formCapsule' => 'Capsule',
			'medications.formLiquid' => 'Liquid',
			'medications.formInjection' => 'Injection',
			'medications.formOther' => 'Other',
			'medications.schedule' => 'Schedule',
			'medications.times' => 'Times',
			'medications.addTime' => 'Add Time',
			'medications.daysOfWeek' => 'Days of Week',
			'medications.everyDay' => 'Every day',
			'medications.startDate' => 'Start Date',
			'medications.endDate' => 'End Date',
			'medications.save' => 'Save',
			'medications.delete' => 'Delete',
			'medications.deleteConfirmTitle' => 'Delete Medication',
			'medications.deleteConfirmBody' => 'Are you sure you want to delete this medication? Its dose history will be kept.',
			'medications.emptyTitle' => 'No medications yet',
			'medications.emptySubtitle' => 'Medications your doctor prescribes will appear here after your appointment.',
			'medications.todaysDoses' => 'Today\'s Doses',
			'medications.markTaken' => 'Taken',
			'medications.markSkipped' => 'Skip',
			'medications.statusTaken' => 'Taken',
			'medications.statusSkipped' => 'Skipped',
			'medications.statusPending' => 'Pending',
			'medications.reminderTitle' => ({required Object name}) => 'Time to take ${name}',
			'medications.reminderBody' => ({required Object dosage}) => 'Dose: ${dosage}',
			'medications.tabActive' => 'Active',
			'medications.tabArchive' => 'Archive',
			'medications.fromPrescription' => 'From prescription',
			'medications.noSchedule' => 'No schedule set — tap to add reminder times',
			'medications.dayMon' => 'Mon',
			'medications.dayTue' => 'Tue',
			'medications.dayWed' => 'Wed',
			'medications.dayThu' => 'Thu',
			'medications.dayFri' => 'Fri',
			'medications.daySat' => 'Sat',
			'medications.daySun' => 'Sun',
			'medications.updatedSuccess' => 'Medication updated.',
			'medications.deletedSuccess' => 'Medication deleted.',
			'medications.atLeastOneTime' => 'Add at least one reminder time',
			'prescriptions.title' => 'Prescriptions',
			'prescriptions.writeTitle' => 'Write Prescription',
			'prescriptions.addDrug' => 'Add Drug',
			'prescriptions.drugName' => 'Drug Name',
			'prescriptions.dosage' => 'Dosage',
			'prescriptions.frequency' => 'Frequency',
			'prescriptions.duration' => 'Duration',
			'prescriptions.instructions' => 'Instructions',
			'prescriptions.notes' => 'Notes',
			'prescriptions.save' => 'Save',
			'prescriptions.empty' => 'No prescriptions yet',
			'prescriptions.emptySubtitle' => 'Prescriptions your doctor issues will appear here.',
			'prescriptions.viewDetails' => 'View Details',
			'prescriptions.issuedBy' => ({required Object name}) => 'Issued by Dr. ${name}',
			'prescriptions.issuedOn' => ({required Object date}) => 'Issued on ${date}',
			'prescriptions.applyToMedications' => 'Add to My Medications',
			'prescriptions.applySuccess' => 'Added to your medications. Set up reminder times to get notified.',
			'prescriptions.alreadyApplied' => 'Already added to your medications',
			'prescriptions.noPrescriptionYet' => 'No prescription for this appointment yet',
			'prescriptions.writePrescription' => 'Write Prescription',
			'prescriptions.prescriptionIssued' => 'Prescription issued.',
			'prescriptions.removeDrug' => 'Remove',
			'prescriptions.atLeastOneDrug' => 'Add at least one drug',
			'prescriptions.drugNameRequired' => 'Drug name is required',
			'prescriptions.summaryTitle' => 'Prescription',
			'prescriptions.itemsCount' => ({required Object count}) => '${count} medications',
			'prescriptions.newPrescription' => 'New Prescription',
			'prescriptions.youHavePrescription' => 'This appointment has a prescription',
			'records.title' => 'Health Records',
			'records.upload' => 'Upload Record',
			'records.recordType' => 'Record Type',
			'records.typeLabResult' => 'Lab Result',
			'records.typeImaging' => 'Imaging',
			'records.typeDocument' => 'Document',
			'records.typeOther' => 'Other',
			'records.recordTitle' => 'Title',
			'records.recordDate' => 'Date',
			'records.notes' => 'Notes',
			'records.chooseFile' => 'Choose File',
			'records.changeFile' => 'Change File',
			'records.noFileChosen' => 'No file chosen',
			'records.save' => 'Save',
			'records.delete' => 'Delete',
			'records.deleteConfirmTitle' => 'Delete Record',
			'records.deleteConfirmBody' => 'Are you sure you want to delete this record? This cannot be undone.',
			'records.empty' => 'No health records yet',
			'records.emptySubtitle' => 'Upload lab results, imaging, or other documents to keep them all in one place.',
			'records.view' => 'View',
			'records.fileRequired' => 'Choose a file to upload',
			'records.fileTooLarge' => 'File is too large (max 15 MB)',
			'records.titleRequired' => 'Title is required',
			'records.uploadSuccess' => 'Record uploaded.',
			'records.deletedSuccess' => 'Record deleted.',
			'records.couldNotOpen' => 'Could not open the file',
			'payments.title' => 'Payment',
			'payments.amount' => 'Amount',
			'payments.payNow' => 'Pay Now',
			'payments.payLater' => 'Pay Later',
			'payments.statusPending' => 'Payment Pending',
			'payments.statusPaid' => 'Paid',
			'payments.statusFailed' => 'Payment Failed',
			'payments.statusCancelled' => 'Cancelled',
			'payments.statusRefunded' => 'Refunded',
			'payments.statusRefundFailed' => 'Refund Failed',
			'payments.paymentConfirmed' => 'Payment confirmed. Thank you!',
			'payments.openingBrowser' => 'Opening your browser…',
			'payments.checkStatus' => 'Check Status',
			'family.title' => 'Family',
			'family.myself' => 'Myself',
			'family.addFamilyMember' => 'Add Family Member',
			'family.editFamilyMember' => 'Edit Family Member',
			'family.firstName' => 'First Name',
			'family.lastName' => 'Last Name',
			'family.relationship' => 'Relationship',
			'family.relationshipChild' => 'Child',
			'family.relationshipSpouse' => 'Spouse',
			'family.relationshipParent' => 'Parent',
			'family.relationshipSibling' => 'Sibling',
			'family.relationshipOther' => 'Other',
			'family.dateOfBirth' => 'Date of Birth',
			'family.bloodType' => 'Blood Type',
			'family.allergies' => 'Allergies',
			'family.chronicConditions' => 'Chronic conditions',
			'family.medications' => 'Current medications',
			'family.save' => 'Save',
			'family.delete' => 'Delete',
			'family.deleteConfirmTitle' => 'Remove Family Member',
			'family.deleteConfirmBody' => 'Remove this family member? Their appointment, medication, and record history will be kept.',
			'family.empty' => 'No family members yet',
			'family.emptySubtitle' => 'Add a child, spouse, or other family member to manage their appointments, medications, and records.',
			'family.bookingForQuestion' => 'Who is this appointment for?',
			'family.bookingForLabel' => ({required Object name}) => 'Booking for: ${name}',
			'family.forLabel' => ({required Object name}) => 'for ${name}',
			'family.ageYears' => ({required Object age}) => '${age} years old',
			'family.bookedByLabel' => ({required Object name}) => 'Booked by ${name}',
			'family.contactEmail' => 'Contact Email',
			'family.contactEmailHelp' => 'We\'ll let them know they were added, with an easy way to opt out.',
			'family.contactPhoneOptional' => 'Contact Phone (optional)',
			'family.contactEmailRequiredForAdult' => 'An email address is required so we can notify this family member',
			'family.adultConsentNotice' => 'Since they\'re 18 or older, we\'ll email them to let them know you added them — they don\'t need the app, and they can disconnect this connection at any time.',
			'family.noticeAlreadySent' => 'We\'ve let them know they were added. They can disconnect this connection at any time.',
			'family.noticePendingBadge' => 'Notice sent',
			'subscription.title' => 'Subscription',
			'subscription.planNameBasic' => 'Starter',
			'subscription.planNamePro' => 'Professional',
			'subscription.couldNotLoad' => 'Couldn\'t load your subscription.',
			'subscription.nowActive' => 'Your subscription is now active!',
			'subscription.unavailable' => 'Subscriptions aren\'t available right now. Please try again later.',
			'subscription.trialDaysLeft' => ({required Object days}) => 'Free trial — ${days} day(s) left',
			'subscription.graceDaysLeft' => ({required Object days}) => 'Grace period — ${days} day(s) left to renew',
			'subscription.expiredNotice' => 'Your subscription has expired. Subscribe to become visible to patients again.',
			'subscription.activeNotice' => 'Your subscription is active.',
			'subscription.choosePlan' => 'Choose a plan to get started.',
			'subscription.currentPlan' => 'Current Plan',
			'subscription.mostPopular' => 'Most Popular',
			'subscription.perMonth' => 'per month',
			'subscription.manageOnWeb' => 'Manage your subscription at auxiodev.com',
			'subscription.featureUnlimitedWorkplaces' => 'Unlimited clinics',
			'subscription.featureWorkplaces' => ({required Object count}) => 'Up to ${count} clinic(s)',
			'subscription.featureUnlimitedBookings' => 'Unlimited monthly bookings',
			'subscription.featureBookingsPerMonth' => ({required Object count}) => 'Up to ${count} bookings per month',
			'subscription.featureChat' => 'Patient chat',
			'subscription.featurePromoted' => 'Priority placement + "Peşəkar" badge',
			'subscription.renew' => 'Renew',
			'subscription.subscribe' => 'Subscribe',
			'subscription.planNameHospitalBasic' => 'Clinic',
			'subscription.planNameHospitalPro' => 'Clinic Plus',
			'subscription.featureDoctors' => ({required Object count}) => 'Up to ${count} doctor(s)',
			'subscription.featureUnlimitedDoctors' => 'Unlimited doctors',
			'subscription.featureAdvancedStats' => 'Advanced statistics',
			'hospitalPicker.title' => 'Select Hospital',
			'hospitalPicker.searchHint' => 'Search hospital name…',
			'hospitalPicker.noResultsFound' => 'No hospitals found',
			'hospitalPicker.selectCityFirst' => 'Select a city first',
			'hospitalPicker.addVariant' => ({required Object name}) => 'Add "${name}"',
			'hospitalPicker.pendingReview' => 'Pending review',
			'hospitalRegistration.title' => 'Hospital Details',
			'hospitalRegistration.subtitle' => 'Select your city, then find your hospital below or add it.',
			'hospitalRegistration.cityStep' => '1. City',
			'hospitalRegistration.hospitalStep' => '2. Hospital',
			'hospitalRegistration.searchHint' => 'Search hospital name…',
			'hospitalRegistration.noResultsFound' => 'No hospitals found',
			'hospitalRegistration.notFoundPrompt' => 'Can\'t find your hospital?',
			'hospitalRegistration.addManually' => 'Add it manually',
			'hospitalRegistration.useSearchInstead' => 'Search instead',
			'hospitalRegistration.newHospitalName' => 'Hospital name',
			'hospitalRegistration.selectedPrefix' => 'Selected:',
			'hospitalRegistration.pendingReviewNotice' => 'New hospitals are reviewed by our team before appearing elsewhere.',
			'hospitalRegistration.submit' => 'Create Account',
			'hospitalRegistration.hospitalRequired' => 'Select or add your hospital to continue',
			'hospitalHome.greeting' => ({required Object name}) => 'Hello, ${name}',
			'hospitalHome.subtitle' => 'Manage your doctors and appointments',
			'hospitalHome.doctors' => 'Doctors',
			'hospitalHome.inviteDoctor' => 'Invite Doctor',
			'hospitalHome.appointments' => 'Appointments',
			'hospitalHome.profile' => 'Profile',
			'hospitalHome.pendingRequests' => ({required Object count}) => '${count} pending request(s)',
			'hospitalDoctors.title' => 'Doctors',
			'hospitalDoctors.tabConfirmed' => 'Confirmed',
			'hospitalDoctors.tabRequests' => 'Requests',
			'hospitalDoctors.tabInvited' => 'Invited',
			'hospitalDoctors.noConfirmedDoctors' => 'No confirmed doctors yet',
			'hospitalDoctors.noRequests' => 'No pending requests',
			'hospitalDoctors.noInvited' => 'No pending invites',
			'hospitalDoctors.approve' => 'Approve',
			'hospitalDoctors.reject' => 'Reject',
			'hospitalDoctors.remove' => 'Remove',
			'hospitalDoctors.removeConfirmTitle' => 'Remove doctor?',
			'hospitalDoctors.removeConfirmMessage' => ({required Object name}) => '${name} will no longer be affiliated with your hospital. Their workplace and appointments are not affected.',
			'hospitalDoctors.requestedToJoin' => 'Requested to join',
			'hospitalDoctors.invitedAwaiting' => 'Invited — awaiting response',
			'hospitalDoctors.editHours' => 'Edit hours',
			'hospitalInvite.title' => 'Invite a Doctor',
			'hospitalInvite.searchHint' => 'Search by name or specialization…',
			'hospitalInvite.noResultsFound' => 'No doctors found',
			'hospitalInvite.invite' => 'Invite',
			'hospitalInvite.invited' => 'Invited',
			'hospitalAppointments.title' => 'Appointments',
			'hospitalAppointments.empty' => 'No appointments yet',
			'hospitalProfile.title' => 'Hospital Profile',
			'hospitalProfile.usageDoctors' => ({required Object count, required Object limit}) => '${count} of ${limit} doctors',
			'hospitalProfile.usageDoctorsUnlimited' => ({required Object count}) => '${count} doctors (unlimited)',
			'hospitalProfile.manageSubscription' => 'Manage Subscription',
			'hospitalDoctorHours.title' => 'Working Hours',
			'hospitalDoctorHours.selectWorkplace' => 'Select a workplace',
			'hospitalDoctorHours.saved' => 'Hours saved',
			'doctorHospitals.title' => 'My Hospitals',
			'doctorHospitals.tabInvitations' => 'Invitations',
			'doctorHospitals.tabRequests' => 'Requests',
			'doctorHospitals.tabConfirmed' => 'Hospitals',
			'doctorHospitals.noInvitations' => 'No pending invitations',
			'doctorHospitals.noRequests' => 'No pending requests',
			'doctorHospitals.noConfirmed' => 'You\'re not affiliated with any hospital yet',
			'doctorHospitals.accept' => 'Accept',
			'doctorHospitals.decline' => 'Decline',
			'doctorHospitals.cancelRequest' => 'Cancel request',
			'doctorHospitals.invitedYouToJoin' => 'Invited you to join',
			'doctorHospitals.awaitingApproval' => 'Awaiting hospital approval',
			_ => null,
		};
	}
}
