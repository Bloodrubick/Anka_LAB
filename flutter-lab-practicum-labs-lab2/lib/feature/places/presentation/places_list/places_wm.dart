import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:surf_mad_teacher_training/feature/common/domain/entities/place_entity.dart';
import 'package:surf_mad_teacher_training/feature/filter/domain/entities/filter_places_entity.dart';
import 'package:surf_mad_teacher_training/feature/filter/presentation/filter_screen_builder.dart';
import 'package:surf_mad_teacher_training/feature/place_detail/presentation/place_detail_screen_builder.dart';
import 'package:surf_mad_teacher_training/feature/places/domain/entities/places_state.dart';
import 'package:surf_mad_teacher_training/feature/places/presentation/places_list/places_model.dart';

abstract interface class IPlacesWM {
  ValueListenable<PlacesState> get placesStateListenable;

  void dispose();

  void onFilterPressed();

  void onPlacePressed(PlaceEntity place);

  Future<void> onRefresh();

  void onRetryPressed();

  void onSearchPressed();
}

final class PlacesWM implements IPlacesWM {
  final IPlacesModel _model;
  final BuildContext _context;

  final _filterSubject = BehaviorSubject<FilterPlacesEntity>();
  late final StreamSubscription<FilterPlacesEntity> _filterSubscription;

  PlacesWM({required BuildContext context, required IPlacesModel model}) : _context = context, _model = model {
    unawaited(_initFilter());
    _filterSubscription = _filterStream.listen(_filterStreamListener);
  }

  @override
  ValueListenable<PlacesState> get placesStateListenable => _model.placesStateListenable;

  @override
  void dispose() {
    unawaited(_filterSubscription.cancel());
    unawaited(_filterSubject.close());
    _model.dispose();
  }

  @override
  Future<void> onFilterPressed() async {
    final filter = _filterSubject.valueOrNull ?? await _model.getSavedFilter();

    if (!_context.mounted) return;
    final newFilter = await Navigator.of(
      _context,
    ).push(MaterialPageRoute(builder: (context) => FilterScreenBuilder(initialFilter: filter)));

    if (newFilter is FilterPlacesEntity) {
      _filterSubject.add(newFilter);
    }
  }

  @override
  void onPlacePressed(PlaceEntity place) {
    unawaited(
      Navigator.of(_context).push(MaterialPageRoute(builder: (context) => PlaceDetailScreenBuilder(place: place))),
    );
  }

  @override
  Future<void> onRefresh() async {
    final lastFilter = _filterSubject.valueOrNull ?? await _model.getSavedFilter();
    unawaited(_model.getPlaces(filter: lastFilter));
  }

  @override
  void onRetryPressed() => unawaited(onRefresh());

  @override
  void onSearchPressed() {
    // TODO: Implement search pressed
  }

  ValueStream<FilterPlacesEntity> get _filterStream => _filterSubject.stream;

  void _filterStreamListener(FilterPlacesEntity filter) {
    unawaited(_model.getPlaces(filter: filter));
  }

  Future<void> _initFilter() async {
    final filter = await _model.getSavedFilter();
    _filterSubject.add(filter);
  }
}
