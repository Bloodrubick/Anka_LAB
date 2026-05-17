import 'package:surf_mad_teacher_training/core/data/repositories/base_repository.dart';
import 'package:surf_mad_teacher_training/core/domain/entities/result/request_operation.dart';
import 'package:surf_mad_teacher_training/feature/filter/domain/repositories/i_filter_repository.dart';
import 'package:surf_mad_teacher_training/feature/filter/domain/entities/filter_places_entity.dart';
import 'package:surf_mad_teacher_training/feature/places/data/converters/filter_places_converter.dart';
import 'package:surf_mad_teacher_training/api/service/api_client_remote.dart';

/// {@template filter_repository.class}
/// Implementation of [IFilterRepository].
/// {@endtemplate}
final class FilterRepository extends BaseRepository implements IFilterRepository {
  final ApiClientRemote _apiClient;
  final IFilterPlacesConverter _filterConverter;

  /// {@macro filter_repository.class}
  const FilterRepository({
    required ApiClientRemote apiClient,
    required IFilterPlacesConverter filterConverter,
  }) : _apiClient = apiClient,
       _filterConverter = filterConverter;

  @override
  RequestOperation<int> getPlaces({required FilterPlacesEntity filter}) => makeApiCall(() async {
    final filterDto = _filterConverter.convertEntityToDto(filter);
    final data = await _apiClient.getFilteredPlaces(filter: filterDto);

    return data.length;
  });
}
