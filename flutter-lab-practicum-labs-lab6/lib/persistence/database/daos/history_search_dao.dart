import 'package:drift/drift.dart';
import 'package:surf_mad_teacher_training/persistence/database/app_database.dart';
import 'package:surf_mad_teacher_training/persistence/database/tables/history_search_table.dart';

part 'history_search_dao.g.dart';

@DriftAccessor(tables: [HistorySearchTable])
class HistorySearchDao extends DatabaseAccessor<AppDatabase> with _$HistorySearchDaoMixin {
  HistorySearchDao(super.attachedDatabase);

  Stream<List<HistorySearchTableData>> get historySearchStream =>
      (select(historySearchTable)
        ..orderBy([(tbl) => OrderingTerm(expression: tbl.id, mode: OrderingMode.desc)])).watch();

  Future<void> saveKeyword(HistorySearchTableCompanion keyword) async {
    final existing =
        await (select(historySearchTable)..where((tbl) => tbl.keyword.equals(keyword.keyword.value))).getSingleOrNull();
    if (existing == null) {
      await into(historySearchTable).insert(keyword);
    }
  }

  Future<void> removeKeyword(int keywordId) =>
      (delete(historySearchTable)..where((tbl) => tbl.id.equals(keywordId))).go();

  Future<void> clearHistory() => delete(historySearchTable).go();
}
