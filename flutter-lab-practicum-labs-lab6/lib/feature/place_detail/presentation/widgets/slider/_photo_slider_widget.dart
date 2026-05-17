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
    final colorTheme = AppColorTheme.of(context);
    final needShowIndicator = images.length > 1;
    final topPositionBackButton = MediaQuery.paddingOf(context).top + 16;

    return LayoutBuilder(
      builder: (_, constraints) {
        return SizedBox(
          width: double.infinity,
          child: Stack(
            children: [
              PageView.builder(
                controller: pageController,
                onPageChanged: onPageChanged,
                itemBuilder: (_, index) {
                  final image = images.elementAtOrNull(index);

                  return image == null
                      ? const SizedBox.shrink()
                      : NetworkImageWidget(imgUrl: images[index], height: 360);
                },
                itemCount: images.length,
              ),
              Positioned(
                left: 16,
                top: topPositionBackButton,
                child: ButtonRounded(
                  size: 32,
                  backgroundColor: colorTheme.scaffold,
                  radius: 10,
                  icon: AppSvgIcons.icArrow,
                  iconColor: colorTheme.textSecondary,
                  onPressed: onBackPressed,
                ),
              ),
              if (needShowIndicator)
                Positioned(
                  bottom: 0,
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tight(Size(constraints.maxWidth, 8)),
                    child: ValueListenableBuilder(
                      valueListenable: currentIndex,
                      builder: (_, index, __) {
                        return _PhotoViewingIndicator(data: images, currentIndex: index);
                      },
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
