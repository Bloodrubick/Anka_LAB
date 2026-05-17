import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:surf_mad_teacher_training/feature/settings/presentation/settings_model.dart';

abstract interface class ISettingsWM {
  ValueListenable<bool> get isDarkThemeModeState;

  void dispose();

  // ignore: avoid_positional_boolean_parameters
  void onThemeChanged(bool value);

  void onTutorialPressed();
}

final class SettingsWM implements ISettingsWM {
  final ValueNotifier<bool> _isDarkThemeModeState;
  final ISettingsModel _model;

  SettingsWM({required ISettingsModel model})
    : _model = model,
      _isDarkThemeModeState = ValueNotifier<bool>(model.currentThemeMode == ThemeMode.dark);

  @override
  ValueListenable<bool> get isDarkThemeModeState => _isDarkThemeModeState;

  @override
  void dispose() {
    _isDarkThemeModeState.dispose();
  }

  @override
  void onThemeChanged(bool value) {
    _model.setThemeMode(value ? ThemeMode.dark : ThemeMode.light);
    _isDarkThemeModeState.value = value;
  }

  @override
  void onTutorialPressed() {
    // TODO: Implement tutorial pressed
  }
}
