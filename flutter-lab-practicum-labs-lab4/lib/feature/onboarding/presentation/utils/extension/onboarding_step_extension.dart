import 'package:surf_mad_teacher_training/assets/images/app_svg_icons.dart';
import 'package:surf_mad_teacher_training/assets/strings/app_strings.dart';
import 'package:surf_mad_teacher_training/feature/onboarding/domain/entities/onboarding_step_type.dart';

extension OnboardingStepExtension on OnboardingStepType {
  /// Возвращает путь к иконке шага.
  String get icon {
    switch (this) {
      case OnboardingStepType.first:
        return AppSvgIcons.onboardingPage1;
      case OnboardingStepType.second:
        return AppSvgIcons.onboardingPage2;
      case OnboardingStepType.third:
        return AppSvgIcons.onboardingPage3;
    }
  }

  /// Возвращает заголовок шага.
  // TODO(sugina): подключение к локализации.
  String get title {
    switch (this) {
      case OnboardingStepType.first:
        return AppStrings.onboardingPage1Title;
      case OnboardingStepType.second:
        return AppStrings.onboardingPage2Title;
      case OnboardingStepType.third:
        return AppStrings.onboardingPage3Title;
    }
  }

  /// Возвращает описание шага.
  // TODO(sugina): подключение к локализации.
  String get description {
    switch (this) {
      case OnboardingStepType.first:
        return AppStrings.onboardingPage1Description;
      case OnboardingStepType.second:
        return AppStrings.onboardingPage2Description;
      case OnboardingStepType.third:
        return AppStrings.onboardingPage3Description;
    }
  }
}
