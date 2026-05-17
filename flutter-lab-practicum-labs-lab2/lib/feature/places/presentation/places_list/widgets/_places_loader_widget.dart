part of '../places_screen.dart';

/// {@template _places_loader_widget.class}
/// Виджет списка мест для состояния загрузки всего списка.
/// {@endtemplate}
class _PlacesLoaderWidget extends StatelessWidget {
  /// {@macro _places_loader_widget.class}
  const _PlacesLoaderWidget();

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppColorTheme.of(context);
    final top = MediaQuery.paddingOf(context).top;

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        SizedBox(height: kToolbarHeight + top),
        FractionallySizedBox(
          alignment: Alignment.centerLeft,
          widthFactor: 0.5,
          child: Skeleton(
            height: 28,
            background: colorTheme.inactive,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
        ),
        const SizedBox(height: 8),
        FractionallySizedBox(
          alignment: Alignment.centerLeft,
          widthFactor: 0.8,
          child: Skeleton(
            height: 28,
            background: colorTheme.inactive,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
        ),
        const SizedBox(height: 24),
        Skeleton(width: double.infinity, height: 40, borderRadius: const BorderRadius.all(Radius.circular(8))),
        const SizedBox(height: 24),
        ...List.generate(3, (index) => const SkeletonPlaceCardWidget()),
      ],
    );
  }
}
