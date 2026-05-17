import 'dart:async';

import 'package:flutter/material.dart';
import 'package:surf_mad_teacher_training/feature/theme_mode/domain/repositories/i_theme_mode_repository.dart';
import 'package:surf_mad_teacher_training/persistence/filter_storage/i_filter_storage.dart';

/// {@template settings_model.class}
/// Модель для SettingsScreen.
/// {@endtemplate}
final class SettingsModel implements ISettingsModel {
  final IThemeModeRepository _themeModeRepository;
  final IFilterStorage _filterStorage;

  /// {@macro settings_model.class}
  const SettingsModel({
    required IThemeModeRepository themeModeRepository,
    required IFilterStorage filterStorage,
  }) : _themeModeRepository = themeModeRepository,
       _filterStorage = filterStorage;

  @override
  ThemeMode get currentThemeMode => _themeModeRepository.themeModeStream.value;

  @override
  Future<void> setThemeMode(ThemeMode newThemeMode) async {
    await _themeModeRepository.setThemeMode(newThemeMode);
  }

  @override
  Future<void> clearFilters() => _filterStorage.clearFilter();
}

abstract interface class ISettingsModel {
  ThemeMode get currentThemeMode;

  void setThemeMode(ThemeMode newThemeMode);

  Future<void> clearFilters();
}
