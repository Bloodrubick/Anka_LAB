part of '../places_screen.dart';

/// {@template _sliver_places_appbar.class}
/// Sliver appBar для PlacesScreen.
/// Используем когда есть данные для отображения.
/// {@endtemplate}
class _SliverPlacesAppBar extends StatelessWidget {
  /// {@macro _sliver_places_appbar.class}
  const _SliverPlacesAppBar();

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppColorTheme.of(context);
    final textTheme = AppTextTheme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final collapsedHeight = kToolbarHeight + mediaQuery.padding.top;

    return SliverAppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: LayoutBuilder(
        builder: (_, constraints) {
          final topPadding = mediaQuery.padding.top;
          final currentExtent = constraints.biggest.height - topPadding;
          final showSmallTitle = currentExtent <= (collapsedHeight - topPadding);

          return FlexibleSpaceBar(
            title: AnimatedOpacity(
              opacity: showSmallTitle ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: Text(
                AppStrings.placesAppBarTitleSmall,
                style: textTheme.subtitle.copyWith(color: colorTheme.textPrimary),
                textAlign: TextAlign.center,
              ),
            ),
            background: ColoredBox(
              color: Theme.of(context).primaryColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 30,
                      child: Text(
                        AppStrings.placesAppBarTitle,
                        style: textTheme.largeTitle.copyWith(color: colorTheme.textPrimary),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            centerTitle: true,
          );
        },
      ),
      elevation: 0,
      expandedHeight: 136,
      pinned: true,
    );
  }
}
