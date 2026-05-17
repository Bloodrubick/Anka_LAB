import 'package:flutter/material.dart';

/// {@template lost_focus_wrapper.class}
/// A wrapper to reset the focus when tapping on an empty space.
/// {@endtemplate}
class LostFocusWrapper extends StatelessWidget {
  /// @nodoc.
  final Widget child;

  /// Кастомная обработка снятия фокуса.
  final VoidCallback? onCustomHandleTap;

  /// {@macro lost_focus_wrapper.class}
  const LostFocusWrapper({
    required this.child,
    super.key,
    this.onCustomHandleTap,
  });

  /// Обработка нажатия.
  void handlePressed(BuildContext context) {
    if (onCustomHandleTap != null) {
      onCustomHandleTap?.call();

      return;
    }

    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => handlePressed(context),
      behavior: HitTestBehavior.opaque,
      child: child,
    );
  }
}
