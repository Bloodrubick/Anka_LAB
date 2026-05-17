part of '../onboarding_screen.dart';

/// {@template _start_button_widget.class}
/// Кнопка "На старт" для онбординга.
/// {@endtemplate}
class _StartButtonWidget extends StatelessWidget {
  final bool isLastPage;
  final VoidCallback onStartPressed;

  /// {@macro _start_button_widget.class}
  const _StartButtonWidget({required this.isLastPage, required this.onStartPressed});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child:
          isLastPage
              ? SizedBox(
                key: const ValueKey('isLastPage'),
                width: double.infinity,
                height: 48,
                child: MainButton(
                  onPressed: onStartPressed,
                  child: Text(AppStrings.onboardingStartButton.toUpperCase()),
                ),
              )
              : const SizedBox.square(dimension: 48),
    );
  }
}
