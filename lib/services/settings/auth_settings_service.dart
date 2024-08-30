import 'package:defood/app/app.locator.dart';
import 'package:defood/services/settings/base/interfaces.dart';
import 'package:defood/services/settings/base/settings_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

enum AuthSettingsKeys {
  hasSignedIn,
}

class AuthSettingsService extends SettingsFragment
    with ListenableServiceMixin
    implements InitializableDependency {
  AuthSettingsService() {
    listenToReactiveValues([_hasSignedIn]);
  }

  final _settings = locator<SettingsService>();

  bool _hasSignedIn = false;
  bool get hasSignedIn => _hasSignedIn;

  @override
  Future<void> init() async {
    _hasSignedIn =
        _settings.prefs.getBool(AuthSettingsKeys.hasSignedIn.name) ?? _hasSignedIn;
  }

  @override
  Future<void> setPref<T extends Object>(Enum key, T value, [bool save = true]) async {
    switch (key) {
      case AuthSettingsKeys.hasSignedIn:
        _hasSignedIn = value as bool;
    }
    if (save == true) {
      await _settings.savePref(key, value);
    }
    notifyListeners();
  }
}
