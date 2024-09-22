import 'package:defood/app/app.locator.dart';
import 'package:defood/app/app.router.dart';
import 'package:defood/services/settings/about_settings_service.dart';
import 'package:defood/utils/function_name.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PermissionsViewModel extends BaseViewModel {
  final _nav = locator<NavigationService>();
  final _aboutSettings = locator<AboutSettingsService>();

  final description =
      'Following permissions are optional. Click on the tile to enable them.';

  bool _install = false;
  bool get install => _install;

  bool _updates = false;
  bool get updates => _updates;

  bool _camera = false;
  bool get camera => _camera;

  Future<void> init() async {
    _install = await Permission.requestInstallPackages.status.isGranted;
    _camera = await Permission.camera.status.isGranted;
    _updates = _aboutSettings.disableUpdates;
    rebuildUi();
  }

  Future<void> goHome() async {
    await createAppDir();
    await _aboutSettings.setPref<bool>(AboutSettingsKey.shownPermissions, true);
    _nav.clearStackAndShow(Routes.loginView);
  }

  Future<void> createAppDir() async {
    try {
      await _aboutSettings.settings.ensureAppDirExists();
    } catch (e) {
      FlutterLogs.logError(
        runtimeType.toString(),
        getFunctionName(),
        e.toString(),
      );
    }
  }

  Future<void> requestInstallPermission() async {
    final result = await Permission.requestInstallPackages.request();
    _install = result.isGranted;
    rebuildUi();
  }

  Future<void> requestUpdatesPermission() async {
    _updates = !_updates;
    await _aboutSettings.setPref<bool>(AboutSettingsKey.disableUpdates, _updates);
    rebuildUi();
  }

  Future<void> requestCameraPermission() async {
    final result = await Permission.camera.request();
    _camera = result.isGranted;
    rebuildUi();
  }
}
