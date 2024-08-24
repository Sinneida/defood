import 'package:defood/app/app.locator.dart';
import 'package:defood/app/app.snackbar.dart';
import 'package:defood/services/font_importer_service.dart';
import 'package:defood/services/settings/appearance_settings_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class FontManagerModel extends ReactiveViewModel {
  final _snackbar = locator<SnackbarService>();
  final _fontImporter = locator<FontImporterService>();
  final _appearanceFragment = locator<AppearanceSettingsService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [_appearanceFragment];

  String get pickedFont => _appearanceFragment.customFont;

  final List<String> fontsList = [];

  Future<void> pickFont(String fontName) async {
    try {
      if (fontName == 'Default') {
        _appearanceFragment.setPref<bool>(
            AppearanceSettingsKey.useImportedFont, false);
        _appearanceFragment.setPref<String>(
            AppearanceSettingsKey.customFont, fontName);
        return;
      }
      _appearanceFragment.setPref<bool>(
          AppearanceSettingsKey.useImportedFont, true);
      await _fontImporter.loadFonts(pickedFont);
      _appearanceFragment.setPref<String>(
          AppearanceSettingsKey.customFont, fontName);
      rebuildUi();
    } catch (e) {
      _snackbar.showCustomSnackBar(
        message: "Can't pick font",
        variant: SnackbarType.info,
      );
    }
  }

  Future<void> getFontList() async {
    try {
      final result = await _fontImporter.getFontList();
      if (result != null) {
        fontsList.addAll(result);
      }
      rebuildUi();
    } catch (e) {
      const message = "Couldn't load fonts from storage";
      _snackbar.showCustomSnackBar(
        message: message,
        variant: SnackbarType.info,
      );
    }
  }

  Future<void> deleteFont(String fontName) async {
    try {
      final result = await _fontImporter.deleteFont(fontName);
      if (result) {
        fontsList.remove(fontName);
        rebuildUi();
        return;
      }
      throw Error();
    } catch (e) {
      _snackbar.showCustomSnackBar(
        message: "Can't delete font",
        variant: SnackbarType.info,
      );
    }
  }
}
