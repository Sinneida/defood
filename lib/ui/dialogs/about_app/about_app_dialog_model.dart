import 'package:defood/app/app.locator.dart';
import 'package:defood/services/settings/appearance_settings_service.dart';
import 'package:defood/services/settings/base/settings_service.dart';
import 'package:stacked/stacked.dart';

class AboutAppDialogModel extends BaseViewModel {
  final _settings = locator<SettingsService>();
  final message = 'This app helps you to download APK files, without tedious clicking.';

  AppPackageInfo? _info;
  AppPackageInfo? get info => _info;

  String get version => info?.version ?? 'Loading...';

  Future<void> getPackageInfo() async {
    _info = await _settings.getPackageInfo();
    rebuildUi();
  }
}
