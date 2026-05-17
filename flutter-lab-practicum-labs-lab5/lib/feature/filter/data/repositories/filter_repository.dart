import 'dart:async';

import 'package:surf_mad_teacher_training/api/service/api_client.dart';
import 'package:surf_mad_teacher_training/core/data/repositories/base_repository.dart';
import 'package:surf_mad_teacher_training/core/domain/entities/result/request_operation.dart';
import 'package:surf_mad_teacher_training/feature/filter/data/converters/filter_places_converter.dart';
import 'package:surf_mad_teacher_training/feature/filter/domain/entities/filter_places_entity.dart';
import 'package:surf_mad_teacher_training/feature/filter/domain/repositories/i_filter_repository.dart';
import 'package:surf_mad_teacher_training/persistence/filter_storage/i_filter_storage.dart';

/// {@template filter_repository.class}
/// Implementation of [IFilterRepository].
/// {@endtemplate}
final class FilterRepository extends BaseRepository implements IFilterRepository {
  final ApiClient _apiClient;
  final IFilterPlacesConverter _filterPlacesConverter;
  final IFilterStorage _filterStorage;

  /// {@macro filter_repository.class}
  const FilterRepository({
    required ApiClient apiClient,
    required IFilterPlacesConverter filterPlacesConverter,
    required IFilterStorage filterStorage,
  }) : _apiClient = apiClient,
       _filterPlacesConverter = filterPlacesConverter,
       _filterStorage = filterStorage;

  @override
  RequestOperation<int> getFilteredPlaces({required FilterPlacesEntity filter}) => makeApiCall(() async {
    final data = await _apiClient.getFilteredPlaces(filter: _filterPlacesConverter.convertReverse(filter));

    return data.length;
  });

  // TODO(lab5): реализовать метод получения сохранённого фильтра
  @override
  Future<FilterPlacesEntity> getSavedFilter() => _filterStorage.getFilter();

  // TODO(lab5): реализовать метод сохранения фильтра
  @override
  Future<void> saveFilter({required FilterPlacesEntity filter}) =>
      _filterStorage.saveFilter(filter: filter);
}
