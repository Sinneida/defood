import 'package:defood/app/app.locator.dart';
import 'package:defood/app/app.snackbar.dart';
import 'package:defood/services/settings/about_settings_service.dart';
import 'package:defood/services/updater_service.dart';
import 'package:defood/ui/bottom_sheets/updater/update_sheet.dart';
import 'package:defood/utils/function_name.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CheckUpdatesModel extends ReactiveViewModel {
  final _updater = locator<UpdaterService>();
  final _snackbar = locator<SnackbarService>();
  final _aboutFragment = locator<AboutSettingsService>();

  bool get devOptions => _aboutFragment.devOptions;

  Future<void> checkUpdates() async {
    try {
      final result = await _updater.checkUpdates();
      if (_updater.isDev && !devOptions) {
        _snackbar.showCustomSnackBar(
          message: 'Enable developer options to update',
          variant: SnackbarType.info,
        );
        return;
      }
      if (result || devOptions) {
        showUpdaterSheet();
      } else {
        _snackbar.showCustomSnackBar(
          message: 'No updates available',
          variant: SnackbarType.info,
        );
      }
    } catch (e) {
      FlutterLogs.logError(
        runtimeType.toString(),
        getFunctionName(),
        e.toString(),
      );
    }
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_aboutFragment];
}
