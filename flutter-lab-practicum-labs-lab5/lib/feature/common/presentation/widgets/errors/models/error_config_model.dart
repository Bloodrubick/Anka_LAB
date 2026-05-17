/// {@template error_config_model.class}
/// Модель конфигурации ошибки для ui.
/// {@endtemplate}
final class ErrorConfigModel {
  /// Описание ошибки.
  final String description;

  /// Путь к иконке.
  final String iconAssetName;

  /// Заголовок ошибки.
  final String title;

  /// {@macro error_config_model.class}
  const ErrorConfigModel({
    required this.title,
    required this.description,
    required this.iconAssetName,
  });
}
