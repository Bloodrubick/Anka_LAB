import 'package:surf_mad_teacher_training/assets/strings/app_strings.dart';

extension SliderValueExtension on double {
  /// Возвращает форматированное значение слайдера.
  String get formattedSliderValue {
    if (this < 1000) {
      return '${toInt()} ${AppStrings.filterDistanceM}';
    }

    final kmValue = (this / 1000).toStringAsFixed(1);

    return '${kmValue.endsWith('.0') ? kmValue.substring(0, kmValue.length - 2) : kmValue} ${AppStrings.filterDistanceKm}';
  }
}
