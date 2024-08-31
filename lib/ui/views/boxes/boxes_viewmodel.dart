import 'package:defood/app/app.dialogs.dart';
import 'package:defood/app/app.locator.dart';
import 'package:defood/services/auth_service.dart';
import 'package:defood/utils/snackbar_helper.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class BoxesViewModel extends BaseViewModel with SnackbarHelper {
  final _auth = locator<AuthService>();
  final _dialog = locator<DialogService>();

  String? get avatar {
    return _auth.account?.user?.userMetadata?['avatar_url'];
  }

  String? get userEmail {
    return _auth.account?.user?.email;
  }

  Future<void> showAddBox() async {
    try {
      final name = await _dialog.showCustomDialog<String?, void>(
        variant: DialogType.addBox,
      );
      rebuildUi();
      if (name != null && name.data != null) {
        showInfoSnack('Added ${name.data}');
      }
    } catch (e) {
      showInfoSnack('Failed to add new box: ${e.toString()}');
    }
  }
}
