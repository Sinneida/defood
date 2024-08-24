import 'package:defood/app/app.locator.dart';
import 'package:defood/services/settings/base/interfaces.dart';
import 'package:defood/services/settings/base/settings_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

enum AboutSettingsKey {
  shownPermissions,
  disableUpdates,
  devOptions,
}

final class AboutSettingsService
    with ListenableServiceMixin
    implements SettingsFragment, InitializableDependency {
  AboutSettingsService() {
    listenToReactiveValues([
      _shownPermissions,
      _disableUpdates,
    ]);
  }

  @override
  Future<void> init() async {
    _shownPermissions =
        _settings.prefs.getBool(AboutSettingsKey.shownPermissions.name) ??
            _shownPermissions;
    _disableUpdates =
        _settings.prefs.getBool(AboutSettingsKey.disableUpdates.name) ??
            _disableUpdates;
  }

  final _settings = locator<SettingsService>();

  bool _devOptions = false;
  bool get devOptions => _devOptions;

  bool _shownPermissions = false;
  bool get shownPermissions => _shownPermissions;

  bool _disableUpdates = false;
  bool get disableUpdates => _disableUpdates;

  @override
  Future<void> setPref<T extends Object>(Enum key, T value,
      [bool save = true]) async {
    switch (key) {
      case AboutSettingsKey.shownPermissions:
        _shownPermissions = value as bool;
      case AboutSettingsKey.disableUpdates:
        _disableUpdates = value as bool;
      case AboutSettingsKey.devOptions:
        _devOptions = value as bool;
    }
    if (save == true) {
      await _settings.savePref<T>(key, value);
    }
    notifyListeners();
  }
}
