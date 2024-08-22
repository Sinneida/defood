import 'package:defood/utils/function_name.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

typedef AppPackageInfo = ({String appName, String buildNumber, String version});

/// Mixin for `SettingsBaseService` class to provide
/// helpful methods not related explicitly to settings items
/// themselves
base mixin SettingsHelpers {
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

  Future<AppPackageInfo> getPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    return (
      appName: info.appName,
      version: info.version,
      buildNumber: info.buildNumber,
    );
  }
}
