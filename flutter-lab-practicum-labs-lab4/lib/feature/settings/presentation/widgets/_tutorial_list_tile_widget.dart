part of '../settings_screen.dart';

/// {@template _tutorial_list_tile_widget.class}
/// Виджет экрана настроек - переход к онбордингу.
/// {@endtemplate}
class _TutorialListTileWidget extends StatelessWidget {
  final VoidCallback onTutorialPressed;

  /// {@macro _tutorial_list_tile_widget.class}
  const _TutorialListTileWidget({required this.onTutorialPressed});

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppColorTheme.of(context);
    final textTheme = AppTextTheme.of(context);

    return ListTile(
      title: Text(AppStrings.settingTutorialTitle, style: textTheme.text.copyWith(color: colorTheme.textPrimary)),
      trailing: IconButton(
        onPressed: onTutorialPressed,
        icon: SvgPictureWidget(AppSvgIcons.icInfo, color: colorTheme.accent),
      ),
      contentPadding: EdgeInsets.zero,
    );
  }
}
