import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:surf_mad_teacher_training/core/domain/entities/result/result.dart';
import 'package:surf_mad_teacher_training/feature/filter/domain/entities/filter_places_entity.dart';
import 'package:surf_mad_teacher_training/feature/filter/domain/entities/filtered_places_state.dart';
import 'package:surf_mad_teacher_training/feature/filter/domain/repositories/i_filter_repository.dart';

/// {@template filter_model.class}
/// Модель для FilterScreen.
/// {@endtemplate}
final class FilterModel implements IFilterModel {
  final IFilterRepository _filterRepository;
  final _placesState = ValueNotifier<FilteredPlacesState>(FilteredPlacesStateLoading());

  /// {@macro filter_model.class}
  FilterModel({required IFilterRepository filterRepository}) : _filterRepository = filterRepository;

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
    final result = await _filterRepository.getFilteredPlaces(filter: filter);

    switch (result) {
      case ResultOk(:final data):
        _placesState.value = FilteredPlacesStateData(data);
      case ResultFailed(:final error):
        _placesState.value = FilteredPlacesStateFailure(error);
    }
  }

  @override
  Future<void> saveFilter({required FilterPlacesEntity filter}) async {
    await _filterRepository.saveFilter(filter: filter);
  }
}

abstract interface class IFilterModel {
  ValueListenable<FilteredPlacesState> get placesStateListenable;

  void dispose();

  Future<void> getFilteredPlaces({required FilterPlacesEntity filter});

  Future<void> saveFilter({required FilterPlacesEntity filter});
}
