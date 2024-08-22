abstract class Settings {
  Future<void> setPref<T extends Object>(Enum key, T value, [bool save = true]);
}
