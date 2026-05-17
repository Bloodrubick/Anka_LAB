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

import 'place_card_widget_test.mocks.dart';

@GenerateMocks([IAppScope, IFavoritesRepository])
void main() {
  late IAppScope appScopeMock;
  late IFavoritesRepository favoritesRepositoryMock;

  final testPlace = PlaceEntity(
    id: 1,
    name: 'Test Place Name',
    description: 'Test place description.',
    type: PlaceType.park,
    images: [''],
    lat: 1,
    lon: 1,
  );

  setUp(() {
    appScopeMock = MockIAppScope();
    favoritesRepositoryMock = MockIFavoritesRepository();

    when(appScopeMock.favoritesRepository).thenReturn(favoritesRepositoryMock);
    when(favoritesRepositoryMock.favoritesStream).thenAnswer((_) => BehaviorSubject<List<PlaceEntity>>.seeded([]));
  });

  Widget makeTestableWidget(Widget child) {
    return Provider<IAppScope>(
      create: (_) => appScopeMock,
      child: MaterialApp(
        home: Scaffold(
          body: child,
        ),
        theme: AppThemeData.lightTheme,
      ),
    );
  }

  testWidgets('PlaceCardWidget отображает данные места', (tester) async {
    await tester.pumpWidget(
      makeTestableWidget(
        PlaceCardWidget(
          place: testPlace,
          onPressed: (_) {},
        ),
      ),
    );

    expect(find.text(testPlace.name), findsOneWidget);
    expect(find.text(testPlace.description), findsOneWidget);
  });

  testWidgets('PlaceCardWidget вызывает callback при нажатии', (tester) async {
    var pressed = false;
    await tester.pumpWidget(
      makeTestableWidget(
        PlaceCardWidget(
          place: testPlace,
          onPressed: (_) {
            pressed = true;
          },
        ),
      ),
    );

    final inkWellWidgetFinder = find.byType(InkWell);
    await tester.tap(inkWellWidgetFinder.first);
    await tester.pump();

    expect(pressed, isTrue);
  });
}
