import 'package:flutter/foundation.dart';
import 'package:surf_mad_teacher_training/core/domain/entities/failure/failure.dart';
import 'package:surf_mad_teacher_training/feature/common/domain/entities/place_entity.dart';
import 'package:surf_mad_teacher_training/feature/search/domain/entities/search_keyword_entity.dart';

@immutable
sealed class SearchScreenState {
  const SearchScreenState();
}

final class SearchStateLoading extends SearchScreenState {
  const SearchStateLoading();
}

final class SearchStateFailure extends SearchScreenState {
  final Failure failure;

  const SearchStateFailure(this.failure);

  @override
  int get hashCode => failure.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SearchStateFailure && runtimeType == other.runtimeType && failure == other.failure;
}

final class SearchStateData extends SearchScreenState {
  final List<PlaceEntity> placesList;

  const SearchStateData(this.placesList);

  @override
  int get hashCode => placesList.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SearchStateData && runtimeType == other.runtimeType && placesList == other.placesList;
}

final class HistoryStateData extends SearchScreenState {
  final List<SearchKeywordEntity> historyList;

  const HistoryStateData(this.historyList);

  @override
  int get hashCode => historyList.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HistoryStateData && runtimeType == other.runtimeType && historyList == other.historyList;
}
