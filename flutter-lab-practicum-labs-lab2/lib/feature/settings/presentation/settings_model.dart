import 'dart:async';

import 'package:flutter/material.dart';
import 'package:surf_mad_teacher_training/feature/theme_mode/domain/repositories/i_theme_mode_repository.dart';

/// {@template settings_model.class}
/// Модель для SettingsScreen.
/// {@endtemplate}
final class SettingsModel implements ISettingsModel {
  final IThemeModeRepository _themeModeRepository;

  /// {@macro settings_model.class}
  const SettingsModel({required IThemeModeRepository themeModeRepository}) : _themeModeRepository = themeModeRepository;

  @override
  ThemeMode get currentThemeMode => _themeModeRepository.themeModeStream.value;

  @override
  Future<void> setThemeMode(ThemeMode newThemeMode) async {
    await _themeModeRepository.setThemeMode(newThemeMode);
  }
}

abstract interface class ISettingsModel {
  ThemeMode get currentThemeMode;

  void setThemeMode(ThemeMode newThemeMode);
}
