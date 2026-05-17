import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:surf_mad_teacher_training/feature/app/di/app_scope.dart';
import 'package:surf_mad_teacher_training/feature/search/data/converters/search_keyword_from_db_converter.dart';
import 'package:surf_mad_teacher_training/feature/search/data/converters/search_keyword_to_db_converter.dart';
import 'package:surf_mad_teacher_training/feature/search/data/repositories/search_repository.dart';

abstract final class SearchDependencies {
  static List<SingleChildWidget> providers() {
    return [
      Provider(
        create: (context) {
          final appScope = context.read<IAppScope>();

          return SearchRepository(
            apiClient: appScope.apiClient,
            historySearchDao: appScope.appDatabase.historySearchDao,
            placeResponseConverter: appScope.placeResponseConverter,
            fromDbConverter: SearchKeywordFromDbConverter(),
            toDbConverter: SearchKeywordToDbConverter(),
          );
        },
        dispose: (_, repository) => repository.dispose(),
      ),
    ];
  }
}
