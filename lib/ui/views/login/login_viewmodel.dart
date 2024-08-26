import 'package:defood/utils/envs.dart';
import 'package:defood/utils/function_name.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:stacked/stacked.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginViewModel extends BaseViewModel {
  Future<void> signInWithGoogle() async {
    try {
      final webClientId = Env.webClientId;
      final clientId = Env.clientId;
      final data = GoogleSignIn(
        signInOption: SignInOption.standard,
        clientId: clientId,
        serverClientId: webClientId,
      );
      final googleUser = await data.signIn();
      final googleAuth = await googleUser!.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;

      if (accessToken == null) {
        throw 'No Access Token found.';
      }
      if (idToken == null) {
        throw 'No ID Token found.';
      }

      final account = await Supabase.instance.client.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );
      print(account);
    } catch (e) {
      FlutterLogs.logError(
        runtimeType.toString(),
        getFunctionName(),
        'Failed to login with Google: $e',
      );
    }
  }

  Future<void> signOut() async {
    try {
      await Supabase.instance.client.auth.signOut();
    } catch (e) {
      FlutterLogs.logError(
        runtimeType.toString(),
        getFunctionName(),
        'Failed to log out: $e',
      );
    }
  }
}
