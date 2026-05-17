/// {@template search_keyword_entity.class}
/// Сущность для хранения  поискового запроса.
/// {@endtemplate}
final class SearchKeywordEntity {
  final int id;
  final String keyword;

  const SearchKeywordEntity(this.id, {required this.keyword});
}
