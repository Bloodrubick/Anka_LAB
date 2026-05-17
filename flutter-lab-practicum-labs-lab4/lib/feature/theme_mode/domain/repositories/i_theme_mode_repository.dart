import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

/// Theme mode repository.
abstract interface class IThemeModeRepository {
  /// [Stream] c темой пользователя.
  ValueStream<ThemeMode> get themeModeStream;

  void dispose();

  /// Получить тему.
  Future<ThemeMode> getThemeMode();

  /// Сохранить тему.
  Future<void> setThemeMode(ThemeMode newThemeMode);
}
