import 'package:defood/app/app.locator.dart';
import 'package:defood/services/custom_themes_service.dart';
import 'package:defood/services/settings/base/interfaces.dart';
import 'package:defood/services/settings/base/settings_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

typedef AppPackageInfo = ({String appName, String buildNumber, String version});

enum AppearanceSettingsKey {
  monet,
  customTheme,
  themeMode,
  useImportedFont,
  customFont,
}

const defaultDirPath = '/storage/emulated/0/Download/DeFood';

final class AppearanceSettingsService extends SettingsFragment
    with ListenableServiceMixin
    implements InitializableDependency {
  @override
  Future<void> init() async {
    final customColor = _settings.prefs.getString(AppearanceSettingsKey.customTheme.name);
    _customColor =
        customColor != null ? MainColor.values.byName(customColor) : MainColor.blue;

    final supportMonet = await _settings.checkForAndroid12Plus();

    if (!supportMonet) {
      _monetEnabled = false;
      _supportMonet = false;
    } else {
      _monetEnabled =
          _settings.prefs.getBool(AppearanceSettingsKey.monet.name) ?? _monetEnabled;
    }

    _useImportedFont =
        _settings.prefs.getBool(AppearanceSettingsKey.useImportedFont.name) ??
            _useImportedFont;

    _customFont =
        _settings.prefs.getString(AppearanceSettingsKey.customFont.name) ?? _customFont;
  }

  final _settings = locator<SettingsService>();
  SettingsService get settings => _settings;

  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  bool _supportMonet = true;
  bool get supportMonet => _supportMonet;

  bool _monetEnabled = true;
  bool get monetEnabled => _monetEnabled;

  MainColor _customColor = MainColor.blue;
  MainColor get customColor => _customColor;

  bool _useImportedFont = false;
  bool get useImportedFont => _useImportedFont;

  String _customFont = 'Default';
  String get customFont => _customFont;

  @override
  Future<void> setPref<T extends Object>(Enum key, T value,
      [bool saveToDisk = true]) async {
    switch (key) {
      case AppearanceSettingsKey.themeMode:
        _themeMode = value as ThemeMode;
      case AppearanceSettingsKey.monet:
        _monetEnabled = value as bool;
      case AppearanceSettingsKey.customTheme:
        _customColor = value as MainColor;
      case AppearanceSettingsKey.useImportedFont:
        _useImportedFont = value as bool;
      case AppearanceSettingsKey.customFont:
        _customFont = value as String;
    }
    if (saveToDisk == true) {
      await _settings.savePref<T>(key, value);
    }
    notifyListeners();
  }
}
