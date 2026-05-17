import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:surf_mad_teacher_training/feature/common/domain/entities/place_entity.dart';
import 'package:surf_mad_teacher_training/feature/common/domain/entities/place_type.dart';
import 'package:surf_mad_teacher_training/feature/common/presentation/widgets/favorites/entities/favorites_button_type.dart';
import 'package:surf_mad_teacher_training/feature/common/presentation/widgets/favorites/favorites_button_widget.dart';
import 'package:surf_mad_teacher_training/feature/common/presentation/widgets/favorites/favorites_button_wm.dart';
import 'package:surf_mad_teacher_training/feature/common/presentation/widgets/places/entities/place_card_type.dart';
import 'package:surf_mad_teacher_training/uikit/buttons/icon_action_button.dart';

import 'package:surf_mad_teacher_training/uikit/themes/app_theme_data.dart';

import 'favorites_button_widget_test.mocks.dart';

@GenerateMocks([IFavoritesButtonWM])
void main() {
  late MockIFavoritesButtonWM mockWm;

  final testPlace = PlaceEntity(
    id: 1,
    name: 'Test Place',
    description: 'Test desc',
    type: PlaceType.park,
    images: [],
    lat: 1,
    lon: 1,
  );

  setUp(() {
    mockWm = MockIFavoritesButtonWM();
  });

  Widget makeTestableWidget(Widget child) {
    return MaterialApp(
      home: Scaffold(
        body: child,
      ),
    );
  }

  group('FavoritesButtonWidget Tests', () {
    testWidgets('calls onFavoritePressed when tapped', (tester) async {
      // Arrange
      final isFavoriteState = ValueNotifier<bool>(false);
      when(mockWm.isFavoriteState).thenReturn(isFavoriteState);

      await tester.pumpWidget(
        MaterialApp(
          theme: AppThemeData.lightTheme,
          home: Scaffold(
            body: FavoritesButtonWidget(
              wm: mockWm,
              place: testPlace,
              buttonType: FavoritesButtonType.small,
              cardType: PlaceCardType.place,
            ),
          ),
        ),
      );

      // Act
      final buttonFinder = find.byType(IconActionButton);
      await tester.tap(buttonFinder.first);
      await tester.pump();

      // Assert
      verify(mockWm.onFavoritePressed(testPlace)).called(1);
    });
  });
}
