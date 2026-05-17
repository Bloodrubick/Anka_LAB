part of '../../place_detail_screen.dart';

/// {@template _photo_viewing_indicator.class}
/// Индикатор просмотра фотографий.
/// {@endtemplate}
class _PhotoViewingIndicator extends StatelessWidget {
  final List<String> data;
  final int currentIndex;

  /// {@macro _photo_viewing_indicator.class}
  const _PhotoViewingIndicator({required this.data, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppColorTheme.of(context);
    final isLastPage = currentIndex == data.length - 1;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(data.length, (index) {
        final radius = Radius.circular(index < currentIndex || isLastPage ? 0.0 : 8.0);

        return Expanded(
          child: SizedBox(
            height: 8,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: index <= currentIndex ? colorTheme.textPrimary : Colors.transparent,
                borderRadius: BorderRadius.only(topRight: radius, bottomRight: radius),
              ),
            ),
          ),
        );
      }),
    );
  }
}
