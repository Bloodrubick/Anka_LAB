part of '../settings_screen.dart';

/// {@template _theme_switch_widget.class}
/// Виджет экрана настроек - переключение темы.
/// {@endtemplate}
class _ThemeSwitchWidget extends StatelessWidget {
  final ValueListenable<bool> isDarkThemeModeState;
  final ValueChanged<bool> onChanged;

  /// {@macro _theme_switch_widget.class}
  const _ThemeSwitchWidget({required this.isDarkThemeModeState, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppColorTheme.of(context);
    final textTheme = AppTextTheme.of(context);

    return ListTile(
      title: Text(AppStrings.settingThemeDarkTitle, style: textTheme.text.copyWith(color: colorTheme.textPrimary)),
      trailing: ValueListenableBuilder(
        valueListenable: isDarkThemeModeState,
        builder: (_, isDark, __) => CupertinoSwitch(value: isDark, onChanged: onChanged),
      ),
      contentPadding: EdgeInsets.zero,
    );
  }
}
