import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:surf_mad_teacher_training/feature/theme_mode/domain/repositories/i_theme_mode_repository.dart';
import 'package:surf_mad_teacher_training/persistence/theme_storage/i_theme_mode_storage.dart';

/// {@template theme_repository.class}
/// Implementation of [IThemeModeRepository].
/// {@endtemplate}
final class ThemeModeRepository implements IThemeModeRepository {
  final IThemeModeStorage _themeModeStorage;

  final _themeModeStream = BehaviorSubject<ThemeMode>();

  /// {@macro theme_repository.class}
  ThemeModeRepository({required IThemeModeStorage themeModeStorage}) : _themeModeStorage = themeModeStorage {
    unawaited(getThemeMode());
  }

  @override
  ValueStream<ThemeMode> get themeModeStream => _themeModeStream.stream;

  @override
  void dispose() {
    unawaited(_themeModeStream.close());
  }

  @override
  Future<ThemeMode> getThemeMode() async {
    final themeMode = await _themeModeStorage.getThemeMode();
    _themeModeStream.add(themeMode);

    return themeMode;
  }

  @override
  Future<void> setThemeMode(ThemeMode newThemeMode) async {
    await _themeModeStorage.saveThemeMode(mode: newThemeMode);
    _themeModeStream.add(newThemeMode);
  }
}
