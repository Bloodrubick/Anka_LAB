import 'package:shared_preferences/shared_preferences.dart';
import 'package:surf_mad_teacher_training/api/service/api_client_from_assets.dart';
import 'package:surf_mad_teacher_training/feature/app/di/app_scope.dart';
import 'package:surf_mad_teacher_training/feature/common/data/converters/favorite_place_from_db_converter.dart';
import 'package:surf_mad_teacher_training/feature/common/data/converters/favorite_place_to_db_converter.dart';
import 'package:surf_mad_teacher_training/feature/common/data/repositories/favorites_repository.dart';
import 'package:surf_mad_teacher_training/feature/filter/data/converters/filter_places_converter.dart';
import 'package:surf_mad_teacher_training/feature/places/data/converters/place_response_converter.dart';
import 'package:surf_mad_teacher_training/feature/theme_mode/data/repositories/theme_mode_repository.dart';
import 'package:surf_mad_teacher_training/persistence/database/app_database.dart';
import 'package:surf_mad_teacher_training/persistence/theme_storage/theme_mode_storage.dart';

/// {@template app_scope_register.class}
/// Creates and initializes AppScope.
/// {@endtemplate}
final class AppScopeRegister {
  /// {@macro app_scope_register.class}
  const AppScopeRegister();

  /// Create scope.
  Future<IAppScope> createScope() async {
    /// Общее.
    final sharedPreferences = await SharedPreferences.getInstance();
    final appDatabase = AppDatabase();

    /// Хранилища.
    final themeModeStorage = ThemeModeStorage(sharedPreferences);

    /// API
    final apiClient = ApiClientFromAssets();

    /// Конвертеры.
    final favoriteFromDbConverter = FavoritePlaceFromDbConverter();
    final favoriteToDbConverter = FavoritePlaceToDbConverter();
    final filterPlacesConverter = FilterPlacesConverter();
    final placeResponseConverter = PlaceResponseConverter();

    /// Репозитории.
    final themeModeRepository = ThemeModeRepository(themeModeStorage: themeModeStorage);
    final favoritesRepository = FavoritesRepository(
      favoritesDao: appDatabase.favoritesDao,
      fromDbConverter: favoriteFromDbConverter,
      toDbConverter: favoriteToDbConverter,
    );

    return AppScope(
      appDatabase: appDatabase,
      sharedPreferences: sharedPreferences,
      apiClient: apiClient,
      themeModeRepository: themeModeRepository,
      favoritesRepository: favoritesRepository,
      favoriteFromDbConverter: favoriteFromDbConverter,
      favoriteToDbConverter: favoriteToDbConverter,
      filterPlacesConverter: filterPlacesConverter,
      placeResponseConverter: placeResponseConverter,
    );
  }
}
