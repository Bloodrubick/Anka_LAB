import 'dart:async';

import 'package:flutter/material.dart';
import 'package:surf_mad_teacher_training/feature/theme_mode/domain/repositories/i_theme_mode_repository.dart';

final class ThemeModeListener extends ChangeNotifier implements IThemeModeListener {
  ThemeMode? _currentThemeMode;
  bool _isDarkMode = false;
  final IThemeModeRepository _repository;

  StreamSubscription<ThemeMode>? _subscription;

  ThemeModeListener({required IThemeModeRepository themeModeRepository}) : _repository = themeModeRepository {
    _subscription = _repository.themeModeStream.listen(_themeModeStreamListener);
  }

  @override
  ThemeMode get currentThemeMode => _currentThemeMode ?? ThemeMode.light;

  @override
  bool get isDarkMode => _isDarkMode;

  @override
  void dispose() {
    unawaited(_subscription?.cancel());
    super.dispose();
  }

  void _themeModeStreamListener(ThemeMode newThemeMode) {
    if (newThemeMode == _currentThemeMode) return;

    _currentThemeMode = newThemeMode;
    _isDarkMode = newThemeMode == ThemeMode.dark;
    notifyListeners();
  }
}

abstract interface class IThemeModeListener implements ChangeNotifier {
  ThemeMode get currentThemeMode;

  bool get isDarkMode;
}
