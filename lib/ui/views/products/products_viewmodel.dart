import 'package:defood/app/app.locator.dart';
import 'package:defood/models/product.dart';
import 'package:defood/services/database_service.dart';
import 'package:defood/utils/notification_helper.dart';
import 'package:stacked/stacked.dart';

class ProductsViewModel extends BaseViewModel with NotificationHelper {
  final _db = locator<DatabaseService>();

  final List<Product> _products = [];
  List<Product> get products => _products;

  Future<void> loadAllProducts() async {
    try {
      final result = await runBusyFuture(_db.loadAllProducts());
      _products.addAll(result);
      rebuildUi();
    } catch (e) {
      notifyError('Failed to load products');
    }
  }
}
