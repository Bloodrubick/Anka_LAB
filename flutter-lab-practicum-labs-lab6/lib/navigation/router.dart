// ignore_for_file: prefer-match-file-name

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:surf_mad_teacher_training/feature/bottom_nav/presentation/bottom_nav_screen.dart';
import 'package:surf_mad_teacher_training/feature/common/domain/entities/place_entity.dart';
import 'package:surf_mad_teacher_training/feature/favorites/presentation/favorites_screen_builder.dart';
import 'package:surf_mad_teacher_training/feature/filter/domain/entities/filter_places_entity.dart';
import 'package:surf_mad_teacher_training/feature/filter/presentation/filter_screen_builder.dart';
import 'package:surf_mad_teacher_training/feature/onboarding/presentation/onboarding_screen_builder.dart';
import 'package:surf_mad_teacher_training/feature/place_detail/presentation/place_detail_screen_builder.dart';
import 'package:surf_mad_teacher_training/feature/places/presentation/places_list/places_screen_builder.dart';
import 'package:surf_mad_teacher_training/feature/search/presentation/search_screen_builder.dart';
import 'package:surf_mad_teacher_training/feature/settings/presentation/settings_screen_builder.dart';
import 'package:surf_mad_teacher_training/feature/splash/presentation/splash_screen_builder.dart';
import 'package:surf_mad_teacher_training/navigation/route_paths.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: SplashRouteBuilder.page,
      path: RoutePaths.splash,
      initial: true,
    ),
    AutoRoute(
      page: OnboardingRouteBuilder.page,
      path: RoutePaths.onboarding,
    ),
    AutoRoute(
      page: BottomNavRoute.page,
      path: RoutePaths.main,
      children: [
        AutoRoute(
          page: PlacesRouteBuilder.page,
          path: RoutePaths.places,
          initial: true,
        ),
        AutoRoute(
          page: FavoritesRouteBuilder.page,
          path: RoutePaths.favorites,
        ),
        AutoRoute(
          page: SettingsRouteBuilder.page,
          path: RoutePaths.settings,
        ),
      ],
    ),
    AutoRoute(
      page: SearchRouteBuilder.page,
      path: RoutePaths.search,
    ),
    AutoRoute(
      page: FilterRouteBuilder.page,
      path: RoutePaths.filter,
    ),
    AutoRoute(
      page: PlaceDetailRouteBuilder.page,
      path: RoutePaths.placeDetail,
    ),
  ];
}

/// Реализация пустого экрана.
@RoutePage(name: 'BaseRouter')
class EmptyRouterPage extends AutoRouter {
  /// @nodoc.
  const EmptyRouterPage({super.key});
}
