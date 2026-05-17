import 'package:drift/drift.dart';
import 'package:surf_mad_teacher_training/persistence/database/app_database.dart';
import 'package:surf_mad_teacher_training/persistence/database/tables/favorite_places_table.dart';

part 'favorites_dao.g.dart';

@DriftAccessor(tables: [FavoritePlacesTable])
class FavoritesDao extends DatabaseAccessor<AppDatabase> with _$FavoritesDaoMixin {
  FavoritesDao(super.attachedDatabase);

  Stream<List<FavoritePlacesTableData>> get favoritesStream => select(favoritePlacesTable).watch();

  Future<List<FavoritePlacesTableData>> fetchFavorites() => select(favoritePlacesTable).get();

  Future<void> addFavorite(FavoritePlacesTableCompanion place) =>
      into(favoritePlacesTable).insert(place, mode: InsertMode.replace);

  Future<void> removeFavorite(int placeId) =>
      (delete(favoritePlacesTable)..where((tbl) => tbl.placeId.equals(placeId))).go();
}
