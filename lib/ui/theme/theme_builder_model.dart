import 'package:defood/app/app.locator.dart';
import 'package:defood/services/custom_themes_service.dart';
import 'package:defood/services/font_importer_service.dart';
import 'package:defood/services/settings_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ThemeBuilderModel extends ReactiveViewModel {
  final _settings = locator<SettingsService>();
  final _themes = locator<CustomThemesService>();
  final _fontImporter = locator<FontImporterService>();

  ThemeMode get themeMode => _settings.themeMode;
  bool get monetEnabled => _settings.monetEnabled;
  MainColor get customTheme => _settings.customColor;
  bool get useImportedFont => _settings.useImportedFont;
  bool get shownPermissions => _settings.shownPermissions;

  ThemeScheme getTheme(MainColor color) {
    return _themes.getTheme(color);
  }

  Future<void> loadCustomFont() async {
    await _fontImporter.loadFonts(_settings.customFont);
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_settings];
}
