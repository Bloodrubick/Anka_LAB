import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:surf_mad_teacher_training/feature/common/presentation/widgets/places/skeleton_place_card_widget.dart';
import 'package:surf_mad_teacher_training/uikit/themes/app_theme_data.dart';

void main() {
  // Создаем обертку для виджетов
  Widget makeTestableWidget(Widget child) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[100],
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: child,
        ),
      ),
      theme: AppThemeData.lightTheme,
    );
  }

  group('SkeletonPlaceCardWidget Golden Tests', () {
    testWidgets('корректное отображение шиммера карточки места', (tester) async {
      // Создаем виджет
      await tester.pumpWidget(
        makeTestableWidget(
          const SizedBox(
            width: 300,
            child: SkeletonPlaceCardWidget(),
          ),
        ),
      );

      // Отрисовываем виджет
      await tester.pumpAndSettle();
      // Проверяем, что виджет отображается корректно:
      // - у него совпадает тип
      // - он совпадает с golden файлом
      await expectLater(
        find.byType(SkeletonPlaceCardWidget),
        matchesGoldenFile('goldens/skeleton_place_card_widget.png'),
      );
    });
  });
}
