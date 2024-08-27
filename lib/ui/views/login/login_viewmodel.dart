import 'package:defood/app/app.locator.dart';
import 'package:defood/app/app.router.dart';
import 'package:defood/app/app.snackbar.dart';
import 'package:defood/models/errors/auth_error.dart';
import 'package:defood/services/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginViewModel extends StreamViewModel<AuthState> {
  final _auth = locator<AuthService>();
  final _snackbar = locator<SnackbarService>();
  final _nav = locator<NavigationService>();

  Future<void> tryToLogIn() async {
    await signIn();
    _nav.clearStackAndShow(Routes.navigationView);
  }

  Future<void> signIn() async {
    try {
      await _auth.signIn();
      _snackbar.showCustomSnackBar(
        message:
            'Logged in as ${_auth.account?.session?.user.email ?? '<error>'}',
        variant: SnackbarType.info,
      );
    } catch (e) {
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
