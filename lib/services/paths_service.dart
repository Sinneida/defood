import 'dart:io';

import 'package:defood/app/app.locator.dart';
import 'package:defood/models/errors/io_error.dart';
import 'package:defood/services/settings/base/settings_service.dart';

class PathsService {
  final _settings = locator<SettingsService>();

  Future<Directory> getFolderToSave() async {
    try {
      Directory? downloadsDir = Directory(_settings.appSavePath);
      if (!downloadsDir.existsSync()) {
        downloadsDir.createSync();
      }

      return downloadsDir;
    } catch (e) {
      throw IOError(e.toString());
    }
  }
}
