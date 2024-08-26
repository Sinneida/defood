import 'package:defood/models/errors/auth_error.dart';
import 'package:defood/utils/envs.dart';
import 'package:defood/utils/function_name.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final _googleClient = GoogleSignIn(
    signInOption: SignInOption.standard,
    clientId: Env.clientId,
    serverClientId: Env.webClientId,
  );

  final _supaBaseAuthClient = Supabase.instance.client.auth;
  GoTrueClient get authClient => _supaBaseAuthClient;

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

      _account = await _supaBaseAuthClient.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      _supaBaseAuthClient.onAuthStateChange.listen((event) {
        FlutterLogs.logInfo(
          runtimeType.toString(),
          getFunctionName(),
          event.toString(),
        );
      }, onError: (Object error) {
        FlutterLogs.logError(
          runtimeType.toString(),
          getFunctionName(),
          error.toString(),
        );
      });
    } catch (e) {
      FlutterLogs.logError(
        runtimeType.toString(),
        getFunctionName(),
        'Failed to sign in into Supabase: ${e.toString()}',
      );
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _supaBaseAuthClient.signOut();
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
