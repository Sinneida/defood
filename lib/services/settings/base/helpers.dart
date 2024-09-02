import 'dart:io';

import 'package:defood/services/settings/appearance_settings_service.dart';
import 'package:defood/utils/logger_helper.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

typedef AppPackageInfo = ({String appName, String buildNumber, String version});

/// Mixin for `SettingsService` class to provide
/// helpful methods not related explicitly to settings items
/// themselves
abstract base class SettingsHelpers with LoggerHelper {
  Future<bool> installGranted() async {
    try {
      return await Permission.requestInstallPackages.status.isGranted;
    } catch (e) {
      logError('Cannot write to this folder', e);
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

  Future<bool> checkForAndroid12Plus() async {
    final deviceInfo = await DeviceInfoPlugin().androidInfo;
    return deviceInfo.version.sdkInt >= 31;
  }

  Future<void> ensureAppDirExists() async {
    final defaultDir = Directory(defaultDirPath);
    final isDefaultDir = await defaultDir.exists();
    if (!isDefaultDir) {
      await defaultDir.create();
    }
  }
}
