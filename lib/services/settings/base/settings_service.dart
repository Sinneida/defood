import 'package:defood/services/settings/base/helpers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked_annotations.dart';

final class SettingsService extends SettingsHelpers implements InitializableDependency {
  late final SharedPreferencesWithCache prefs;

  final String _appSavePath = '/storage/emulated/0/Download/DeFood';
  String get appSavePath => _appSavePath;

  @override
  Future<void> init() async {
    prefs = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(allowList: null),
    );
  }

  Future<void> savePref<T extends Object>(Enum key, T value) async {
    if (value is bool) {
      await prefs.setBool(key.name, value);
    }
    if (value is String) {
      await prefs.setString(key.name, value);
    }
    if (value is Enum) {
      await prefs.setString(key.name, value.name);
    }
    if (value is int) {
      await prefs.setInt(key.name, value);
    }
  }
}
