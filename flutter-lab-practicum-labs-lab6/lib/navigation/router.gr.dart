// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

/// generated route for
/// [BottomNavScreen]
class BottomNavRoute extends PageRouteInfo<void> {
  const BottomNavRoute({List<PageRouteInfo>? children})
    : super(BottomNavRoute.name, initialChildren: children);

  static const String name = 'BottomNavRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const BottomNavScreen();
    },
  );
}

/// generated route for
/// [EmptyRouterPage]
class BaseRouter extends PageRouteInfo<void> {
  const BaseRouter({List<PageRouteInfo>? children})
    : super(BaseRouter.name, initialChildren: children);

  static const String name = 'BaseRouter';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const EmptyRouterPage();
    },
  );
}

/// generated route for
/// [FavoritesScreenBuilder]
class FavoritesRouteBuilder extends PageRouteInfo<void> {
  const FavoritesRouteBuilder({List<PageRouteInfo>? children})
    : super(FavoritesRouteBuilder.name, initialChildren: children);

  static const String name = 'FavoritesRouteBuilder';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const FavoritesScreenBuilder();
    },
  );
}

/// generated route for
/// [FilterScreenBuilder]
class FilterRouteBuilder extends PageRouteInfo<FilterRouteBuilderArgs> {
  FilterRouteBuilder({
    required FilterPlacesEntity initialFilter,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         FilterRouteBuilder.name,
         args: FilterRouteBuilderArgs(initialFilter: initialFilter, key: key),
         initialChildren: children,
       );

  static const String name = 'FilterRouteBuilder';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FilterRouteBuilderArgs>();
      return FilterScreenBuilder(
        initialFilter: args.initialFilter,
        key: args.key,
      );
    },
  );
}

class FilterRouteBuilderArgs {
  const FilterRouteBuilderArgs({required this.initialFilter, this.key});

  final FilterPlacesEntity initialFilter;

  final Key? key;

  @override
  String toString() {
    return 'FilterRouteBuilderArgs{initialFilter: $initialFilter, key: $key}';
  }
}

/// generated route for
/// [OnboardingScreenBuilder]
class OnboardingRouteBuilder extends PageRouteInfo<void> {
  const OnboardingRouteBuilder({List<PageRouteInfo>? children})
    : super(OnboardingRouteBuilder.name, initialChildren: children);

  static const String name = 'OnboardingRouteBuilder';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const OnboardingScreenBuilder();
    },
  );
}

/// generated route for
/// [PlaceDetailScreenBuilder]
class PlaceDetailRouteBuilder
    extends PageRouteInfo<PlaceDetailRouteBuilderArgs> {
  PlaceDetailRouteBuilder({
    required PlaceEntity place,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         PlaceDetailRouteBuilder.name,
         args: PlaceDetailRouteBuilderArgs(place: place, key: key),
         initialChildren: children,
       );

  static const String name = 'PlaceDetailRouteBuilder';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PlaceDetailRouteBuilderArgs>();
      return PlaceDetailScreenBuilder(place: args.place, key: args.key);
    },
  );
}

class PlaceDetailRouteBuilderArgs {
  const PlaceDetailRouteBuilderArgs({required this.place, this.key});

  final PlaceEntity place;

  final Key? key;

  @override
  String toString() {
    return 'PlaceDetailRouteBuilderArgs{place: $place, key: $key}';
  }
}

/// generated route for
/// [PlacesScreenBuilder]
class PlacesRouteBuilder extends PageRouteInfo<void> {
  const PlacesRouteBuilder({List<PageRouteInfo>? children})
    : super(PlacesRouteBuilder.name, initialChildren: children);

  static const String name = 'PlacesRouteBuilder';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const PlacesScreenBuilder();
    },
  );
}

/// generated route for
/// [SearchScreenBuilder]
class SearchRouteBuilder extends PageRouteInfo<SearchRouteBuilderArgs> {
  SearchRouteBuilder({
    required FilterPlacesEntity initialFilter,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         SearchRouteBuilder.name,
         args: SearchRouteBuilderArgs(initialFilter: initialFilter, key: key),
         initialChildren: children,
       );

  static const String name = 'SearchRouteBuilder';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SearchRouteBuilderArgs>();
      return SearchScreenBuilder(
        initialFilter: args.initialFilter,
        key: args.key,
      );
    },
  );
}

class SearchRouteBuilderArgs {
  const SearchRouteBuilderArgs({required this.initialFilter, this.key});

  final FilterPlacesEntity initialFilter;

  final Key? key;

  @override
  String toString() {
    return 'SearchRouteBuilderArgs{initialFilter: $initialFilter, key: $key}';
  }
}

/// generated route for
/// [SettingsScreenBuilder]
class SettingsRouteBuilder extends PageRouteInfo<void> {
  const SettingsRouteBuilder({List<PageRouteInfo>? children})
    : super(SettingsRouteBuilder.name, initialChildren: children);

  static const String name = 'SettingsRouteBuilder';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SettingsScreenBuilder();
    },
  );
}

/// generated route for
/// [SplashScreenBuilder]
class SplashRouteBuilder extends PageRouteInfo<void> {
  const SplashRouteBuilder({List<PageRouteInfo>? children})
    : super(SplashRouteBuilder.name, initialChildren: children);

  static const String name = 'SplashRouteBuilder';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SplashScreenBuilder();
    },
  );
}
