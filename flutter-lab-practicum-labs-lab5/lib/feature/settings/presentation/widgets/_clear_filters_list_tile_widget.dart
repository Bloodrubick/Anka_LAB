part of '../settings_screen.dart';

/// {@template _clear_filters_list_tile_widget.class}
/// Виджет экрана настроек - очистка настроек фильтра.
/// {@endtemplate}
class _ClearFiltersListTileWidget extends StatelessWidget {
  final VoidCallback onClearFiltersPressed;

  /// {@macro _clear_filters_list_tile_widget.class}
  const _ClearFiltersListTileWidget({required this.onClearFiltersPressed});

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppColorTheme.of(context);
    final textTheme = AppTextTheme.of(context);

    return ListTile(
      title: Text(
        AppStrings.settingClearFiltersTitle,
        style: textTheme.text.copyWith(color: colorTheme.textPrimary),
      ),
      trailing: IconButton(
        onPressed: onClearFiltersPressed,
        icon: Icon(Icons.filter_alt_off_outlined, color: colorTheme.accent),
      ),
      contentPadding: EdgeInsets.zero,
    );
  }
}
