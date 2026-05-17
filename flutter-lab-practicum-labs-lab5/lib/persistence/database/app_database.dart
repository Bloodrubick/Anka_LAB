import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:surf_mad_teacher_training/feature/common/domain/entities/place_type.dart';
import 'package:surf_mad_teacher_training/persistence/database/daos/favorites_dao.dart';
import 'package:surf_mad_teacher_training/persistence/database/daos/history_search_dao.dart';
import 'package:surf_mad_teacher_training/persistence/database/tables/favorite_places_table.dart';
import 'package:surf_mad_teacher_training/persistence/database/tables/history_search_table.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    FavoritePlacesTable,
    HistorySearchTable,
  ],
  daos: [
    FavoritesDao,
    HistorySearchDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    return NativeDatabase.createInBackground(file);
  });
}
