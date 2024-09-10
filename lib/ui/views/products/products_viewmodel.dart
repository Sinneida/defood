import 'dart:async';

import 'package:defood/app/app.locator.dart';
import 'package:defood/models/product.dart';
import 'package:defood/services/database_service.dart';
import 'package:defood/ui/views/camera/camera_view.dart';
import 'package:defood/utils/notification_helper.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ProductsViewModel extends BaseViewModel with NotificationHelper {
  final _db = locator<DatabaseService>();
  final _nav = locator<NavigationService>();

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

  Future<void> showCamera() async {
    try {
      _nav.navigateToView(const CameraView());
    } catch (e) {
      notifyError('Failed to show camera view');
      notifyError(e.toString());
    }
  }
}
