import 'package:flutter/material.dart';
import 'package:surf_mad_teacher_training/assets/strings/app_strings.dart';
import 'package:surf_mad_teacher_training/feature/onboarding/domain/entities/onboarding_step_type.dart';
import 'package:surf_mad_teacher_training/feature/onboarding/presentation/onboarding_wm.dart';
import 'package:surf_mad_teacher_training/feature/onboarding/presentation/utils/extension/onboarding_step_extension.dart';
import 'package:surf_mad_teacher_training/uikit/buttons/main_button.dart';
import 'package:surf_mad_teacher_training/uikit/buttons/text_button_widget.dart';
import 'package:surf_mad_teacher_training/uikit/images/svg_picture_widget.dart';
import 'package:surf_mad_teacher_training/uikit/themes/colors/app_color_theme.dart';
import 'package:surf_mad_teacher_training/uikit/themes/text/app_text_theme.dart';

part 'widgets/_dots_widget.dart';

part 'widgets/_onboarding_step_widget.dart';

part 'widgets/_skip_button_widget.dart';

part 'widgets/_start_button_widget.dart';

/// {@template onboarding_screen.class}
/// Экран онбординга.
/// {@endtemplate}
class OnboardingScreen extends StatelessWidget {
  final IOnboardingWM wm;

  /// {@macro onboarding_screen.class}
  const OnboardingScreen({required this.wm, super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: wm,
      builder: (_, __) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            actions: [_SkipButtonWidget(isLastPage: wm.isLastStep, onSkipPressed: wm.onSkipOnboardingPressed)],
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
            child: Column(
              children: [
                Expanded(
                  child: PageView(
                    onPageChanged: (index) => wm.onGoToStepByIndex(stepIndex: index),
                    children:
                        OnboardingStepType.values
                            .map(
                              (step) => _OnboardingStepWidget(
                                icon: step.icon,
                                title: step.title,
                                description: step.description,
                              ),
                            )
                            .toList(),
                  ),
                ),
                _DotsWidget(dotsCount: OnboardingStepType.values.length, currentDotIndex: wm.currentStepIndex),
                SizedBox(height: 32),
                _StartButtonWidget(isLastPage: wm.isLastStep, onStartPressed: wm.onSkipOnboardingPressed),
                SafeArea(child: SizedBox.shrink()),
              ],
            ),
          ),
        );
      },
    );
  }
}
