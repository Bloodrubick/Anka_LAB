import 'package:drift/drift.dart';

/// {@template history_search_table.class}
/// Таблица для хранения истории поисковых запросов.
/// {@endtemplate}
class HistorySearchTable extends Table {
  /// {@macro history_search_table.class}
  const HistorySearchTable();

  IntColumn get id => integer()();

  TextColumn get keyword => text()();

  @override
  Set<Column> get primaryKey => {id};
}
