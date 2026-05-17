# 🧪 ЛР6: Тестирование Flutter приложений

## 🔍 Введение в тестирование

В предыдущих лабораторных работах мы создали полноценное приложение для поиска интересных мест с сетевым взаимодействием и локальным хранилищем.

---

### ⚠️ Текущая проблема

Сейчас наше приложение имеет богатую функциональность, но **не имеет автоматизированных тестов**. Это означает:

> **🚨 Проблемы отсутствия тестов:**
> - 🐛 Вероятность возникновения сложных и неочевидных багов
> - 🔄 Необходимость в регрессии при добавлении новых функций
> - 🚧 Есть риск что-то сломать во время рефакторинга
> - ⏰ Уходит много времени на отладку
> - 🔍 Сложноcть в проверке крайних случаев (corner case)

## 🎯 Что мы будем реализовывать

Теперь пришло время покрыть наше приложение тестами

---

> 💡 **Важно помнить:** Тестирование - это **инвестиция в качество** приложения. Хорошо протестированный код проще поддерживать, рефакторить и масштабировать.

---

Современные мобильные приложения должны иметь высокое качество, что невозможно без систематического тестирования на всех уровнях архитектуры.

# Мокирование

Прежде чем писать тесты, мы должны изолировать зависимости. Для этого мы будем использовать **моки** - фиктивные объекты, которые будут заменять реальные зависимости.

