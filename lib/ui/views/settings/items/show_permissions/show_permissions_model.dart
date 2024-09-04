import 'package:defood/app/app.locator.dart';
import 'package:defood/ui/permissions/permissions_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ShowPermissionsModel extends BaseViewModel {
  final _navigation = locator<NavigationService>();

  void showPermissionsPage() {
    _navigation.navigateWithTransition(
      const PermissionsView(
        fromSettings: true,
      ),
      transitionStyle: Transition.rightToLeftWithFade,
    );
  }
}
