import 'dart:async';
import 'package:surf_mad_teacher_training/core/domain/entities/result/result.dart';

import 'package:flutter/foundation.dart';
import 'package:surf_mad_teacher_training/feature/filter/domain/entities/filter_places_entity.dart';
import 'package:surf_mad_teacher_training/feature/filter/domain/entities/filtered_places_state.dart';
import 'package:surf_mad_teacher_training/feature/filter/domain/repositories/i_filter_repository.dart';
import 'package:surf_mad_teacher_training/persistence/filter_storage/filter_storage.dart';
import 'package:surf_mad_teacher_training/feature/places/data/converters/filter_places_converter.dart';

/// {@template filter_model.class}
/// Модель для FilterScreen.
/// {@endtemplate}
final class FilterModel implements IFilterModel {
  final IFilterRepository _filterRepository;
  final IFilterStorage _filterStorage;
  final IFilterPlacesConverter _filterPlacesConverter;
  final _placesState = ValueNotifier<FilteredPlacesState>(FilteredPlacesStateLoading());

  /// {@macro filter_model.class}
  FilterModel({
    required IFilterRepository filterRepository,
    required IFilterStorage filterStorage,
    required IFilterPlacesConverter filterPlacesConverter,
  }) : _filterRepository = filterRepository,
       _filterStorage = filterStorage,
       _filterPlacesConverter = filterPlacesConverter;

  @override
  ValueListenable<FilteredPlacesState> get placesStateListenable => _placesState;

  @override
  void dispose() {
    _placesState.dispose();
  }

  @override
  Future<void> getFilteredPlaces({required FilterPlacesEntity filter}) async {
    final filterType = filter.type;
    if (filterType == null || filterType.isEmpty) {
      _placesState.value = FilteredPlacesStateData(0);

      return;
    }

    _placesState.value = FilteredPlacesStateLoading();
    final result = await _filterRepository.getPlaces(filter: filter);

    switch (result) {
      case ResultOk(:final data):
        _placesState.value = FilteredPlacesStateData(data);
      case ResultFailed(:final error):
        _placesState.value = FilteredPlacesStateFailure(error);
    }
  }

  @override
  Future<void> saveFilter({required FilterPlacesEntity filter}) async {
    final map = _filterPlacesConverter.convertEntityToMap(filter);
    await _filterStorage.saveFilter(map);
  }
}

abstract interface class IFilterModel {
  ValueListenable<FilteredPlacesState> get placesStateListenable;

  void dispose();

  Future<void> getFilteredPlaces({required FilterPlacesEntity filter});

  Future<void> saveFilter({required FilterPlacesEntity filter});
}
