import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:surf_mad_teacher_training/feature/app/di/app_scope.dart';
import 'package:surf_mad_teacher_training/feature/places/data/repositories/places_repository.dart';

abstract final class PlacesDependencies {
  static List<SingleChildWidget> providers() {
    return [
      Provider(
        create: (context) {
          final appScope = context.read<IAppScope>();

          return PlacesRepository(
            apiClient: appScope.apiClient,
            filterPlacesConverter: appScope.filterPlacesConverter,
            placeResponseConverter: appScope.placeResponseConverter,
          );
        },
      ),
    ];
  }
}
