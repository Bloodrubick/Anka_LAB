part of '../places_screen.dart';

/// {@template _fake_search_bar_widget.class}
/// Декоративный виджет поисковой строки для главного экрана.
/// Выполняет роль перехода на другие экраны: поиск и настройка фильтра.
/// {@endtemplate}
class _FakeSearchBarWidget extends StatelessWidget {
  final VoidCallback onSearchPressed;
  final VoidCallback onFilterPressed;

  /// {@macro _fake_search_bar_widget.class}
  const _FakeSearchBarWidget({required this.onSearchPressed, required this.onFilterPressed});

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppColorTheme.of(context);
    final textTheme = AppTextTheme.of(context);

    return Material(
      color: colorTheme.surface,
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: 40,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(width: 12),
                SvgPictureWidget(AppSvgIcons.icSearch, color: colorTheme.inactive, width: 24, height: 24),
                const SizedBox(width: 12),
                Text(AppStrings.commonSearch, style: textTheme.text.copyWith(color: colorTheme.inactive)),
              ],
            ),
          ),
          Positioned.fill(child: Material(type: MaterialType.transparency, child: InkWell(onTap: onSearchPressed))),
          Positioned(
            top: 0,
            right: 0,
            child: ButtonRounded(
              size: 40,
              backgroundColor: Colors.transparent,
              radius: 10,
              icon: AppSvgIcons.icFilter,
              iconColor: colorTheme.accent,
              onPressed: onFilterPressed,
            ),
          ),
        ],
      ),
    );
  }
}
