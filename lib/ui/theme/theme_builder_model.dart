import 'package:defood/app/app.locator.dart';
import 'package:defood/services/custom_themes_service.dart';
import 'package:defood/services/font_importer_service.dart';
import 'package:defood/services/settings/about_settings_service.dart';
import 'package:defood/services/settings/appearance_settings_service.dart';
import 'package:defood/services/settings/auth_settings_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ThemeBuilderModel extends ReactiveViewModel {
  final _appearanceSettings = locator<AppearanceSettingsService>();
  final _aboutSettings = locator<AboutSettingsService>();
  final _themes = locator<CustomThemesService>();
  final _fontImporter = locator<FontImporterService>();
  final _authSettings = locator<AuthSettingsService>();

  ThemeMode get themeMode => _appearanceSettings.themeMode;
  bool get monetEnabled => _appearanceSettings.monetEnabled;
  MainColor get customTheme => _appearanceSettings.customColor;
  bool get useImportedFont => _appearanceSettings.useImportedFont;
  bool get shownPermissions => _aboutSettings.shownPermissions;
  bool get hasSignedIn => _authSettings.hasSignedIn;

  ThemeScheme getTheme(MainColor color) {
    return _themes.getTheme(color);
  }

  Future<void> loadCustomFont() async {
    await _fontImporter.loadFonts(_appearanceSettings.customFont);
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_appearanceSettings];
}
