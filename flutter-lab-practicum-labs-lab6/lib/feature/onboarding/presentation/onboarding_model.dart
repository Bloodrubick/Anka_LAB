import 'package:shared_preferences/shared_preferences.dart';

/// {@template onboarding_model}
/// Модель для OnboardingScreen.
/// {@endtemplate}
final class OnboardingModel implements IOnboardingModel {
  /// {@macro onboarding_model}
  const OnboardingModel();

  @override
  Future<void> saveOnboardingCompletion() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('first_launch', false);
  }
}

abstract interface class IOnboardingModel {
  Future<void> saveOnboardingCompletion();
}