**Mockito** - популярная библиотека для создания моков в Dart/Flutter тестах (https://pub.dev/packages/mockito).

Для того чтобы создать моки, мы должны использовать аннотацию `@GenerateMocks`, в которую передаем список классов, которые мы хотим подменить.

```dart
@GenerateMocks([
  ApiClient,
])
```

Затем нужно вызвать кодогенерацию

```bash
flutter pub run build_runner build
```

Это создаст файл `*_test.mocks.dart` с готовыми моками.


# 🔬 Unit тесты - тестирование бизнес-логики

Unit тесты проверяют **отдельные сущности** (функции, методы, классы) в изоляции от остальной системы.


## 📋 Что тестировать в Unit тестах?

- Корректность бизнес-логики (модели)
- Обработку данных и ошибок (репозитории)
- Трансформацию данных (конвертеры)
- Утилиты и вспомогательные функции

---

## 🎯 Структура Unit теста

Каждый unit тест следует паттерну **AAA (Arrange-Act-Assert)**:

1. **📝 Arrange (Подготовка)**
   - Создаём моки зависимостей
   - Инициализируем тестируемый объект
   - Подготавливаем тестовые данные

2. **🎬 Act (Действие)**
   - Вызываем тестируемый метод
   - Выполняем действие

3. **✅ Assert (Проверка)**
   - Проверяем результат
   - Сравниваем с ожидаемым поведением

Общая структура теста выглядит так.

```dart

// Генерация моков для тестов
@GenerateMocks([
  ApiClient,
])
void main() {
   setUp(() {
      // Подготовка
   });

   group(
      'Название группы тестов',
      () {
      test(
        'Название теста',
        () {
          // Действие

          // Проверка
        },
      );
      }
   )
}
```

---

## 💡 Пример: Тестирование PlacesRepository

Создадим тесты для PlacesRepository:

**TODO: пример кода**
```dart
// ... импортируем зависимости

// Генерация моков для API клиента
@GenerateMocks([
  ApiClient,
  FilterStorage,
])
void main() {
  late PlacesRepository placesRepository;
  late MockApiClient mockApiClient;
  late FilterStorage filterStorage;
  late FilterPlacesConverter filterPlacesConverter;
  late PlaceResponseConverter placeResponseConverter;

  setUp(() {
    // Создаем моки и объекты зависимостей
    mockApiClient = MockApiClient();
    filterStorage = MockFilterStorage();
    filterPlacesConverter = FilterPlacesConverter();
    placeResponseConverter = PlaceResponseConverter();
    // Инициализируем тестируемый объект
    placesRepository = PlacesRepository(
      apiClient: mockApiClient,
      filterStorage: filterStorage,
      filterPlacesConverter: filterPlacesConverter,
      placeResponseConverter: placeResponseConverter,
    );
  });

  // Создаем группу тестов для тестирования PlacesRepository
  group(
    'группа тестов для PlacesRepository',
        () {
      final filter = FilterPlacesEntity();
      const placeResponse = PlaceDto(
        id: 1,
        name: 'Test name',
        description: 'Test description',
        placeType: PlaceTypeDto.other,
        images: [],
        lat: 1,
        lon: 1,
      );

      // Создаем тест для проверки успешного вызова API
      test(
        'getPlaces возвращает успех при успешном вызове API',
            () async {
          // Мокируем вызов API
          when(mockApiClient.getFilteredPlaces(filter: anyNamed('filter'))).thenAnswer((_) async => [placeResponse]);


          // Выполняем вызов getPlaces
          final result = await placesRepository.getPlaces(filter: filter);

          // Проверяем результат
          expect(result, isA<ResultOk<List<PlaceEntity>, Object>>());
          expect((result as ResultOk<List<PlaceEntity>, Object>).data, hasLength(1));
          verify(mockApiClient.getFilteredPlaces(filter: anyNamed('filter'))).called(1);
        },
      );

      // Создаем тест для проверки ошибки при вызове API
      test(
        'getPlaces возвращает ошибку при вызове API',
            () async {
          // Создаем ошибку
          final dioException = DioException(
            requestOptions: RequestOptions(),
            response: Response(
              requestOptions: RequestOptions(),
              statusCode: 404,
            ),
          );
          // Мокируем вызов API с ошибкой в ответе
          when(mockApiClient.getFilteredPlaces(filter: anyNamed('filter'))).thenThrow(dioException);

          // Выполняем вызов getPlaces
          final result = await placesRepository.getPlaces(filter: filter);

          // Проверяем результат
          expect(result, isA<ResultFailed<List<PlaceEntity>, Object>>());
          verify(mockApiClient.getFilteredPlaces(filter: anyNamed('filter'))).called(1);
        },
      );
    },
  );
}
```

## Запуск теста

Для запуска тестов через терминал необходимо использовать команду flutter test 

**Запуск всех тестов**

```bash
flutter test
```

**Запуск конкретного теста**
```bash
flutter test test/feature/places/data/repositories/places_repository_test.dart
```

> 💡 **Совет:** Для того, чтобы узнать больше о командах тестирования используйте команду `flutter test --help`

# 🎨 Widget тесты - тестирование UI компонентов

Widget тесты проверяют **отдельные виджеты** и то, как происходит взаимодействие пользователя с ними.

## 📋 Что тестировать в Widget тестах?

- Отображение виджета
- Текст и форматирование
- Состояния и анимации
- Взаимодействие с пользователем

## 🎯 Структура Widget теста

Каждый widget тест следует уже знакомому нам паттерну **AAA (Arrange-Act-Assert)**


Только теперь воспользуемся методом `testWidgets` вместо `test`. Он предоставляет доступ к `WidgetTester`, который позволяет нам выполнять желаемые действия с виджетами.

### Основные методы WidgetTester:

```dart
// Создание виджета и первый рендер
await tester.pumpWidget(myWidget);

// Одна итерация перерисовки (один фрейм)
await tester.pump();

// Нажатие
await tester.tap(find.byType(ElevatedButton));

// Свайп
await tester.drag(find.byType(ListView), Offset(0, -300));

// и еще множество других методов (https://api.flutter.dev/flutter/flutter_test/WidgetTester-class.html)...

```

## 💡 Пример: Тестирование PlaceCardWidget

Создадим тесты для PlaceCardWidget:

```dart
// ... импортируем зависимости

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

  // Создаем обертку для виджетов
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
    // Создаем виджет
    await tester.pumpWidget(
      makeTestableWidget(
        PlaceCardWidget(
          place: testPlace,
          onPressed: (_) {},
        ),
      ),
    );

    // Проверяем, что отображается название места
    expect(find.text(testPlace.name), findsOneWidget);
    // Проверяем, что отображается описание места
    expect(find.text(testPlace.description), findsOneWidget);
  });

  testWidgets('PlaceCardWidget вызывает callback при нажатии', (tester) async {
    var pressed = false;
    // Создаем виджет
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

    // Ищем виджет InkWell
    final inkWellWidgetFinder = find.byType(InkWell);
    // Нажимаем на него
    await tester.tap(inkWellWidgetFinder.first);
    // Перерисовка
    await tester.pump();

    // Проверяем, что состояние было изменено
    expect(pressed, isTrue);
  });
}
```

# 🏆 Golden тесты

Для тестирования верстки компонентов пользовательского интерфейса используются **голден тесты** (Golden test).

Голден тест - это сравнение виджета с "золотым стандартом" в виде **golden файла** (golden file). Отклонения от него указывают на проблемы в верстке.

Все необходимое для работы с голден тестами уже содержится в пакете `flutter_test`.

Golden тесты очень похожи на **Widget тесты**.

Отличие заключается в том, что golden тест в блоке проверки вызывает функцию `expectLater` (вместо `expect`).

Эта функция проверяет, что виджет совпадает по типу, а также использует функцию `matchesGoldenFile` для сравнения с golden файлом.

## 💡 Пример. Тестирование SkeletonPlaceCardWidget

```dart
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

```

## Генерация golden файла

Для того чтобы сгенерировать golden файл, необходимо выполнить команду 
```bash
flutter test test/golden/common/presentation/widgets/places/skeleton_place_card_widget_golden_test.dart --update-goldens
```
 В случае, если все настроено правильно, то тест пройдет успешно и golden файл будет сгенерирован в директории `goldens`.

Если открыть этот файл, то можно увидеть схематичное изображение виджета, с учетом всех размеров и отступов.

> 💡 Необходимо каждый раз, когда намерено изменилась верстка виджета, перегенерировать golden файл.

## Запуск golden теста

Для запуска golden теста необходимо выполнить команду `flutter test`, но уже без дополнительного флага `--update-goldens`.
```bash
flutter test test/golden/common/presentation/widgets/places/skeleton_place_card_widget_golden_test.dart
```

В случае, если верстка не изменилась, то тест пройдет успешно.

Теперь попробуем изменить верстку виджета и запустить тест снова. 

Можно заметить, что тест упал. К тому же, была создана директория `failures` и в ней лежат несколько файлов, которые указывают на отклонения от эталона.

# 🧪 Integration тесты - тестирование приложения целиком

Integration тесты способны тестировать **приложение целиком**, включая взаимодействие всех компонентов.

## 📋 Что тестировать в Integration тестах?

- Полный путь пользователя в приложении
- Отдельные сценарии пользователя и фичи приложения
- Производительность приложения


## 🎯 Структура Integration теста

Структура integration теста выглядит так же как и в unit и widget тестах. Только в интеграционных тестах область тестирования больше и не ограничивается одним UI-компонентом или классом.

## 💡 Пример: Тестирование экрана онбординга

```dart
// ... импортируем зависимости

void main() {
  group('OnboardingScreen integration test', () {


    testWidgets('проверка свайпа экранов онбординга', (tester) async {
      // Создаем экземпляр приложения в котором открыт экран онбординга
      await tester.pumpWidget(
        MaterialApp(home: OnboardingScreenBuilder(), theme: AppThemeData.lightTheme),
      );

      // Ждем отрисовки экрана
      await tester.pumpAndSettle();

      // Проверяем, что виден первый экран онбординга
      expect(find.byType(OnboardingScreenBuilder), findsOneWidget);
      expect(find.text(AppStrings.onboardingPage1Title), findsOneWidget);

      // Свайпаем на второй экран
      await tester.drag(find.byType(PageView), const Offset(-400, 0));
      await tester.pumpAndSettle();

      // Проверяем, что виден второй экран онбординга
      expect(find.text(AppStrings.onboardingPage2Title), findsOneWidget);

      // Свайпаем на третий экран
      await tester.drag(find.byType(PageView), const Offset(-400, 0));
      await tester.pumpAndSettle();

      // Проверяем, что виден третий экран онбординга
      expect(find.text(AppStrings.onboardingPage3Title), findsOneWidget);
    });
  });
}
```

# 🛠️ Хорошие практики тестирования

## ✅ DO - Делайте так

### 1. **Следуйте принципу AAA**
```dart
test('description', () {
  // ✅ Arrange
  final model = createModel();
  
  // ✅ Act
  final result = model.doSomething();
  
  // ✅ Assert
  expect(result, expectedValue);
});
```

### 2. **Тестируйте поведение, а не реализацию**
```dart
// ✅ Хорошо - тестируем что должно происходить
test('добавление места в избранное', () {
  model.addToFavorites(place);
  expect(model.favoritesCount, equals(1));
});

// ❌ Плохо - тестируем внутреннюю реализацию
test('вызов метода _internalMethod', () {
  model.addToFavorites(place);
  verify(model._internalMethod()).called(1); // Хрупкий тест
});
```

### 3. **Давайте понятные имена тестам**
```dart
// ✅ Хорошо - описывает что и при каких условиях
test('Возврат пустого списка когда репозиторий не имеет избранных мест', () {
  // ...
});

// ❌ Плохо - непонятно что тестируется
test('test1', () {
  // ...
});
```

### 4. **Один тест - одна проверка**
```dart
// ✅ Хорошо
test('Добавление места в избранное', () {
  model.addToFavorites(place);
  expect(model.favoritesCount, equals(1));
});

test('Уведомление слушателей когда место добавлено', () {
  model.addToFavorites(place);
  verify(mockListener()).called(1);
});

// ❌ Плохо - проверяем слишком много
test('Добавление места и уведомление и сохранение в базу данных', () {
  model.addToFavorites(place);
  expect(model.favoritesCount, equals(1));
  verify(mockListener()).called(1);
  verify(mockDatabase.save()).called(1);
  // Если упадет - непонятно что именно сломалось
});
```

### 5. **Используйте setUp() и tearDown()**
```dart
// ✅ Хорошо - переиспользуем подготовку
group('FavoritesModel', () {
  late FavoritesModel model;
  late MockRepository mockRepo;

  setUp(() {
    mockRepo = MockRepository();
    model = FavoritesModel(repository: mockRepo);
  });

  tearDown(() {
    model.dispose();
  });

  test('test 1', () { /* ... */ });
  test('test 2', () { /* ... */ });
});
```

---

## ❌ DON'T - Не делайте так

### 1. **Не тестируйте приватные методы напрямую**

> 💡 **Совет:** В крайнем случае метод можно сделать публичным и пометить аннотацией `@visibleForTesting`. 

```dart
// ❌ Плохо
test('форматирование внутренней даты', () {
  final result = model._formatDate(date); // Приватный метод
  expect(result, '2024-01-01');
});

// ✅ Хорошо - тестируем через публичный API
test('возврат форматированной даты в строку', () {
  final result = model.getDisplayString(date);
  expect(result, contains('2024-01-01'));
});
```

### 2. **Не делайте тесты зависимыми друг от друга**
```dart
// ❌ Плохо - тесты зависят от порядка выполнения
test('добавление места', () {
  model.addPlace(place);
});

test('имеет 1 место', () {
  expect(model.places.length, 1); // Зависит от предыдущего теста
});

// ✅ Хорошо - каждый тест независим
test('добавление места и текущее количество 1', () {
  model.addPlace(place);
  expect(model.places.length, 1);
});
```

### 3. **Не игнорируйте асинхронность**
```dart
// ❌ Плохо - не ждем асинхронную операцию
test('загрузка мест', () {
  model.loadPlaces(); // Future не awaited
  expect(model.places, isNotEmpty); // Проверяем до завершения
});

// ✅ Хорошо
test('загрузка мест', () async {
  await model.loadPlaces();
  expect(model.places, isNotEmpty);
});
```

### 4. **Не используйте реальные задержки**
```dart
// ❌ Плохо - тест займет 5 секунд
test('показ лоадера на 5 секунд', () async {
  model.startLoading();
  await Future.delayed(Duration(seconds: 5));
  expect(model.isLoading, false);
});

// ✅ Хорошо - используем фейковый таймер или моки
test('скрытие лоадера после таймаута', () async {
  fakeAsync((async) {
    model.startLoading();
    async.elapse(Duration(seconds: 5));
    expect(model.isLoading, false);
  });
});
```

# 🎯 Задания для самостоятельной работы

## 🟢 Задание на оценку "3" *(базовый уровень)*

**🎯 Цель:** Покрыть приложение Unit тестами

### 📋 Задачи для реализации:

- Повторить то, что было в рамках методички.

- Написать Unit тесты для следующих сущностей:
  - Конвертеры данных: FavoritePlaceFromDbConverter, FavoritePlaceToDbConverter
  - Расширение: OnboardingStepExtension
  - Репозиторий: SearchRepository
  - Модель: SettingsModel

- Убедитесь в успешном прохождении тестов.

---

## 🟡 Задание на оценку "4" *(продвинутый уровень)*

**🎯 Цель:** Покрыть приложение Widget и Golden тестами

**🎯 Дополнительно к предыдущим требованиям:**

### 📋 Задачи для реализации:

- Напишите виджет тест для кнопки добавления в избранное. Необходимо убедиться в корректной обработке нажатия на кнопку.

- Напишите виджет тест для BottomNavScreen. Необходимо убедиться в наличии всех необходимых элементов навигации.

- Напишите голден тест для карточки места PlaceCardWidget.

- Убедитесь в успешном прохождении тестов

---

## 🔴 Задание на оценку "5" *(экспертный уровень)*

**🎯 Цель:** Покрыть приложение интеграционными тестами

**🎯 Дополнительно к предыдущим требованиям:**

### 📋 Основные задачи:

- Напишите интеграционный тест для следующего сценария использования:
  1) находимся на экране списка мест
  2) нажали на карточку места
  3) отобразился экран деталей места
  4) нажали на кнопку добавления в избранное
  5) кнопка изменила свое состояние

- Убедитесь в успешном прохождении теста

### 🔗 Полезные ссылки:
- [Testing Flutter apps](https://docs.flutter.dev/testing)
- [An introduction to unit testing](https://docs.flutter.dev/cookbook/testing/unit/introduction)
- [An introduction to widget testing](https://docs.flutter.dev/cookbook/testing/widget/introduction)
- [An introduction to integration testing](https://docs.flutter.dev/cookbook/testing/integration/introduction)
