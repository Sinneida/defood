import 'package:defood/services/settings/base/settings_service.dart';

/// Interface which all classes extending settings must implement
abstract interface class SettingsFragment {
  // ignore: unused_field
  abstract final SettingsService _settings;

  Future<void> setPref<T extends Object>(Enum key, T value, [bool save = true]);
}
