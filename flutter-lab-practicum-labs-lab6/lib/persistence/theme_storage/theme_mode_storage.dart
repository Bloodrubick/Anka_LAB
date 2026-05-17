import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surf_mad_teacher_training/persistence/theme_storage/i_theme_mode_storage.dart';

/// {@template theme_mode_storage.class}
/// Persistent storage for theme mode.
/// {@endtemplate}
class ThemeModeStorage implements IThemeModeStorage {
  static const _defaultThemeMode = ThemeMode.light;

  final SharedPreferences _prefs;

  /// {@macro theme_mode_storage.class}
  const ThemeModeStorage(this._prefs);

  @override
  Future<void> clear() async {
    for (final key in ThemeStorageKeys.values) {
      await _prefs.remove(key.keyName);
    }
  }

  @override
  Future<ThemeMode> getThemeMode() async {
    final themeName = _prefs.getString(ThemeStorageKeys.mode.keyName);
    if (themeName?.isEmpty ?? true) return _defaultThemeMode;

    return ThemeMode.values.firstWhereOrNull((mode) => mode.name == themeName) ?? _defaultThemeMode;
  }

  @override
  Future<void> saveThemeMode({required ThemeMode mode}) async {
    await _prefs.setString(ThemeStorageKeys.mode.keyName, mode.name);
  }
}

/// Keys for [ThemeModeStorage].
enum ThemeStorageKeys {
  /// Theme mode.
  mode('theme_mode');

  /// Key Name.
  final String keyName;

  const ThemeStorageKeys(this.keyName);
}
