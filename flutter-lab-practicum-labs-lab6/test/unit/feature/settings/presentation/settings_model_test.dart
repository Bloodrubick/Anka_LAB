import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';
import 'package:surf_mad_teacher_training/feature/settings/presentation/settings_model.dart';
import 'package:surf_mad_teacher_training/feature/theme_mode/domain/repositories/i_theme_mode_repository.dart';

import 'settings_model_test.mocks.dart';

@GenerateMocks([IThemeModeRepository])
void main() {
  late SettingsModel settingsModel;
  late MockIThemeModeRepository mockThemeModeRepository;

  setUp(() {
    mockThemeModeRepository = MockIThemeModeRepository();
    settingsModel = SettingsModel(themeModeRepository: mockThemeModeRepository);
  });

  group('SettingsModel Tests', () {
    test('currentThemeMode returns value from repository stream', () {
      // Arrange
      final stream = BehaviorSubject<ThemeMode>.seeded(ThemeMode.dark);
      when(mockThemeModeRepository.themeModeStream).thenAnswer((_) => stream);

      // Act
      final result = settingsModel.currentThemeMode;

      // Assert
      expect(result, ThemeMode.dark);
    });

    test('setThemeMode calls repository method', () async {
      // Arrange
      when(mockThemeModeRepository.setThemeMode(ThemeMode.light)).thenAnswer((_) async {});

      // Act
      await settingsModel.setThemeMode(ThemeMode.light);

      // Assert
      verify(mockThemeModeRepository.setThemeMode(ThemeMode.light)).called(1);
    });
  });
}
