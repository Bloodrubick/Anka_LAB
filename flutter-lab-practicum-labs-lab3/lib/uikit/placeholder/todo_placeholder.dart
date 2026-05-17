import 'package:flutter/material.dart';
import 'package:surf_mad_teacher_training/uikit/themes/colors/app_color_theme.dart';
import 'package:surf_mad_teacher_training/uikit/themes/text/app_text_theme.dart';

/// "Placeholder" для описания того, что необходимо сделать.
class TodoPlaceholder extends StatelessWidget {
  final String todo;
  final double? height;
  final double? width;
  final Widget? child;

  /// Creates a [TodoPlaceholder] widget.
  const TodoPlaceholder({required this.todo, this.child, this.height, this.width = double.infinity, super.key});

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppColorTheme.of(context);
    final textTheme = AppTextTheme.of(context);
    final child = this.child;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: SizedBox(
        width: width,
        height: height,
        child: DecoratedBox(
          decoration: BoxDecoration(border: Border.fromBorderSide(BorderSide(color: colorTheme.accent))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text.rich(
                  TextSpan(
                    style: textTheme.text,
                    children: [
                      TextSpan(text: 'TODO: ', style: textTheme.textMedium.copyWith(color: colorTheme.error)),
                      TextSpan(text: todo),
                    ],
                  ),
                ),
              ),
              if (child != null) ...[SizedBox(height: 8), child],
            ],
          ),
        ),
      ),
    );
  }
}
