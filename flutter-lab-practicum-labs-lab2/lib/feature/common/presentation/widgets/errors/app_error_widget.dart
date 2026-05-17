import 'package:flutter/material.dart';
import 'package:surf_mad_teacher_training/assets/images/app_svg_icons.dart';
import 'package:surf_mad_teacher_training/assets/strings/app_strings.dart';
import 'package:surf_mad_teacher_training/core/domain/entities/failure/failure.dart';
import 'package:surf_mad_teacher_training/core/domain/entities/failure/network/no_network_failure.dart';
import 'package:surf_mad_teacher_training/feature/common/presentation/widgets/errors/fullscreen_error_widget.dart';
import 'package:surf_mad_teacher_training/feature/common/presentation/widgets/errors/models/error_config_model.dart';

/// {@template app_error_widget.class}
/// Виджет полноэкранной ошибки приложения.
/// {@endtemplate}
class AppErrorWidget extends StatelessWidget {
  /// Ошибка.
  final Failure? exception;

  /// Коллбек действия для повторения запроса.
  final VoidCallback onRetryPressed;

  /// {@macro app_error_widget.class}
  const AppErrorWidget(this.exception, {required this.onRetryPressed, super.key});

  @override
  Widget build(BuildContext context) {
    final config = _getConfig(exception);

    return FullScreenErrorWidget(
      title: config.title,
      description: config.description,
      iconAssetName: config.iconAssetName,
      onRetryPressed: onRetryPressed,
    );
  }

  /// Конфигурация ошибки для виджета.
  ErrorConfigModel _getConfig(Failure? failure) {
    return switch (failure) {
      NoNetworkFailure() => ErrorConfigModel(
        title: AppStrings.errorNoInternetTitle,
        description: AppStrings.errorNoInternetDescription,
        iconAssetName: AppSvgIcons.icNetworkException,
      ),
      _ => ErrorConfigModel(
        title: AppStrings.errorDefaultTitle,
        description: AppStrings.errorDefaultDescription,
        iconAssetName: AppSvgIcons.icNetworkException,
      ),
    };
  }
}
