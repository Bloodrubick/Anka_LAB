import 'dart:async';

import 'package:flutter/material.dart';
import 'package:surf_mad_teacher_training/feature/onboarding/domain/entities/onboarding_step_type.dart';
import 'package:surf_mad_teacher_training/feature/onboarding/presentation/onboarding_model.dart';

abstract interface class IOnboardingWM implements ChangeNotifier {
  int get currentStepIndex;

  bool get isLastStep;

  void onFinishOnboardingPressed();

  void onGoToNextStep();

  void onGoToPreviousStep();

  void onGoToStepByIndex({required int stepIndex});

  void onSkipOnboardingPressed();
}

final class OnboardingWM extends ChangeNotifier implements IOnboardingWM {
  final IOnboardingModel _model;
  final BuildContext _context;

  int _currentStepIndex;

  OnboardingWM({required BuildContext context, required IOnboardingModel model})
    : _context = context,
      _model = model,
      _currentStepIndex = 0;

  @override
  int get currentStepIndex => _currentStepIndex;

  @override
  bool get isLastStep => _currentStepIndex == OnboardingStepType.values.length - 1;

  @override
  void onFinishOnboardingPressed() => unawaited(_saveOnboardingCompletion());

  @override
  void onGoToNextStep() {
    _currentStepIndex += 1;

    notifyListeners();
  }

  @override
  void onGoToPreviousStep() {
    _currentStepIndex -= 1;

    notifyListeners();
  }

  @override
  void onGoToStepByIndex({required int stepIndex}) {
    _currentStepIndex = stepIndex;

    notifyListeners();
  }

  @override
  void onSkipOnboardingPressed() => unawaited(_saveOnboardingCompletion());

  Future<void> _saveOnboardingCompletion() async {
    await _model.saveOnboardingCompletion();

    if (!_context.mounted) return;
  }
}
