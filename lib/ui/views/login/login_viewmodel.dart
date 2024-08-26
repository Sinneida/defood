import 'package:defood/app/app.locator.dart';
import 'package:defood/app/app.router.dart';
import 'package:defood/app/app.snackbar.dart';
import 'package:defood/models/errors/auth_error.dart';
import 'package:defood/services/auth_service.dart';
import 'package:defood/utils/function_name.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginViewModel extends StreamViewModel<AuthState> {
  final _auth = locator<AuthService>();
  final _snackbar = locator<SnackbarService>();
  final _nav = locator<NavigationService>();

  Future<void> signIn() async {
    try {
      await _auth.signIn();
      _snackbar.showCustomSnackBar(
        message:
            'Logged in as ${_auth.account?.session?.user.email ?? '<error>'}',
        variant: SnackbarType.info,
      );
      _nav.clearStackAndShow(Routes.navigationView);
    } catch (e) {
      FlutterLogs.logError(
        runtimeType.toString(),
        getFunctionName(),
        'Failed to login with Google: $e',
      );
      _snackbar.showCustomSnackBar(
        message: e is AuthError ? e.message : e.toString(),
        variant: SnackbarType.info,
      );
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      _snackbar.showCustomSnackBar(
        message: 'Logged out from Supabase',
        variant: SnackbarType.info,
      );
    } catch (e) {
      FlutterLogs.logError(
        runtimeType.toString(),
        getFunctionName(),
        'Failed to log out: $e',
      );
      _snackbar.showCustomSnackBar(
        message: e is AuthError ? e.message : e.toString(),
        variant: SnackbarType.info,
      );
    }
  }

  @override
  Stream<AuthState> get stream => _auth.authClient.onAuthStateChange;

  @override
  void onData(AuthState? data) {
    if (data != null) {
      data.event == AuthChangeEvent.signedIn;
    }
  }
}
