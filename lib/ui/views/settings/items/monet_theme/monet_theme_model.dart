import 'package:defood/app/app.locator.dart';
import 'package:defood/services/settings/appearance_settings_service.dart';
import 'package:stacked/stacked.dart';

class MonetThemeModel extends BaseViewModel {
  bool get monetEnabled => _appearanceFragment.monetEnabled;
  bool get supportMonet => _appearanceFragment.supportMonet;

  final _appearanceFragment = locator<AppearanceSettingsService>();

  void updateValue(bool value) {
    _appearanceFragment.setPref<bool>(AppearanceSettingsKey.monet, value);
    rebuildUi();
  }
}
