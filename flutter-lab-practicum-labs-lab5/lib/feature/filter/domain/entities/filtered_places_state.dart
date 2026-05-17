import 'package:flutter/foundation.dart';
import 'package:surf_mad_teacher_training/core/domain/entities/failure/failure.dart';

@immutable
sealed class FilteredPlacesState {
  const FilteredPlacesState();
}

final class FilteredPlacesStateLoading extends FilteredPlacesState {
  const FilteredPlacesStateLoading();
}

final class FilteredPlacesStateFailure extends FilteredPlacesState {
  final Failure failure;

  const FilteredPlacesStateFailure(this.failure);

  @override
  int get hashCode => failure.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FilteredPlacesStateFailure && runtimeType == other.runtimeType && failure == other.failure;
}

final class FilteredPlacesStateData extends FilteredPlacesState {
  final int foundQuantity;

  const FilteredPlacesStateData(this.foundQuantity);

  @override
  int get hashCode => foundQuantity.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FilteredPlacesStateData && runtimeType == other.runtimeType && foundQuantity == other.foundQuantity;
}
