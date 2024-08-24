import 'package:defood/app/app.locator.dart';
import 'package:defood/services/custom_themes_service.dart';
import 'package:defood/services/settings/appearance_settings_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CustomThemeModel extends ReactiveViewModel {
  MainColor get customColor => _appearanceFragment.customColor;

  bool get monetEnabled => _appearanceFragment.monetEnabled;

  final _appearanceFragment = locator<AppearanceSettingsService>();

  final controller = MenuController();

  void handleTap() {
    if (!controller.isOpen) {
      controller.open();
    }
  }

  void updateValue(MainColor color, int index) {
    final colorIndex = MainColor.values.elementAt(index);
    _appearanceFragment.setPref(AppearanceSettingsKey.customTheme, colorIndex);
    rebuildUi();
  }

  String menuName(String currentName) {
    return currentName.padRight(14);
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_appearanceFragment];
}
