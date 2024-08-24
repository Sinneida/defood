import 'package:defood/app/app.locator.dart';
import 'package:defood/services/settings/appearance_settings_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AppThemeModel extends BaseViewModel {
  ThemeMode get themeMode => _appearanceFragment.themeMode;

  final _appearanceFragment = locator<AppearanceSettingsService>();

  final controller = MenuController();

  void handleTap() {
    if (!controller.isOpen) {
      controller.open();
    }
  }

  void updateValue(ThemeMode mode, int index) {
    final themeFromIndex = ThemeMode.values.elementAt(index);
    _appearanceFragment.setPref<ThemeMode>(AppearanceSettingsKey.themeMode ,themeFromIndex);
    rebuildUi();
  }

  String menuName(String currentName) {
    return currentName.padRight(14);
  }
}
