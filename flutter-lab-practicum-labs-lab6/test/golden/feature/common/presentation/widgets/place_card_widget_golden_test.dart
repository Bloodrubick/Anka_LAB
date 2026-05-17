import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:surf_mad_teacher_training/feature/app/di/app_scope.dart';
import 'package:surf_mad_teacher_training/feature/common/domain/entities/place_entity.dart';
import 'package:surf_mad_teacher_training/feature/common/domain/entities/place_type.dart';
import 'package:surf_mad_teacher_training/feature/common/domain/repositories/i_favorites_repository.dart';
import 'package:surf_mad_teacher_training/feature/common/presentation/widgets/places/place_card_widget.dart';
import 'package:surf_mad_teacher_training/uikit/themes/app_theme_data.dart';

import 'place_card_widget_golden_test.mocks.dart';

@GenerateMocks([IAppScope, IFavoritesRepository])
void main() {
  late MockIAppScope mockAppScope;
  late MockIFavoritesRepository mockFavoritesRepository;

  final testPlace = PlaceEntity(
    id: 1,
    name: 'Long Golden Test Place Name',
    description: 'This is a very long description for the golden test to make sure that the text is wrapped correctly and the layout does not break when there is a lot of text inside the description field.',
    type: PlaceType.museum,
    images: [], // Can't load real image in golden test without HTTP override or using a dummy, so we just use empty list which will show placeholder or nothing
    lat: 1.0,
    lon: 1.0,
  );

  setUp(() {
    mockAppScope = MockIAppScope();
    mockFavoritesRepository = MockIFavoritesRepository();

    when(mockAppScope.favoritesRepository).thenReturn(mockFavoritesRepository);
    when(mockFavoritesRepository.favoritesStream).thenAnswer((_) => BehaviorSubject<List<PlaceEntity>>.seeded([]));
  });

  Widget makeTestableWidget(Widget child) {
    return Provider<IAppScope>(
      create: (_) => mockAppScope,
      child: MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.grey[100],
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: child,
          ),
        ),
        theme: AppThemeData.lightTheme,
      ),
    );
  }

  group('PlaceCardWidget Golden Tests', () {
    testWidgets('корректное отображение карточки места', (tester) async {
      await tester.pumpWidget(
        makeTestableWidget(
          SizedBox(
            width: 300,
            child: PlaceCardWidget(
              place: testPlace,
              onPressed: (_) {},
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      await expectLater(
        find.byType(PlaceCardWidget),
        matchesGoldenFile('goldens/place_card_widget.png'),
      );
    });
  });
}
