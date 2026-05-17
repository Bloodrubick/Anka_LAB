part of '../onboarding_screen.dart';

/// {@template _onboarding_step_widget.class}
/// Виджет шага онбординга.
/// {@endtemplate}
class _OnboardingStepWidget extends StatelessWidget {
  final String icon;
  final String title;
  final String description;

  /// {@macro _onboarding_step_widget.class}
  const _OnboardingStepWidget({required this.icon, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppColorTheme.of(context);
    final textTheme = AppTextTheme.of(context);

    return Column(
      children: [
        Spacer(flex: 3),
        SvgPictureWidget(icon, color: colorTheme.textPrimary, width: 104, height: 104),
        SizedBox(height: 40),
        Text(title, style: textTheme.title.copyWith(color: colorTheme.textPrimary), textAlign: TextAlign.center),
        SizedBox(height: 8),
        Text(
          description,
          style: textTheme.small.copyWith(color: colorTheme.textSecondaryVariant),
          textAlign: TextAlign.center,
        ),
        Spacer(flex: 2),
      ],
    );
  }
}
