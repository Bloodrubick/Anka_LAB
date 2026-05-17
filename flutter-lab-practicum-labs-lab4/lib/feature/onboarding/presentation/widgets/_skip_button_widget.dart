part of '../onboarding_screen.dart';

/// {@template _skip_button_widget.class}
/// Кнопка Пропустить для онбординга.
/// {@endtemplate}
class _SkipButtonWidget extends StatelessWidget {
  final bool isLastPage;
  final VoidCallback onSkipPressed;

  /// {@macro _skip_button_widget.class}
  const _SkipButtonWidget({required this.isLastPage, required this.onSkipPressed});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child:
          isLastPage
              ? const SizedBox.shrink()
              : TextButtonWidget(title: AppStrings.onboardingSkipButton, onPressed: onSkipPressed),
    );
  }
}
