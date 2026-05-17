part of '../../place_detail_screen.dart';

/// {@template _photo_slider_widget.class}
/// Виджет фотогалереи для подробности места.
/// {@endtemplate}
class _PhotoSliderWidget extends StatelessWidget {
  final PageController pageController;
  final List<String> images;
  final VoidCallback onBackPressed;
  final ValueListenable<int> currentIndex;
  final ValueChanged<int> onPageChanged;

  /// {@macro _photo_slider_widget}
  const _PhotoSliderWidget({
    required this.images,
    required this.pageController,
    required this.onBackPressed,
    required this.currentIndex,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColorTheme.of(context).inactive.withOpacity(0.2), // Цвет фона-заглушки
      child: Stack(
        children: [
          PageView.builder(
            controller: pageController,
            onPageChanged: onPageChanged,
            itemCount: images.length,
            itemBuilder: (context, index) {
              return Image.network(
                images[index],
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                errorBuilder: (_, __, ___) => Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColorTheme.of(context).accent, Colors.teal[600]!],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.photo_library, size: 50, color: Colors.white70),
                        const SizedBox(height: 8),
                        Text(
                          'Фотография ${index + 1}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        Positioned(
          top: MediaQuery.of(context).padding.top + 16,
          left: 16,
          child: GestureDetector(
            onTap: onBackPressed,
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColorTheme.of(context).neutralWhite,
                borderRadius: BorderRadius.circular(10), // В макете обычно прямоугольник со скруглениями
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                size: 16,
                color: AppColorTheme.of(context).textPrimary,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: ValueListenableBuilder<int>(
            valueListenable: currentIndex,
            builder: (context, index, _) {
              return _PhotoViewingIndicator(
                data: images,
                currentIndex: index,
              );
            },
          ),
        ),
      ],
    ));
  }
}
