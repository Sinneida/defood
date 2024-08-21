import 'package:defood/services/custom_themes_service.dart';
import 'package:defood/utils/function_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

enum SettingsKey {
  monet,
  customTheme,
  themeMode,
  useImportedFont,
  customFont,
  shownPermissions,
  disableUpdates,
  devOptions,
}

const defaultDirPath = '/storage/emulated/0/Download/DeFood';

class SettingsService
    with ListenableServiceMixin
    implements InitializableDependency {
  late final SharedPreferencesWithCache _prefs;

  @override
  Future<void> init() async {
    _prefs = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(allowList: null),
    );
    // TODO: Load prefs
  }

  final String _appSavePath = '/storage/emulated/0/Download/GlassDown';
  String get appSavePath => _appSavePath;

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

  bool _devOptions = false;
  bool get devOptions => _devOptions;

  bool _shownPermissions = false;
  bool get shownPermissions => _shownPermissions;

  bool _disableUpdates = false;
  bool get disableUpdates => _disableUpdates;

  void setPref<T extends Object>(SettingsKey key, T value,
      [bool saveToDisk = true]) {
    switch (key) {
      case SettingsKey.themeMode:
        _themeMode = value as ThemeMode;
      case SettingsKey.monet:
        _monetEnabled = value as bool;
      case SettingsKey.customTheme:
        _customColor = value as MainColor;
      case SettingsKey.useImportedFont:
        _useImportedFont = value as bool;
      case SettingsKey.customFont:
        _customFont = value as String;
      case SettingsKey.shownPermissions:
        _shownPermissions = value as bool;
      case SettingsKey.disableUpdates:
        _disableUpdates = value as bool;
      case SettingsKey.devOptions:
        _devOptions = value as bool;
    }
    if (saveToDisk == true) {
      _savePref<T>(key, value);
    }
    notifyListeners();
  }

  Future<void> _savePref<T extends Object>(SettingsKey key, T value) async {
    if (value is bool) {
      await _prefs.setBool(key.name, value);
    }
    if (value is String) {
      await _prefs.setString(key.name, value);
    }
    if (value is Enum) {
      await _prefs.setString(key.name, value.name);
    }
    if (value is int) {
      await _prefs.setInt(key.name, value);
    }
  }

  Future<bool> installGranted() async {
    try {
      return await Permission.requestInstallPackages.status.isGranted;
    } catch (e) {
      FlutterLogs.logError(
        runtimeType.toString(),
        getFunctionName(),
        'Cannot write to this folder',
      );
    }
    return false;
  }
}
