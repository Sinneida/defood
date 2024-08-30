/// Interface which all classes extending settings must implement
abstract class SettingsFragment {
  Future<void> setPref<T extends Object>(Enum key, T value, [bool save = true]);
}
