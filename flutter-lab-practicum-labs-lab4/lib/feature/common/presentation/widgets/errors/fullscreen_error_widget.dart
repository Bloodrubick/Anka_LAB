import 'package:flutter/material.dart';
import 'package:surf_mad_teacher_training/assets/strings/app_strings.dart';
import 'package:surf_mad_teacher_training/uikit/buttons/main_button.dart';
import 'package:surf_mad_teacher_training/uikit/images/svg_picture_widget.dart';
import 'package:surf_mad_teacher_training/uikit/themes/colors/app_color_theme.dart';
import 'package:surf_mad_teacher_training/uikit/themes/text/app_text_theme.dart';

/// {@template fullscreen_error_widget.class}
/// Виджет полноэкранной ошибки.
///
/// Виджет можно использовать самостоятельно для кастомной ошибки так и в обёртке AppErrorWidget
/// для передачи в него конфигурации ошибки.
/// {@endtemplate}
class FullScreenErrorWidget extends StatelessWidget {
  /// Заголовок ошибки.
  final String title;

  /// Описание ошибки.
  final String description;

  /// Путь к иконке.
  final String iconAssetName;

  /// Коллбек действия для повторения запроса.
  final VoidCallback? onRetryPressed;

  /// Создать экземпляр [FullScreenErrorWidget].
  const FullScreenErrorWidget({
    required this.title,
    required this.description,
    required this.iconAssetName,
    this.onRetryPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppColorTheme.of(context);
    final textTheme = AppTextTheme.of(context);
    final onRetryPressed = this.onRetryPressed;

    return Column(
      children: [
        Expanded(
          child: SizedBox.expand(
            child: ColoredBox(
              color: colorTheme.scaffold,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPictureWidget(iconAssetName, width: 64, height: 64),
                      SizedBox(height: 24),
                      Text(
                        title,
                        style: textTheme.subtitle.copyWith(color: colorTheme.inactive),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8),
                      Text(
                        description,
                        style: textTheme.small.copyWith(color: colorTheme.inactive),
                        textAlign: TextAlign.center,
                      ),
                      if (onRetryPressed != null) ...[
                        SizedBox(height: 24),
                        MainButton(onPressed: onRetryPressed, child: Text(AppStrings.errorRetryButton)),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        SafeArea(child: SizedBox(height: kToolbarHeight)),
      ],
    );
  }
}
