part of '../place_detail_screen.dart';

/// {@template _route_button_widget.class}
/// Кнопка для построения маршрута.
/// {@endtemplate}
class _RouteButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;

  /// {@macro _route_button_widget.class}
  const _RouteButtonWidget({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppColorTheme.of(context);

    return MainButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPictureWidget(AppSvgIcons.icGo, color: colorTheme.neutralWhite),
          SizedBox(width: 8),
          Text(AppStrings.placeDetailsRouteButton.toUpperCase()),
        ],
      ),
    );
  }
}
