import 'package:shared_preferences/shared_preferences.dart';
import 'package:surf_mad_teacher_training/api/service/api_client.dart';
import 'package:surf_mad_teacher_training/feature/common/data/converters/favorite_place_from_db_converter.dart';
import 'package:surf_mad_teacher_training/feature/common/data/converters/favorite_place_to_db_converter.dart';
import 'package:surf_mad_teacher_training/feature/common/domain/repositories/i_favorites_repository.dart';
import 'package:surf_mad_teacher_training/feature/filter/data/converters/filter_places_converter.dart';
import 'package:surf_mad_teacher_training/feature/places/data/converters/place_response_converter.dart';
import 'package:surf_mad_teacher_training/feature/theme_mode/domain/repositories/i_theme_mode_repository.dart';
import 'package:surf_mad_teacher_training/persistence/database/app_database.dart';

/// {@template app_scope.class}
/// Скоуп зависимостей, которые необходимы на протяжении всей жизни приложения.
/// {@endtemplate}
final class AppScope implements IAppScope {
  @override
  final AppDatabase appDatabase;
  @override
  final SharedPreferences sharedPreferences;

  @override
  final ApiClient apiClient;
  @override
  final IThemeModeRepository themeModeRepository;
  @override
  final IFavoritesRepository favoritesRepository;
  @override
  final IFavoritePlaceFromDbConverter favoriteFromDbConverter;
  @override
  final IFavoritePlaceToDbConverter favoriteToDbConverter;
  @override
  final IFilterPlacesConverter filterPlacesConverter;
  @override
  final IPlaceResponseConverter placeResponseConverter;

  /// {@macro app_scope.class}
  const AppScope({
    required this.appDatabase,
    required this.sharedPreferences,
    required this.apiClient,
    required this.themeModeRepository,
    required this.favoritesRepository,
    required this.favoriteFromDbConverter,
    required this.favoriteToDbConverter,
    required this.filterPlacesConverter,
    required this.placeResponseConverter,
  });
}

/// {@macro app_scope.class}
abstract interface class IAppScope {
  /// База данных.
  AppDatabase get appDatabase;

  /// Shared preferences.
  SharedPreferences get sharedPreferences;

  /// Апи клиент.
  ApiClient get apiClient;

  /// Репозиторий для работы с темой приложения.
  IThemeModeRepository get themeModeRepository;

  /// Конвертер для фильтра.
  IFilterPlacesConverter get filterPlacesConverter;

  /// Конвертер для места.
  IPlaceResponseConverter get placeResponseConverter;

  /// Репозиторий для работы с Избранным.
  IFavoritesRepository get favoritesRepository;

  /// Конвертер для избранных мест.
  IFavoritePlaceFromDbConverter get favoriteFromDbConverter;

  /// Конвертер для избранных мест.
  IFavoritePlaceToDbConverter get favoriteToDbConverter;
}
