import 'package:defood/app/app.locator.dart';
import 'package:defood/models/errors/auth_error.dart';
import 'package:defood/services/settings/auth_settings_service.dart';
import 'package:defood/utils/envs.dart';
import 'package:defood/utils/function_name.dart';
import 'package:defood/utils/logger_helper.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService with LoggerHelper  {
  final _authSettings = locator<AuthSettingsService>();

  final _googleClient = GoogleSignIn(
    signInOption: SignInOption.standard,
    clientId: Env.clientId,
    serverClientId: Env.webClientId,
  );

  final _authClient = Supabase.instance.client.auth;
  GoTrueClient get authClient => _authClient;

  AuthResponse? _account;
  AuthResponse? get account => _account;

  Future<void> signIn() async {
    try {
      final googleUser = await _googleClient.signIn();
      if (googleUser == null) {
        throw AuthError('Failed to authenticate with Google');
      }

      final googleAuth = await googleUser.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;

      if (accessToken == null || idToken == null) {
        throw AuthError(
          'Access token: ${accessToken == null ? 'NOK' : 'OK'}, ID Token: ${idToken == null ? 'NOK' : 'OK'}',
        );
      }

      _account = await _authClient.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      if (_account?.session == null && _account?.user == null) {
        throw AuthError('Failed to sign in');
      }

      await _authSettings.setPref<bool>(AuthSettingsKeys.hasSignedIn, true);
    } catch (e) {
      logError(
        'Failed to sign in into Supabase: ${e.toString()}',
        e
      );
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _authClient.signOut();
    } catch (e) {
      FlutterLogs.logError(
        runtimeType.toString(),
        getFunctionName(),
        'Failed to sign out from Supabase: ${e.toString()}',
      );
      rethrow;
    }
  }
}
