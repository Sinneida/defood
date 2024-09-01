import 'package:defood/app/app.dialogs.dart';
import 'package:defood/app/app.locator.dart';
import 'package:defood/services/auth_service.dart';
import 'package:defood/utils/notification_helper.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class BoxesViewModel extends BaseViewModel with NotificationHelper {
  final _auth = locator<AuthService>();
  final _dialog = locator<DialogService>();

  String? get avatar {
    return _auth.avatarUrl;
  }

  String? get userEmail {
    return _auth.userEmail;
  }

  Future<void> loadAllBoxes() async {

  }

  Future<void> showAddBox() async {
    try {
      final name = await _dialog.showCustomDialog<String?, void>(
        variant: DialogType.addBox,
      );
      rebuildUi();
      if (name != null && name.data != null) {
        notifyInfo('Added ${name.data}');
      }
    } catch (e) {
      notifyInfo('Failed to add new box: ${e.toString()}');
    }
  }
}
