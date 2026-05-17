# 🌐 ЛР4: Работа с сетью

## 🔄 Эволюция данных в нашем приложении

В предыдущих лабораторных работах мы создали полноценное приложение для поиска интересных мест с красивой навигацией. 

---

### ⚠️ Текущая проблема

Сейчас наше приложение использует **статические данные** из локальных файлов (`assets/json/places.json`). Это означает:

> **🚨 Проблемы текущего подхода:**
> - 📁 Данные захардкожены в приложении - нет актуальной информации
> - 🔄 Невозможно обновлять контент без новой версии приложения  
> - 🌍 Отсутствует синхронизация между устройствами
> - 📊 Нет возможности собирать аналитику и метрики
> - 🏷️ Ограниченная функциональность по работе с данными

## 🎯 Что мы будем реализовывать

Теперь пришло время превратить наше приложение в **полноценный клиент** для работы с серверным API:

### 📋 Этапы реализации:
| Этап | Компонент | Описание |
|------|-----------|----------|
| 1️⃣ | **HTTP-клиент** | Настройка Dio для выполнения сетевых запросов |
| 2️⃣ | **API интерфейс** | Декларативное описание эндпоинтов с Retrofit |
| 3️⃣ | **DTO модели** | Сериализация/десериализация JSON-данных |
| 4️⃣ | **Repository паттерн** | Абстракция работы с данными и обработка ошибок |
| 5️⃣ | **Интеграция в UI** | Состояния загрузки, ошибки и актуальные данные |

---

> 💡 **Важно помнить:** Работа с сетью - это один из **критически важных навыков** в современной мобильной разработке. От качества реализации зависит стабильность приложения и пользовательский опыт.

