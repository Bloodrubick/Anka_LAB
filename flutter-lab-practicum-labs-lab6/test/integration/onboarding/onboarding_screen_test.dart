// ignore_for_file: prefer-moving-to-variable

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:surf_mad_teacher_training/assets/strings/app_strings.dart';
import 'package:surf_mad_teacher_training/feature/onboarding/presentation/onboarding_screen_builder.dart';
import 'package:surf_mad_teacher_training/uikit/themes/app_theme_data.dart';

void main() {
  group('OnboardingScreen integration test', () {
    testWidgets('проверка свайпа экранов онбординга', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: OnboardingScreenBuilder(), theme: AppThemeData.lightTheme),
      );

      // Ждем отрисовки экрана
      await tester.pumpAndSettle();

      // Проверяем, что виден первый экран онбординга
      expect(find.byType(OnboardingScreenBuilder), findsOneWidget);
      expect(find.text(AppStrings.onboardingPage1Title), findsOneWidget);

      // Свайпаем на второй экран
      await tester.drag(find.byType(PageView), const Offset(-400, 0));
      await tester.pumpAndSettle();

      // Проверяем, что виден второй экран онбординга
      expect(find.text(AppStrings.onboardingPage2Title), findsOneWidget);

      // Свайпаем на третий экран
      await tester.drag(find.byType(PageView), const Offset(-400, 0));
      await tester.pumpAndSettle();

      // Проверяем, что виден третий экран онбординга
      expect(find.text(AppStrings.onboardingPage3Title), findsOneWidget);
    });
  });
}
