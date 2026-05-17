import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_mad_teacher_training/feature/onboarding/presentation/onboarding_model.dart';
import 'package:surf_mad_teacher_training/feature/onboarding/presentation/onboarding_screen.dart';
import 'package:surf_mad_teacher_training/feature/onboarding/presentation/onboarding_wm.dart';

/// {@template onboarding_screen_builder.class}
/// Виджет-обёртка для OnboardingScreen.
/// {@endtemplate}
class OnboardingScreenBuilder extends StatelessWidget {
  /// {@macro onboarding_screen_builder.class}
  const OnboardingScreenBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OnboardingWM(context: context, model: OnboardingModel()),
      builder: (builderContext, __) => OnboardingScreen(wm: builderContext.read<OnboardingWM>()),
    );
  }
}
