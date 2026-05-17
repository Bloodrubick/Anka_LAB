import 'package:drift/drift.dart';
import 'package:surf_mad_teacher_training/core/data/converter/converter.dart';
import 'package:surf_mad_teacher_training/persistence/database/app_database.dart';

/// Конвертер [String] -> [HistorySearchTableCompanion] для добавления в базу данных.
typedef ISearchKeywordToDbConverter = Converter<HistorySearchTableCompanion, String>;

/// {@template search_keyword_to_db_converter}
/// Реализация для [ISearchKeywordToDbConverter].
/// {@endtemplate}
final class SearchKeywordToDbConverter extends ISearchKeywordToDbConverter {
  /// {@macro search_keyword_to_db_converter}
  const SearchKeywordToDbConverter();

  @override
  HistorySearchTableCompanion convert(String input) {
    return HistorySearchTableCompanion(
      keyword: Value(input),
    );
  }
}
