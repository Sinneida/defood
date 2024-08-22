import 'package:defood/services/settings/base/helpers.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked_annotations.dart';

base class SettingsService
    with SettingsHelpers
    implements InitializableDependency {
  @protected
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
