import 'package:flutter/material.dart';
import 'package:surf_mad_teacher_training/assets/strings/app_strings.dart';
import 'package:surf_mad_teacher_training/feature/onboarding/presentation/onboarding_wm.dart';
import 'package:surf_mad_teacher_training/uikit/buttons/main_button.dart';
import 'package:surf_mad_teacher_training/uikit/buttons/text_button_widget.dart';
import 'package:surf_mad_teacher_training/uikit/images/svg_picture_widget.dart';
import 'package:surf_mad_teacher_training/uikit/placeholder/todo_placeholder.dart';
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
    return Scaffold(
      appBar: AppBar(title: const Text('Онбординг'), iconTheme: IconThemeData(color: Colors.black)),
      body: Column(
        children: [
          // TODO(any): перейдите в _SkipButtonWidget и реализуйте в соответствии с дизайном.
          TodoPlaceholder(todo: 'Виджет для отображения кнопки "Пропустить". Используйте _SkipButtonWidget.'),
          // TODO(any): перейдите в _OnboardingStepWidget и реализуйте в соответствии с дизайном.
          TodoPlaceholder(
            todo:
                'Виджет для отображения содержимого шага онбординга. Используйте _OnboardingStepWidget, а затем реализуйте отображение пролистываемых шагов в соответствии с дизайном.',
          ),
          // TODO(any): перейдите в _DotsWidget и реализуйте в соответствии с дизайном.
          TodoPlaceholder(todo: 'Виджет для отображения индикации текущих шагов онбординга. Используйте _DotsWidget'),
          // TODO(any): перейдите в _StartButtonWidget и реализуйте в соответствии с дизайном.
          TodoPlaceholder(todo: 'Виджет для отображения кнопки "На старт". Используйте _StartButtonWidget'),
        ],
      ),
    );
  }
}
