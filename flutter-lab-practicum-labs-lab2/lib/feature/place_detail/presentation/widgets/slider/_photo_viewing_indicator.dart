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
    if (data.length <= 1) {
      return const SizedBox.shrink();
    }

    // Если фотографий несколько, выводим индикатор внизу фото (Row из полосок)
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(data.length, (index) {
          final isActive = index == currentIndex;
          return Expanded(
            child: Container(
              margin: EdgeInsets.only(
                left: index == 0 ? 16.0 : 4.0,
                right: index == data.length - 1 ? 16.0 : 4.0,
              ),
              height: 8,
              decoration: BoxDecoration(
                color: isActive 
                    ? AppColorTheme.of(context).neutralWhite 
                    : AppColorTheme.of(context).neutralWhite.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
        }),
      ),
    );
  }
}
