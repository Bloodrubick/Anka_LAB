import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:surf_mad_teacher_training/core/domain/entities/result/result.dart';
import 'package:surf_mad_teacher_training/feature/filter/domain/entities/filter_places_entity.dart';
import 'package:surf_mad_teacher_training/feature/search/domain/entities/search_keyword_entity.dart';
import 'package:surf_mad_teacher_training/feature/search/domain/entities/search_screen_state.dart';
import 'package:surf_mad_teacher_training/feature/search/domain/repositories/i_search_repository.dart';

/// {@template search_model.class}
/// Модель для SearchScreen.
/// {@endtemplate}
final class SearchModel implements ISearchModel {
  final ISearchRepository _searchRepository;
  final FilterPlacesEntity _initialFilter;
  final _screenState = ValueNotifier<SearchScreenState>(HistoryStateData([]));
  late final StreamSubscription<List<SearchKeywordEntity>> _historySearchSubscription;
  final _historyState = ValueNotifier<List<SearchKeywordEntity>>([]);

  /// {@macro search_model.class}
  SearchModel({required ISearchRepository searchRepository, required FilterPlacesEntity initialFilter})
    : _searchRepository = searchRepository,
      _initialFilter = initialFilter {
    _init();
  }

  @override
  ValueListenable<SearchScreenState> get screenStateListenable => _screenState;

  @override
  ValueListenable<List<SearchKeywordEntity>> get historyStateListenable => _historyState;

  @override
  void dispose() {
    _screenState.dispose();
    _historyState.dispose();
    unawaited(_historySearchSubscription.cancel());
  }

  @override
  Future<void> getFilteredPlaces({required String keyword}) async {
    final filter = _initialFilter.copyWith(name: keyword);

    _screenState.value = SearchStateLoading();
    final result = await _searchRepository.getFilteredPlaces(filter: filter);

    switch (result) {
      case ResultOk(:final data):
        _screenState.value = SearchStateData(data);
        unawaited(_searchRepository.saveKeyword(keyword: keyword));
      case ResultFailed(:final error):
        _screenState.value = SearchStateFailure(error);
    }
  }

  @override
  Future<void> getHistory() async {
    _setHistoryState();
  }

  @override
  Future<void> clearHistory() async {
    await _searchRepository.clearHistory();
    _setHistoryState();
  }

  @override
  Future<void> removeKeyword({required SearchKeywordEntity keyword}) async {
    await _searchRepository.removeKeyword(keyword: keyword);
    _setHistoryState();
  }

  void _init() {
    _historySearchSubscription = _searchRepository.historySearchStream.listen((historyList) {
      _historyState.value = List.from(historyList);
    });
  }

  void _setHistoryState() {
    _screenState.value = HistoryStateData(List.from(_historyState.value));
  }
}

abstract interface class ISearchModel {
  ValueListenable<SearchScreenState> get screenStateListenable;

  ValueListenable<List<SearchKeywordEntity>> get historyStateListenable;

  void dispose();

  Future<void> getFilteredPlaces({required String keyword});

  Future<void> removeKeyword({required SearchKeywordEntity keyword});

  Future<void> getHistory();

  Future<void> clearHistory();
}
