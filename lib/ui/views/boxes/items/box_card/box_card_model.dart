import 'package:defood/app/app.locator.dart';
import 'package:defood/models/box.dart';
import 'package:defood/services/database_service.dart';
import 'package:defood/ui/views/products/products_view.dart';
import 'package:defood/utils/notification_helper.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class BoxCardModel extends BaseViewModel with NotificationHelper {
  final _db = locator<DatabaseService>();
  final _nav = locator<NavigationService>();

  Future<void> deleteBox(BoxModel box, void Function(int id) removeBox) async {
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

  void openBoxDetails(BoxModel box) {
    if (box.products != null) {
      _nav.navigateWithTransition(
        ProductsView(
          isDetailsView: true,
          products: box.products,
        ),
        transitionStyle: Transition.rightToLeftWithFade,
      );
    }
  }
}
