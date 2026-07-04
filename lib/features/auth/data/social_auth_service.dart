import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medalize_mb/core/config/app_config.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

final socialAuthServiceProvider =
    Provider<SocialAuthService>((_) => SocialAuthService());

/// Thrown when a provider SDK fails for a reason other than the user backing
/// out (those return `null` instead). Carries no user-facing text — callers
/// map it to a localized message.
class SocialAuthException implements Exception {
  const SocialAuthException(this.provider, [this.details]);
  final String provider;
  final Object? details;

  @override
  String toString() => 'SocialAuthException($provider): $details';
}

/// Obtains native provider id_tokens for Google / Apple sign-in. The tokens
/// are exchanged for our own JWT pair via `POST /auth/social/{provider}/`.
class SocialAuthService {
  bool _googleInitialized = false;

  /// Returns the Google id_token, or `null` when the user cancels the flow.
  Future<String?> getGoogleIdToken() async {
    final signIn = GoogleSignIn.instance;
    try {
      if (!_googleInitialized) {
        await signIn.initialize(
          clientId: AppConfig.isConfigured(AppConfig.googleIosClientId)
              ? AppConfig.googleIosClientId
              : null,
          // Requests the id_token with the backend's client ID as audience.
          serverClientId:
              AppConfig.isConfigured(AppConfig.googleServerClientId)
                  ? AppConfig.googleServerClientId
                  : null,
        );
        _googleInitialized = true;
      }
      final account = await signIn.authenticate();
      final idToken = account.authentication.idToken;
      if (idToken == null) {
        throw const SocialAuthException('google', 'No id_token in response');
      }
      return idToken;
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled ||
          e.code == GoogleSignInExceptionCode.interrupted) {
        return null;
      }
      throw SocialAuthException('google', e);
    } on SocialAuthException {
      rethrow;
    } catch (e) {
      // Placeholder Firebase/Google config, missing Play Services, etc.
      throw SocialAuthException('google', e);
    }
  }

  /// Returns the Apple identity token, or `null` when the user cancels.
  Future<String?> getAppleIdToken() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      final idToken = credential.identityToken;
      if (idToken == null) {
        throw const SocialAuthException('apple', 'No identity token');
      }
      return idToken;
    } on SignInWithAppleAuthorizationException catch (e) {
      if (e.code == AuthorizationErrorCode.canceled) return null;
      throw SocialAuthException('apple', e);
    } on SocialAuthException {
      rethrow;
    } catch (e) {
      throw SocialAuthException('apple', e);
    }
  }
}