📖 **Дополнительные ресурсы:**
- [HTTP клиенты во Flutter](https://docs.flutter.dev/networking/http)
- [Официальная документация Dio](https://pub.dev/packages/dio)

---

Современные мобильные приложения активно используют сетевое взаимодействие для получения актуальных данных, синхронизации информации и взаимодействия с серверными сервисами.

# 🗺️ Архитектура работы с сетью во Flutter

Рассмотрим как правильно организовать сетевое взаимодействие в Flutter приложении.

## 🏗️ Многослойная архитектура

В нашем приложении используется чистая архитектура с разделением ответственности:

```
UI Layer (Widgets/Pages)
     ↓
Business Logic Layer (Models)  
     ↓
Repository Layer (PlacesRepository)
     ↓
Data Layer (ApiClient → HTTP Client → Server)
```

### 🎯 Ответственность каждого слоя:

| Слой | Ответственность | Примеры компонентов |
|------|-------------|---------------------|
| **🎨 UI Layer** | Отображение состояний и взаимодействие | Widgets, Pages, Screens |
| **🧠 Business Logic** | Управление состоянием и координация | Models |
| **📦 Repository** | Абстракция источников данных | Repository, Mappers, Converters |  
| **🌐 Data Layer** | Фактические HTTP-запросы | ApiClient, DTO, NetworkClient |

---

## 🔧 HTTP-клиенты во Flutter

Во Flutter есть несколько вариантов для работы с HTTP:

| Решение | Разработчик | Особенности | Рекомендуется для |
|---------|-------------|-------------|-----------------|
| **[http](https://pub.dev/packages/http)** | 🔵 Dart Team | • Встроенный в Flutter<br>• Простой API<br>• Базовая функциональность | 🚀 Простые запросы |  
| **[dio](https://pub.dev/packages/dio)** | Сообщество | • Interceptors<br>• Детальная обработка ошибок<br>• Кэширование<br>• Retry механизмы | 🏢 Продакшн приложения |
| **[chopper](https://pub.dev/packages/chopper)** | Сообщество | • Retrofit-стиль<br>• Кодогенерация<br>• Сложная настройка | 🔧 Специфические задачи |

### 🎯 Почему именно Dio?

В нашем проекте используется **Dio** по следующим причинам:

<details>
<summary>✅ <strong>Плюсы Dio</strong></summary>

- 🔧 **Мощная конфигурация** таймаутов и заголовков
- 📝 **Interceptors** для логирования и обработки запросов/ответов
- 🚨 **Детальная обработка ошибок** с классификацией проблем
- 🔄 **Retry механизмы** для повторных попыток 
- 🗄️ **Встроенная поддержка кэширования**
- 🌐 **Работа с прокси** и сертификатами

</details>

<details>
<summary>❌ <strong>Потенциальные минусы</strong></summary>

- 📦 **Больший размер** по сравнению с http пакетом
- 📈 **Кривая обучения** для сложных сценариев
- ⚙️ **Требует настройки** для полного использования возможностей

</details>

---

# 🔍 Анализ текущего состояния проекта

Давайте посмотрим, как сейчас организована работа с данными в нашем приложении:

### 📁 ApiClientFromAssets - текущий источник данных

Сейчас приложение использует `ApiClientFromAssets` для загрузки данных из локальных файлов:

```dart
final class ApiClientFromAssets implements ApiClient {
  const ApiClientFromAssets();

  @override
  Future<List<PlaceDto>> getPlaces() async {
    final jsonString = await rootBundle.loadString('assets/json/places.json');
    final List<dynamic> jsonData = json.decode(jsonString);
    return jsonData.map((json) => PlaceDto.fromJson(json)).toList();
  }

  @override
  Future<List<PlaceDto>> getFilteredPlaces({required FilterPlacesRequestDto filter}) async {
    final allPlaces = await getPlaces();
    // Фильтрация происходит локально
    return _filterPlaces(allPlaces, filter);
  }
}
```

> **🚨 Проблемы такого подхода:**
> - 📊 Данные не актуализируются - информация может устареть
> - 🌐 Нет взаимодействия с реальным сервером
> - 📈 Невозможна аналитика использования
> - 🔄 Ограниченная функциональность для работы с данными

### 🏗️ PlacesRepository - готовая архитектура

В проекте уже настроена правильная архитектура с Repository паттерном:

```dart
final class PlacesRepository extends BaseRepository implements IPlacesRepository {
  final ApiClient _apiClient; // Абстракция источника данных  
  final IPlaceResponseConverter _placeResponseConverter; // Конвертация DTO -> Entity

  @override
  RequestOperation<List<PlaceEntity>> getPlaces() => 
    makeApiCall(() async {
      final data = await _apiClient.getPlaces();
      return _placeResponseConverter.convertMultiple(data).toList();
    });
}
```

**Что мы видим:**
- ✅ Архитектура готова для любого источника данных
- 🔄 Используется абстракция `ApiClient` - легко заменить реализацию
- 🛡️ Базовая обработка ошибок через `BaseRepository.makeApiCall()`
- 🗄️ Конвертация между слоями архитектуры

### 🎯 Путь к улучшению

Наша задача - заменить `ApiClientFromAssets` на `ApiClientRemote` для работы с реальным API:

1. ⚙️ Настроить Dio HTTP-клиент
2. 📡 Создать Retrofit API интерфейс  
3. 🔄 Подключить новый клиент к существующей архитектуре
4. 🎨 Добавить состояния загрузки в UI

---

# 🛠️ Техническая реализация сетевого слоя

## 🎛️ Конфигурация HTTP-клиента

Создание HTTP-клиента вынесено в отдельный класс `AppDioConfigurator`:

```dart
class AppDioConfigurator {
  const AppDioConfigurator();

  Dio create({
    required Iterable<Interceptor> interceptors,
    required String url,
    String? proxyUrl,
  }) {
    const timeout = Duration(seconds: 30);

    final dio = Dio();

    // Базовая конфигурация
    dio.options
      ..baseUrl = url
      ..connectTimeout = timeout
      ..receiveTimeout = timeout
      ..sendTimeout = timeout;

    // Настройка для работы через прокси (при необходимости)
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final client = HttpClient();
      if (proxyUrl != null && proxyUrl.isNotEmpty) {
        client
          ..findProxy = (uri) => 'PROXY $proxyUrl'
          ..badCertificateCallback = (_, __, ___) => true;
      }
      return client;
    };

    dio.interceptors.addAll(interceptors);

    return dio;
  }
}
```

### 🔧 Ключевые параметры:

| Параметр | Значение | Назначение |
|----------|----------|------------|
| **baseUrl** | `http://localhost:8888` | Базовый адрес API сервера |
| **timeout** | `30 секунд` | Максимальное время ожидания |
| **interceptors** | `[]` | Перехватчики для обработки запросов |
| **proxyUrl** | `optional` | Поддержка работы через прокси |

---

## 📡 API константы

Все URL эндпоинтов централизованы в отдельном классе:

```dart
class ApiUrls {
  static const String baseUrl = 'http://localhost:8888';
  static const String places = '/place';
  static const String placeDetails = '/place/{placeId}';
  static const String filteredPlaces = '/filtered_places';
  static const String uploadFile = '/upload_file';

  const ApiUrls._();
}
```

> 💡 **Преимущества такого подхода:**
> - 🎯 Все URL в одном месте
> - 🔄 Легко изменить адрес сервера
> - 🧪 Простое переключение между dev/prod окружениями

---

## 🏗️ Retrofit API интерфейс

Для декларативного описания API используется библиотека **Retrofit**:

```dart
@RestApi()
abstract class ApiClientRemote implements ApiClient {
  factory ApiClientRemote(Dio dio, {String baseUrl}) = _ApiClientRemote;

  @override
  @GET(ApiUrls.places)
  Future<List<PlaceDto>> getPlaces();

  @override
  @POST(ApiUrls.filteredPlaces)
  Future<List<PlaceDto>> getFilteredPlaces({
    @Body() required FilterPlacesRequestDto filter
  });

  @GET(ApiUrls.placeDetails)
  Future<PlaceDto> getPlaceDetails(@Path() int placeId);

  @POST(ApiUrls.uploadFile)
  @MultiPart()
  Future<String> uploadFile(@Part() File file);
}
```

### 📚 Аннотации Retrofit:

| Аннотация | Назначение | Пример использования |
|-----------|------------|---------------------|
| **@GET/@POST** | HTTP методы | `@GET('/places')` |
| **@Body()** | Тело запроса | `@Body() FilterDto filter` |
| **@Path()** | Параметр в URL | `@Path() int id` для `/place/{id}` |
| **@Query()** | Query параметры | `@Query() String search` для `?search=value` |
| **@MultiPart()** | Загрузка файлов | Для отправки изображений |

> ⚙️ **Важно:** Retrofit генерирует реализацию в файле `api_client_remote.g.dart` через `build_runner`

---

## 📄 DTO модели и JSON сериализация

Для работы с JSON используются DTO (Data Transfer Object) модели:

```dart
@JsonSerializable(createToJson: false)
class PlaceDto {
  final String description;
  final double? distance;
  final int id;
  @JsonKey(name: 'urls')
  final List<String> images;
  final double lat;
  @JsonKey(name: 'lng')  
  final double lon;
  final String name;
  final PlaceTypeDto placeType;

  const PlaceDto({
    required this.id,
    required this.name,
    required this.description,
    required this.placeType,
    required this.images,
    required this.lat,
    required this.lon,
    this.distance,
  });

  factory PlaceDto.fromJson(Map<String, dynamic> json) => _$PlaceDtoFromJson(json);
}
```

### 🔑 Особенности сериализации:

| Аннотация | Назначение | Пример |
|-----------|------------|--------|
| **@JsonSerializable()** | Автогенерация методов | `createToJson: false` - только десериализация |
| **@JsonKey(name: '...')** | Маппинг полей | `@JsonKey(name: 'lng')` для `lon` |
| **factory fromJson()** | Конструктор из JSON | Генерируется автоматически |


## 🚨 Обработка ошибок - основы

При работе с сетью неизбежно возникают ошибки. В нашем приложении есть базовый механизм для их обработки:

### 🛡️ Базовый подход

```dart
abstract base class BaseRepository {
  @protected
  RequestOperation<T> makeApiCall<T>(AsyncValueGetter<T> call) async {
    try {
      final data = await call();
      return Result.ok(data);
    } on DioException catch (e, s) {
      // Здесь будет логика обработки сетевых ошибок
      return Result.failed(/* обработка ошибки */, s);
    } on Object catch (e, s) {
      return Result.failed(UnknownFailure(message: e.toString()), s);
    }
  }
}
```

### 🎯 Основные типы проблем:

| Тип проблемы | Описание |
|-------------|----------|
| **Нет интернета** | Пользователь офлайн |
| **Таймаут сервера** | Сервер не отвечает |
| **Ошибка сервера** | Проблемы на бекенде |
| **Неизвестная ошибка** | Другие проблемы |

---

## 📦 Интеграция с Repository

Repository использует `makeApiCall()` для унифицированной обработки ошибок:

```dart
final class PlacesRepository extends BaseRepository implements IPlacesRepository {
  final ApiClient _apiClient;
  final IPlaceResponseConverter _placeResponseConverter;

  @override
  RequestOperation<List<PlaceEntity>> getPlaces() => 
    makeApiCall(() async {
      final data = await _apiClient.getPlaces();
      return _placeResponseConverter.convertMultiple(data).toList();
    });
}
```

**🔧 Ключевые особенности:**
- ✅ `makeApiCall()` - базовая обработка ошибок
- 🔄 `Converters` - преобразование DTO ↔ Entity  
- 📊 `RequestOperation<T>` - типизированный результат с ошибками

---

# 🎨 Интеграция с UI слоем

Последний этап - подключение сетевых запросов к пользовательскому интерфейсу:

## 🧠 Model с состояниями загрузки

```dart
class PlacesModel implements IPlacesModel {
  final PlacesRepository _repository;
  final _placesState = ValueNotifier<PlacesState>(PlacesState.loading());

  PlacesModel(this._repository);

  @override
  ValueListenable<PlacesState> get placesStateListenable => _placesState;

  @override
  Future<void> loadPlaces({FilterPlacesEntity? filter}) async {
    _placesState.value = PlacesState.loading(); // Показываем индикатор загрузки
    
    final result = await _repository.getPlaces(
      filter: filter ?? await _repository.getSavedFilter()
    );

    switch (result) {
      case ResultOk(:final data):
        _placesState.value = PlacesState.loaded(data);
      case ResultFailed(:final error):
        _placesState.value = PlacesState.error(_mapErrorToMessage(error));
    }
  }

  String _mapErrorToMessage(Failure error) {
    return switch (error) {
      NoNetworkFailure() => 'Нет подключения к интернету',
      ServerNotRespondingFailure() => 'Сервер не отвечает. Попробуйте позже',
      BadRequestFailure(:final message) => message ?? 'Некорректный запрос',
      UnauthorizedFailure() => 'Требуется авторизация',
      TooManyRequestsFailure(:final message) => message ?? 'Слишком много запросов',
      InternalServerFailure() => 'Ошибка сервера. Попробуйте позже',
      _ => 'Произошла ошибка: ${error.toString()}'
    };
  }

  @override
  Future<void> refresh() => loadPlaces(); // Для pull-to-refresh

  @override
  void dispose() {
    _placesState.dispose();
  }
}

abstract interface class IPlacesModel {
  ValueListenable<PlacesState> get placesStateListenable;
  
  Future<void> loadPlaces({FilterPlacesEntity? filter});
  Future<void> refresh();
  void dispose();
}
```

## 📱 Отображение состояний в UI

```dart
ValueListenableBuilder<PlacesState>(
  valueListenable: placesModel.placesStateListenable,
  builder: (context, state, _) {
    return switch (state) {
      
      // Состояние загрузки
      PlacesLoadingState() => const Center(
        child: CircularProgressIndicator(),
      ),
      
      // Успешная загрузка данных
      PlacesLoadedState(:final places) => RefreshIndicator(
        onRefresh: () => placesModel.refresh(),
        child: ListView.builder(
          itemCount: places.length,
          itemBuilder: (context, index) => PlaceCard(
            place: places[index],
            onTap: () => _navigateToDetails(context, places[index]),
          ),
        ),
      ),
      
      // Обработка ошибок
      PlacesErrorState(:final message) => ErrorPlaceholder(
        message: message,
        onRetry: () => placesModel.loadPlaces(),
      ),
    };
  },
)
```

### 🎨 Компоненты UI для сетевых состояний:

| Состояние | UI компонент | Действия пользователя |
|-------------|-------------|---------------------|
| **Loading** | `CircularProgressIndicator` | ⏳ Ожидание |
| **Loaded** | `ListView` + `RefreshIndicator` | 🔄 Pull-to-refresh |
| **Error** | `ErrorPlaceholder` | 🔄 Кнопка "Повторить" |
| **Empty** | `EmptyPlaceholder` | 🔍 Изменить фильтры |

---

# 📋 Пошаговое руководство по реализации

Теперь пошагово интегрируем сетевые запросы в существующее приложение:

## 🚀 Шаг 1: Подготовка зависимостей

Убедитесь, что в `pubspec.yaml` подключены необходимые пакеты:

```yaml
dependencies:
  # HTTP клиент
  dio: ^5.4.0
  
  # REST API генератор  
  retrofit: ^4.0.3
  
  # JSON сериализация
  json_annotation: ^4.8.1

dev_dependencies:
  # Генерация кода
  build_runner: ^2.4.7
  retrofit_generator: ^8.0.6
  json_serializable: ^6.7.1
```

**Выполните команды:**
```bash
flutter pub get
dart run build_runner build # Генерация API клиента и сериализации
```

## 🔧 Шаг 2: Регистрация в DI системе

В файле `app_scope_register.dart` зарегистрируйте новые компоненты:

```dart
// Создание HTTP клиента
final dio = AppDioConfigurator().create(
  interceptors: [
    // Можно добавить логирование
    if (kDebugMode) LogInterceptor(responseBody: true),
  ],
  url: ApiUrls.baseUrl,
);

// Создание API клиента
final apiClient = ApiClientRemote(dio);

// Обновление репозитория
final placesRepository = PlacesRepository(
  apiClient: apiClient, // Заменяем ApiClientFromAssets на ApiClientRemote
  filterStorage: filterStorage,
  filterPlacesConverter: filterPlacesConverter,
  placeResponseConverter: placeResponseConverter,
);
```

## 📡 Шаг 3: Запуск локального сервера

Для тестирования потребуется запустить локальный API сервер:

> 🔧 **Техническая подсказка:** В проекте должен быть предоставлен скрипт для запуска тестового сервера или Docker-контейнер с API

```bash
# Если есть Docker
docker run -p 8888:8888 places-api-server

# Или запуск локального сервера (зависит от проекта)
npm start # или python app.py, или go run main.go
```

## ✅ Шаг 4: Проверка интеграции

После запуска приложения проверьте:

| Проверка | Ожидаемый результат | Что смотрим |
|---------------------|-------------|-------------|
| **🔄 Загрузка** | Показывается индикатор | `CircularProgressIndicator` |
| **📊 Данные** | Загружаются места с сервера | Список не пустой |
| **🌐 Сеть** | Запросы выполняются | Логи в консоли |
| **🚨 Ошибки** | Показываются понятные сообщения | При отключении сервера |

## 🔧 Шаг 5: Добавление состояний загрузки

Обновите UI компоненты для отображения состояний:

```dart
// В PlaceCard добавьте skeleton loader
class PlaceCard extends StatelessWidget {
  final PlaceEntity? place; // Может быть null во время загрузки
  
  @override
  Widget build(BuildContext context) {
    if (place == null) {
      return SkeletonPlaceCard(); // Показываем skeleton
    }
    
    return Card(
      child: ListTile(
        leading: CachedNetworkImage(
          imageUrl: place!.images.first,
          placeholder: (_, __) => ShimmerBox(),
          errorWidget: (_, __, ___) => Icon(Icons.error),
        ),
        title: Text(place!.name),
        subtitle: Text(place!.description),
      ),
    );
  }
}
```

---

# 🎯 Задания для самостоятельной работы

## 🖥️ Настройка локального сервера

Для выполнения заданий вам потребуется запустить локальный бекенд:

**📍 Репозиторий бекенда:** https://github.com/surfstudio/flutter-course-backend

**🔧 Настройка:**
1. Склонируйте репозиторий бекенда
2. Следуйте инструкциям по запуску в README репозитория  
3. Убедитесь что сервер доступен по адресу `http://localhost:8888`

---

## 🟢 Задание на оценку "3" *(базовый уровень)*

> **🎨 Референс:** Все необходимые экраны уже реализованы, фокус на интеграции с сетью

**🎯 Цель:** Реализовать базовую работу с сетевыми запросами

### 📋 Задачи для реализации:
1. Реализуйте `AppDioConfigurator` с таймаутами 30 сек
2. Создайте `ApiClientRemote` с методами `getPlaces()` и `getPlaceDetails()`
3. Замените `ApiClientFromAssets` на `ApiClientRemote` в DI системе
4. Добавьте индикаторы загрузки на экраны с сетевыми запросами

---

## 🟡 Задание на оценку "4" *(продвинутый уровень)*

**🎯 Дополнительно к предыдущим требованиям:**

### 📋 Задачи для реализации:
1. Добавьте `RefreshIndicator` на экраны со списками
2. Создайте `FilterPlacesRequestDto` с JSON сериализацией
3. Реализуйте POST эндпоинт `getFilteredPlaces()` в API клиенте
4. Создайте `IFilterStorage` для сохранения настроек фильтров
5. Обновите `PlacesRepository` для поддержки фильтрации
6. Подключите экран фильтров к бекенду (не локальная фильтрация)

---

## 🔴 Задание на оценку "5" *(экспертный уровень)*

**🎯 Дополнительно к предыдущим требованиям:**

### 📋 Основные задачи:
1. Создайте классы сетевых ошибок (`NoNetworkFailure`, `ServerNotRespondingFailure`, etc.)
2. Реализуйте `unwrapDioException()` для маппинга HTTP кодов в типы ошибок
3. Создайте UI компоненты для отображения ошибок (`ErrorPlaceholder`)
4. Обновите все Model классы для обработки ошибок
5. Реализуйте `ApiRetryInterceptor` с экспоненциальной задержкой
