import 'package:defood/app/app.locator.dart';
import 'package:defood/app/app.snackbar.dart';
import 'package:defood/models/errors/io_error.dart';
import 'package:defood/services/font_importer_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ImportFontModel extends BaseViewModel {
  final _snackbar = locator<SnackbarService>();
  final _fontImporter = locator<FontImporterService>();

  final fontImportMessage =
      'Put the fonts you want to use into ZIP file. Name of the ZIP will be used as font name inside the app.';

  Future<void> showImportFontDialog() async {
    try {
      await _fontImporter.showImportFontDialog();
      _snackbar.showCustomSnackBar(
        message: 'Fonts imported',
        variant: SnackbarType.info,
      );
    } catch (e) {
      _snackbar.showCustomSnackBar(
        variant: SnackbarType.info,
        message: e is IOError ? e.message : e.toString(),
      );
    }
  }
}
