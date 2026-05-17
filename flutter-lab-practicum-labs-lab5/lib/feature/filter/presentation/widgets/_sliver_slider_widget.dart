part of '../filter_screen.dart';

/// {@template _sliver_slider_widget.class}
/// Виджет Слайдер с расстоянием для фильтра.
/// {@endtemplate}
class _SliverSliderWidget extends StatelessWidget {
  final ValueChanged<double> onSliderChange;

  final SettingsSliderEntity settingsSlider;
  final ValueListenable<double> sliderValueListenable;

  /// {@macro _sliver_slider_widget.class}
  const _SliverSliderWidget({
    required this.settingsSlider,
    required this.sliderValueListenable,
    required this.onSliderChange,
  });

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppColorTheme.of(context);
    final textTheme = AppTextTheme.of(context);

    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppStrings.filterDistance, style: textTheme.text.copyWith(color: colorTheme.textPrimary)),
                ValueListenableBuilder(
                  valueListenable: sliderValueListenable,
                  builder:
                      (_, value, __) => Text(
                        value.formattedSliderValue,
                        style: textTheme.text.copyWith(color: colorTheme.secondaryVariant),
                      ),
                ),
              ],
            ),
            SizedBox(height: 24),
            ValueListenableBuilder(
              valueListenable: sliderValueListenable,
              builder:
                  (_, value, __) => Slider(
                    value: value,
                    onChanged: onSliderChange,
                    min: settingsSlider.minValue,
                    max: settingsSlider.maxValue,
                    divisions: settingsSlider.divisions,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
