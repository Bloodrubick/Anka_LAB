import 'package:flutter_test/flutter_test.dart';
import 'package:surf_mad_teacher_training/assets/images/app_svg_icons.dart';
import 'package:surf_mad_teacher_training/assets/strings/app_strings.dart';
import 'package:surf_mad_teacher_training/feature/onboarding/domain/entities/onboarding_step_type.dart';
import 'package:surf_mad_teacher_training/feature/onboarding/presentation/utils/extension/onboarding_step_extension.dart';

void main() {
  group('OnboardingStepExtension Tests', () {
    test('icon returns correct AppSvgIcons path for each step', () {
      expect(OnboardingStepType.first.icon, AppSvgIcons.onboardingPage1);
      expect(OnboardingStepType.second.icon, AppSvgIcons.onboardingPage2);
      expect(OnboardingStepType.third.icon, AppSvgIcons.onboardingPage3);
    });

    test('title returns correct AppStrings title for each step', () {
      expect(OnboardingStepType.first.title, AppStrings.onboardingPage1Title);
      expect(OnboardingStepType.second.title, AppStrings.onboardingPage2Title);
      expect(OnboardingStepType.third.title, AppStrings.onboardingPage3Title);
    });

    test('description returns correct AppStrings description for each step', () {
      expect(OnboardingStepType.first.description, AppStrings.onboardingPage1Description);
      expect(OnboardingStepType.second.description, AppStrings.onboardingPage2Description);
      expect(OnboardingStepType.third.description, AppStrings.onboardingPage3Description);
    });
  });
}
