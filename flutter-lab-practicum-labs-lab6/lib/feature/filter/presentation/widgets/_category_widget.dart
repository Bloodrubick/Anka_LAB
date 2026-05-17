part of '../filter_screen.dart';

/// {@template _category_widget.class}
/// Виджет Категория для фильтра.
/// {@endtemplate}
class _CategoryWidget extends StatelessWidget {
  final PlaceType type;
  final bool isSelected;
  final ValueChanged<PlaceType> onPressed;

  /// {@macro _category_widget.class}
  const _CategoryWidget({required this.type, required this.isSelected, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppColorTheme.of(context);
    final textTheme = AppTextTheme.of(context);

    return Column(
      children: [
        Stack(
          children: [
            TextButton(
              onPressed: () => onPressed(type),
              style: TextButton.styleFrom(
                backgroundColor: colorTheme.accent.withValues(alpha: 0.2),
                elevation: 0,
                fixedSize: Size.square(64),
                shape: const CircleBorder(),
              ),
              child: SvgPictureWidget(type.icon, color: colorTheme.accent, width: 32, height: 32),
            ),
            if (isSelected)
              Positioned(
                right: 0,
                bottom: 0,
                child: ClipOval(
                  child: ColoredBox(
                    color: colorTheme.textPrimary,
                    child: SvgPictureWidget(AppSvgIcons.icTick, color: colorTheme.scaffold, width: 16, height: 16),
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 12),
        Text(type.label, style: textTheme.superSmall.copyWith(color: colorTheme.textPrimary)),
      ],
    );
  }
}
