part of '../onboarding_screen.dart';

/// {@template _dots_widget.class}
/// Виджет индикатор для шагов онбординга.
/// {@endtemplate}
class _DotsWidget extends StatelessWidget {
  final int dotsCount;
  final int currentDotIndex;

  /// {@macro _dots_widget.class}
  const _DotsWidget({required this.dotsCount, required this.currentDotIndex});

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppColorTheme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 8,
      children: List.generate(
        dotsCount,
        (index) =>
            index == currentDotIndex
                ? DecoratedBox(
                  decoration: BoxDecoration(
                    color: colorTheme.accent,
                    borderRadius: const BorderRadius.all(Radius.circular(32)),
                  ),
                  child: SizedBox(width: 24, height: 8),
                )
                : DecoratedBox(
                  decoration: BoxDecoration(color: colorTheme.inactive, shape: BoxShape.circle),
                  child: SizedBox.square(dimension: 8),
                ),
      ),
    );
  }
}
