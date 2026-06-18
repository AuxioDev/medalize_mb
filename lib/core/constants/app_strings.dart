abstract final class AppStrings {
  static const appName = 'Medalize';

  // Auth
  static const login = 'Sign In';
  static const register = 'Create Account';
  static const logout = 'Log Out';
  static const email = 'Email';
  static const password = 'Password';
  static const confirmPassword = 'Confirm Password';
  static const firstName = 'First Name';
  static const lastName = 'Last Name';
  static const rememberMe = 'Remember me';
  static const forgotPassword = 'Forgot password?';
  static const sendResetLink = 'Send Reset Link';
  static const noAccount = "Don't have an account?";
  static const haveAccount = 'Already have an account?';
  static const signUp = 'Sign Up';
  static const signIn = 'Sign In';
  static const welcomeBack = 'Welcome back';
  static const signInToContinue = 'Sign in to your account to continue';
  static const createYourAccount = 'Create your account';
  static const joinMedalize = 'Join Medalize today';
  static const forgotPasswordTitle = 'Forgot Password?';
  static const forgotPasswordSubtitle =
      "Enter your email and we'll send you a reset link";
  static const resetEmailSent =
      'If that email exists, a reset link has been sent.';
  static const iAmA = 'I am a';
  static const doctor = 'Doctor';
  static const patient = 'Patient';

  // Validation
  static const emailRequired = 'Email is required';
  static const emailInvalid = 'Enter a valid email address';
  static const passwordRequired = 'Password is required';
  static const passwordTooShort = 'At least 8 characters required';
  static const passwordNeedsLetter = 'Include at least one letter';
  static const passwordNeedsDigit = 'Include at least one digit';
  static const passwordMismatch = 'Passwords do not match';
  static const passwordConfirmRequired = 'Please confirm your password';
  static const firstNameRequired = 'First name is required';
  static const firstNameInvalid = 'First name contains invalid characters';
  static const lastNameRequired = 'Last name is required';
  static const lastNameInvalid = 'Last name contains invalid characters';
  static const nameMinLength = 'Must be at least 2 characters';
  static const roleRequired = 'Please select a role';
  static const phoneRequired = 'Phone number is required';
  static const phoneTooShort = 'Number is too short';
  static const phoneTooLong = 'Number is too long';

  // Errors
  static const invalidCredentials = 'Invalid email or password';
  static const networkError = 'Network error. Check your connection.';
  static const serverError = 'Something went wrong. Please try again.';
  static const rateLimitError = 'Too many attempts. Please wait and try again.';
  static const sessionExpired = 'Session expired. Please sign in again.';

  // Placeholders
  static const emailHint = 'you@example.com';
  static const passwordHint = '••••••••';
}
