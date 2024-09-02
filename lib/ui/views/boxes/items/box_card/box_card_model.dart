import 'package:defood/app/app.locator.dart';
import 'package:defood/models/box.dart';
import 'package:defood/services/database_service.dart';
import 'package:defood/utils/notification_helper.dart';
import 'package:stacked/stacked.dart';

class BoxCardModel extends BaseViewModel with NotificationHelper {
  final _db = locator<DatabaseService>();

  Future<void> deleteBox(Box box, void Function(int id) removeBox) async {
    try {
      final result = await _db.deleteBox(box.id);
      if (result) {
        removeBox(box.id);
      }
      rebuildUi();
      notifyInfo('Removed ${box.name}');
    } catch (e) {
      notifyError('Failed to delete ${box.name}');
    }
  }
}
