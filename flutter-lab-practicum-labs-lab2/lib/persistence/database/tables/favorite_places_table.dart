import 'package:drift/drift.dart';
import 'package:surf_mad_teacher_training/feature/common/domain/entities/place_type.dart';

/// {@template favorite_places_table.class}
/// Таблица для хранения избранных мест.
/// {@endtemplate}
class FavoritePlacesTable extends Table {
  /// {@macro favorite_places_table.class}
  const FavoritePlacesTable();

  IntColumn get id => integer()();

  IntColumn get placeId => integer()();

  TextColumn get name => text()();

  TextColumn get description => text()();

  IntColumn get type => intEnum<PlaceType>()();

  TextColumn get images => text().map(const ListStringConverter())();

  RealColumn get lat => real()();

  RealColumn get lon => real()();

  @override
  Set<Column> get primaryKey => {id};
}

class ListStringConverter extends TypeConverter<List<String>, String> {
  const ListStringConverter();

  @override
  List<String> fromSql(String fromDb) {
    return fromDb.split(',');
  }

  @override
  String toSql(List<String> value) {
    return value.join(',');
  }
}
