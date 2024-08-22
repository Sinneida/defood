import 'package:defood/services/settings/base/interfaces.dart';
import 'package:defood/services/settings/base/settings_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

enum AboutSettingsKey {
  shownPermissions,
  disableUpdates,
  devOptions,
}

final class AboutSettingsService extends SettingsService
    with ListenableServiceMixin
    implements InitializableDependency, Settings {
  @override
  Future<void> init() async {
    // TODO: Load items from storage
  }

  bool _devOptions = false;
  bool get devOptions => _devOptions;

  bool _shownPermissions = false;
  bool get shownPermissions => _shownPermissions;

  bool _disableUpdates = false;
  bool get disableUpdates => _disableUpdates;

  @override
  Future<void> setPref<T extends Object>(Enum key, T value,
      [bool saveToDisk = true]) async {
    switch (key) {
      case AboutSettingsKey.shownPermissions:
        _shownPermissions = value as bool;
      case AboutSettingsKey.disableUpdates:
        _disableUpdates = value as bool;
      case AboutSettingsKey.devOptions:
        _devOptions = value as bool;
    }
    if (saveToDisk == true) {
      await super.savePref<T>(key, value);
    }
    notifyListeners();
  }
}
