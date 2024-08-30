import 'package:defood/app/app.locator.dart';
import 'package:defood/app/app.router.dart';
import 'package:defood/app/app.snackbar.dart';
import 'package:defood/models/errors/auth_error.dart';
import 'package:defood/services/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final _auth = locator<AuthService>();
  final _snackbar = locator<SnackbarService>();
  final _nav = locator<NavigationService>();

  bool _logginIn = false;
  bool get logginIn => _logginIn;

  Future<void> signIn() async {
    try {
      _logginIn = true;
      rebuildUi();
      await _auth.signIn();
      _snackbar.showCustomSnackBar(
        message: 'Logged in as ${_auth.account?.session?.user.email ?? '<error>'}',
        variant: SnackbarType.info,
      );
      await _nav.clearStackAndShow(Routes.boxesView);
    } catch (e) {
      _snackbar.showCustomSnackBar(
        message: e is AuthError ? e.message : e.toString(),
        variant: SnackbarType.info,
      );
    }
  }

  Future<void> signOut() async {
    try {
      await runBusyFuture(_auth.signOut());
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
}
