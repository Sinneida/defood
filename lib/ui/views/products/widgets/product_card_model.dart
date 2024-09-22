import 'package:defood/app/app.locator.dart';
import 'package:defood/services/database_service.dart';
import 'package:defood/utils/logger_helper.dart';
import 'package:defood/utils/notification_helper.dart';
import 'package:stacked/stacked.dart';

class ProductCardModel extends BaseViewModel with NotificationHelper, LoggerHelper {
  final _db = locator<DatabaseService>();

  Future<void> deleteProduct(int productId) async {
    try {
      await _db.deleteProduct(productId);
      rebuildUi();
      notifyInfo('Deleted product');
    } catch (e) {
      logError('Failed to delete product', e);
      notifyError('Failed to delete product: $e');
    }
  }
}
