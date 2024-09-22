import 'dart:async';

import 'package:defood/app/app.dialogs.dart';
import 'package:defood/app/app.locator.dart';
import 'package:defood/models/errors/base/app_error.dart';
import 'package:defood/models/product.dart';
import 'package:defood/services/database_service.dart';
import 'package:defood/services/off_service.dart';
import 'package:defood/ui/dialogs/add_product/add_product_dialog_model.dart';
import 'package:defood/ui/views/camera/camera_view.dart';
import 'package:defood/utils/logger_helper.dart';
import 'package:defood/utils/notification_helper.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ProductsViewModel extends BaseViewModel with NotificationHelper, LoggerHelper {
  final _db = locator<DatabaseService>();
  final _nav = locator<NavigationService>();
  final _off = locator<OpenFoodFactsService>();
  final _dialog = locator<DialogService>();

  List<ProductModel> products = [];

  Future<void> loadAllProducts() async {
    try {
      final result = await runBusyFuture(_db.loadAllProducts());
      products.addAll(result);
      rebuildUi();
    } catch (e) {
      notifyError('Failed to load products');
    }
  }

  Future<void> showCamera() async {
    try {
      final barcode = await _nav.navigateToView<Barcode>(
        const CameraView(),
        preventDuplicates: false,
      );
      if (barcode != null) {
        final product = await _off.getProductData(barcode.rawValue!);
        final result = await _dialog.showCustomDialog<ProductDto?, Product?>(
          variant: DialogType.addProduct,
          data: product,
        );
        if (result != null && result.data != null) {
          final boxId = products[0].boxId;
          await _db.addProduct(result.data!, boxId, barcode.rawValue!);
          notifyInfo('Successfully added product');
        }
      }
    } catch (e) {
      notifyError('Failed to show camera view: $e');
      logError('Failed to show camera', e);
    }
  }
}
