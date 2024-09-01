import 'package:defood/app/app.dialogs.dart';
import 'package:defood/app/app.locator.dart';
import 'package:defood/models/box.dart';
import 'package:defood/services/auth_service.dart';
import 'package:defood/services/database_service.dart';
import 'package:defood/utils/logger_helper.dart';
import 'package:defood/utils/notification_helper.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class BoxesViewModel extends BaseViewModel with NotificationHelper, LoggerHelper {
  final _auth = locator<AuthService>();
  final _dialog = locator<DialogService>();
  final _db = locator<DatabaseService>();

  String? get avatar {
    return _auth.avatarUrl;
  }

  String? get userEmail {
    return _auth.userEmail;
  }

  final List<Box> _boxes = [];
  List<Box> get boxes => _boxes;

  Future<void> loadAllBoxes() async {
    try {
      final result = await _db.loadAllBoxes();
      _boxes.addAll(result);
      rebuildUi();
    } catch (e) {
      notifyError('Failed to load boxes');
    }
  }

  Future<void> showAddBox() async {
    try {
      final name = await _dialog.showCustomDialog<String?, void>(
        variant: DialogType.addBox,
      );
      if (name != null && name.data != null) {
        await addNewBox(name.data!);
        notifyInfo('Added ${name.data}');
      }
      rebuildUi();
    } catch (e) {
      const message = 'Failed to add new box';
      notifyInfo(message);
      logError(message, error);
    }
  }

  Future<void> addNewBox(String name) async {
    await _db.createBox(name);
  }
}
