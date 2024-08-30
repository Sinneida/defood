import 'package:defood/app/app.locator.dart';
import 'package:defood/app/app.snackbar.dart';
import 'package:defood/models/errors/auth_error.dart';
import 'package:defood/services/auth_service.dart';
import 'package:defood/services/settings/auth_settings_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class NavigationViewModel extends BaseViewModel with IndexTrackingStateHelper {
  final _auth = locator<AuthService>();
  final _authSettings = locator<AuthSettingsService>();
  final _snackbar = locator<SnackbarService>();

  bool get hasSignedIn => _authSettings.hasSignedIn && _auth.account == null;

  bool _logginIn = false;
  bool get logginIn => _logginIn;

  Future<void> signIn() async {
    try {
      _logginIn = true;
      rebuildUi();
      await _snackbar.showCustomSnackBar(
        message: 'Logging in...',
        variant: SnackbarType.progress,
      );
      await _auth.signIn();
      _logginIn = false;
      rebuildUi();
    } catch (e) {
      _snackbar.showCustomSnackBar(
        message: e is AuthError ? e.message : e.toString(),
        variant: SnackbarType.info,
      );
    }
  }
}
