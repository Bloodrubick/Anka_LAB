const _minValue = 100.0;
const _maxValue = 10000.0;
const _defaultValue = 3000.0;
const _stepValue = 500;

/// {@template settings_slider_entity.class}
/// SettingsSlider Entity - сущность с настройками для слайдера.
/// {@endtemplate}
class SettingsSliderEntity {
  final double defaultValue;
  final double maxValue;

  final double minValue;
  final int stepValue;

  /// {@macro settings_slider_entity.class}
  const SettingsSliderEntity({
    this.minValue = _minValue,
    this.maxValue = _maxValue,
    this.defaultValue = _defaultValue,
    this.stepValue = _stepValue,
  });

  /// Количество шагов слайдера между минимальным и максимальным значениями.
  int get divisions => _setSliderDivisions();

  int _setSliderDivisions() {
    final distance = maxValue - minValue;

    return (distance / _stepValue).ceil();
  }
}
