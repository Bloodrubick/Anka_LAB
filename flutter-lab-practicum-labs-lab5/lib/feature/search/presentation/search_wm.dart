import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:surf_mad_teacher_training/feature/common/domain/entities/place_entity.dart';
import 'package:surf_mad_teacher_training/feature/search/domain/entities/search_keyword_entity.dart';
import 'package:surf_mad_teacher_training/feature/search/domain/entities/search_screen_state.dart';
import 'package:surf_mad_teacher_training/feature/search/presentation/search_model.dart';
import 'package:surf_mad_teacher_training/navigation/router.dart';

const _debounceTime = Duration(milliseconds: 500);

abstract interface class ISearchWM {
  TextEditingController get keywordsController;

  FocusNode get keywordsFocusNode;

  ValueListenable<SearchScreenState> get screenStateListenable;

  ValueListenable<List<SearchKeywordEntity>> get historyStateListenable;

  void onPlacePressed(PlaceEntity place);

  void onSearchFieldClearPressed();

  void onSearchKeywordPressed(SearchKeywordEntity keyword);

  void onSearchKeywordRemovePressed(SearchKeywordEntity keyword);

  void onHistoryClearPressed();

  void onRetryPressed();

  void dispose();
}

final class SearchWM implements ISearchWM {
  final ISearchModel _model;
  final BuildContext _context;
  final _keywordsController = TextEditingController();
  final _keywordsFocusNode = FocusNode();
  final _keywordsSubject = BehaviorSubject<String>.seeded('');
  late final StreamSubscription<String> _keywordsSubscription;
  late final _keywordsStream = _keywordsSubject.stream;

  SearchWM({required BuildContext context, required ISearchModel model}) : _context = context, _model = model {
    _init();
    _keywordsController.addListener(_keywordsControllerListener);
    _keywordsSubscription = _keywordsStream.debounceTime(_debounceTime).listen(_keywordsStreamListener);
  }

  @override
  ValueListenable<SearchScreenState> get screenStateListenable => _model.screenStateListenable;

  @override
  ValueListenable<List<SearchKeywordEntity>> get historyStateListenable => _model.historyStateListenable;

  @override
  TextEditingController get keywordsController => _keywordsController;

  @override
  FocusNode get keywordsFocusNode => _keywordsFocusNode;

  @override
  void dispose() {
    _keywordsController.dispose();
    _keywordsFocusNode.dispose();
    unawaited(_keywordsSubscription.cancel());
    unawaited(_keywordsSubject.close());
    _model.dispose();
  }

  @override
  void onSearchFieldClearPressed() {
    _keywordsController.clear();
  }

  @override
  void onPlacePressed(PlaceEntity place) {
    unawaited(
      _context.router.push(PlaceDetailRouteBuilder(place: place)),
    );
  }

  @override
  void onSearchKeywordPressed(SearchKeywordEntity keyword) {
    _keywordsController.text = keyword.keyword;
  }

  @override
  Future<void> onSearchKeywordRemovePressed(SearchKeywordEntity keyword) async {
    await _model.removeKeyword(keyword: keyword);
  }

  @override
  Future<void> onHistoryClearPressed() async {
    await _model.clearHistory();
  }

  @override
  void onRetryPressed() {
    unawaited(_model.getFilteredPlaces(keyword: _keywordsController.text));
  }

  void _init() {
    unawaited(_model.getHistory());
  }

  void _keywordsControllerListener() {
    final keywords = _keywordsController.text.trim();
    if (keywords.isEmpty) {
      unawaited(_model.getHistory());

      return;
    }

    _keywordsSubject.add(keywords);
  }

  void _keywordsStreamListener(String keywords) {
    final clearedKeywords = keywords.trim();
    if (clearedKeywords.isEmpty || clearedKeywords.length < 3) return;

    unawaited(_model.getFilteredPlaces(keyword: clearedKeywords));
  }
}
