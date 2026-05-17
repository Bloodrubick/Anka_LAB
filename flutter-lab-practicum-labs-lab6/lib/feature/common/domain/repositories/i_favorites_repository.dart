import 'package:rxdart/rxdart.dart';
import 'package:surf_mad_teacher_training/feature/common/domain/entities/place_entity.dart';

/// Интерфейс для работы с Избранным.
abstract interface class IFavoritesRepository {
  /// [Stream] cо всем локальным набором избранных карточек.
  ValueStream<List<PlaceEntity>> get favoritesStream;

  void dispose();

  /// Переключение статуса избранного места.
  void toggleFavorite(PlaceEntity place);
}
