import 'package:surf_mad_teacher_training/core/data/converter/converter.dart';
import 'package:surf_mad_teacher_training/feature/search/domain/entities/search_keyword_entity.dart';
import 'package:surf_mad_teacher_training/persistence/database/app_database.dart';

/// Конвертер [HistorySearchTableData] -> [SearchKeywordEntity] при извлечении из базы данных.
typedef ISearchKeywordFromDbConverter = Converter<SearchKeywordEntity, HistorySearchTableData>;

/// {@template search_keyword_from_db_converter.class}
/// Реализация для [ISearchKeywordFromDbConverter].
/// {@endtemplate}
final class SearchKeywordFromDbConverter extends ISearchKeywordFromDbConverter {
  /// {@macro search_keyword_from_db_converter.class}
  const SearchKeywordFromDbConverter();

  @override
  SearchKeywordEntity convert(HistorySearchTableData input) {
    return SearchKeywordEntity(
      input.id,
      keyword: input.keyword,
    );
  }
}
