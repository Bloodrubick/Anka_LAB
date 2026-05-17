# 💾 ЛР5: Работа с локальным хранилищем

## 🔄 Эволюция данных в нашем приложении

В предыдущих лабораторных работах мы создали полноценное приложение для поиска интересных мест с сетевым взаимодействием. 

---

### ⚠️ Текущая проблема

Сейчас наше приложение работает с данными из сети, но **не сохраняет пользовательские данные локально**. Это означает:

> **🚨 Проблемы текущего подхода:**
> - 🔄 Данные загружаются при каждом запуске приложения
> - ❤️ Избранные места не сохраняются между сессиями  
> - 🔍 История поиска пропадает при закрытии приложения
> - ⚙️ Настройки фильтров сбрасываются после перезапуска
> - 📶 Нет работы в офлайн режиме - приложение бесполезно без интернета
> - 🎨 Выбранная тема интерфейса не запоминается

## 🎯 Что мы будем реализовывать

Теперь пришло время превратить наше приложение в **полноценный клиент** с локальным хранилищем:

### 📋 Этапы реализации:

| Этап | Компонент | Описание |
|------|-----------|----------|
| 1️⃣ | **Ключ-значение хранилище** | SharedPreferences для простых настроек |
| 2️⃣ | **SQL база данных** | Drift для структурированных данных |
| 3️⃣ | **Абстракции хранилища** | Repository паттерн для работы с данными |
| 4️⃣ | **DAO паттерн** | Data Access Objects для доступа к таблицам |
| 5️⃣ | **Интеграция в UI** | Сохранение состояния пользовательского интерфейса |

---

> 💡 **Важно помнить:** Локальное хранилище - это **основа пользовательского опыта** в мобильных приложениях. От качества реализации зависит удобство использования и производительность приложения.

📖 **Дополнительные ресурсы:**
- [Persistence во Flutter](https://docs.flutter.dev/cookbook/persistence)
- [Официальная документация Drift](https://pub.dev/packages/drift)

---

Современные мобильные приложения должны работать независимо от сетевого подключения, сохраняя пользовательские данные и настройки между сессиями.

# 🗄️ Архитектура локального хранилища во Flutter

Рассмотрим как правильно организовать локальное хранилище в Flutter приложении.

## 🏗️ Многоуровневая архитектура хранения

В нашем приложении используется гибридный подход с разными типами хранилищ:

```
UI Layer (Widgets/Pages)
     ↓
Business Logic Layer (Models)  
     ↓
Repository Layer (StorageRepository)
     ↓ 
Storage Layer → SharedPreferences (настройки)
              → Drift Database (структурированные данные)
              → File System (кэш изображений)
```

### 🎯 Ответственность каждого слоя:

| Слой | Ответственность | Примеры компонентов |
|------|-----------------|---------------------|
| **🎨 UI Layer** | Отображение данных и реакция на изменения | Widgets, Pages, Screens |
| **🧠 Business Logic** | Управление состоянием и бизнес-логика | Models, Blocs, Controllers |
| **📦 Repository** | Абстракция источников данных | Repository, Storage Interfaces |  
| **💾 Storage Layer** | Физическое хранение данных | SharedPreferences, Database, Files |

---

## 🔧 Типы локального хранилища во Flutter

Во Flutter есть несколько вариантов для локального хранения данных:

| Решение | Тип данных | Особенности | Рекомендуется для |
|---------|-------------|-------------|-----------------|
| **[SharedPreferences](https://pub.dev/packages/shared_preferences)** | Ключ-значение | • Простые настройки<br>• Примитивные типы<br>• Синхронное API | 🎛️ Настройки приложения |  
| **[Drift](https://pub.dev/packages/drift)** | SQL база данных | • Реляционные данные<br>• Сложные запросы<br>• Типобезопасность | 🗃️ Структурированные данные |
| **[Hive](https://pub.dev/packages/hive)** | NoSQL база | • Быстрая запись<br>• Объектная модель<br>• Шифрование | ⚡ Высокая производительность |
| **[File System](https://pub.dev/packages/path_provider)** | Файлы | • Изображения<br>• Документы<br>• Кэш данных | 📁 Медиа файлы |

### 🎯 Почему именно Drift + SharedPreferences?

В нашем проекте используется **комбинированный подход**:

<details>
<summary>✅ <strong>SharedPreferences для настроек</strong></summary>

- 🎛️ **Простые настройки** - тема, язык, фильтры
- ⚡ **Быстрый доступ** к часто используемым данным
- 🔄 **Синхронизация** между запусками приложения
- 📱 **Нативная реализация** на платформах

</details>

<details>
<summary>✅ <strong>Drift для структурированных данных</strong></summary>

- 🗃️ **Реляционная база данных** с SQL запросами
- 🛡️ **Типобезопасность** на этапе компиляции  
- 🔄 **Миграции схемы** при обновлениях
- 📊 **Сложные запросы** с JOIN, фильтрацией, сортировкой
- 🎯 **Code generation** для DAO и таблиц

</details>

---

# 🔍 Анализ текущего состояния проекта

Давайте посмотрим, как организовано локальное хранилище в нашем приложении:

### 🗃️ AppDatabase - центральная база данных

База данных построена на Drift ORM:

```dart
@DriftDatabase(
  tables: [
    FavoritePlacesTable,
    HistorySearchTable,
  ],
  daos: [
    FavoritesDao,
    HistorySearchDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}
```

**Ключевые особенности:**
- ✅ Декларативное описание схемы через аннотации
- 🔄 Автогенерация кода для таблиц и DAO
- 📁 SQLite файл в директории приложения
- 🛡️ Типобезопасные операции с данными

### 📊 Таблицы базы данных

#### FavoritePlacesTable - избранные места
```dart
class FavoritePlacesTable extends Table {
  IntColumn get id => integer()();
  IntColumn get placeId => integer()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  IntColumn get type => intEnum<PlaceType>()();
  TextColumn get images => text().map(const ListStringConverter())();
  RealColumn get lat => real()();
  RealColumn get lon => real()();
  
  @override
  Set<Column> get primaryKey => {id};
}
```

#### HistorySearchTable - история поиска
```dart
class HistorySearchTable extends Table {
  IntColumn get id => integer()();
  TextColumn get keyword => text()();
  
  @override
  Set<Column> get primaryKey => {id};
}
```

### 🔧 DAO - Data Access Objects

#### FavoritesDao - работа с избранными
```dart
@DriftAccessor(tables: [FavoritePlacesTable])
class FavoritesDao extends DatabaseAccessor<AppDatabase> with _$FavoritesDaoMixin {
  
  Stream<List<FavoritePlacesTableData>> get favoritesStream => 
    select(favoritePlacesTable).watch();

  Future<void> addFavorite(FavoritePlacesTableCompanion place) =>
    into(favoritePlacesTable).insert(place, mode: InsertMode.replace);

  Future<void> removeFavorite(int placeId) =>
    (delete(favoritePlacesTable)..where((tbl) => tbl.placeId.equals(placeId))).go();
}
```

### 🎛️ SharedPreferences хранилища

#### FilterStorage - настройки фильтров
```dart
class FilterStorage implements IFilterStorage {
  final SharedPreferences _prefs;

  @override
  Future<FilterPlacesRequestDto> getFilter() async {
    final filter = _prefs.getString(FilterStorageKeys.filter.keyName);
    if (filter == null || filter.trim().isEmpty) return _defaultFilter;
    
    final decoded = jsonDecode(filter) as Map<String, dynamic>;
    return FilterPlacesRequestDto.fromJson(decoded);
  }

  @override
  Future<void> saveFilter({required FilterPlacesRequestDto filterDto}) async {
    await _prefs.setString(FilterStorageKeys.filter.keyName, jsonEncode(filterDto));
  }
}
```

#### ThemeModeStorage - настройки темы
```dart
class ThemeModeStorage implements IThemeModeStorage {
  @override
  Future<ThemeMode> getThemeMode() async {
    final themeName = _prefs.getString(ThemeStorageKeys.mode.keyName);
    return ThemeMode.values.firstWhereOrNull((mode) => mode.name == themeName) ?? 
           _defaultThemeMode;
  }
}
```

---

# 🛠️ Техническая реализация локального хранилища

## 🗃️ Конфигурация Drift Database

### Подключение к базе данных

```dart
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    return NativeDatabase.createInBackground(file);
  });
}
```

### 🔑 Ключевые параметры:

| Параметр | Значение | Назначение |
|----------|----------|------------|
| **Местоположение** | `Documents Directory` | Приватная папка приложения |
| **Имя файла** | `db.sqlite` | SQLite база данных |
| **Режим** | `createInBackground` | Неблокирующее создание |
| **Версия схемы** | `1` | Для миграций в будущем |

---

## 📋 Создание таблиц в Drift

### Определение столбцов

```dart
class FavoritePlacesTable extends Table {
  // Автоинкрементный первичный ключ
  IntColumn get id => integer()();
  
  // Ссылка на место из API
  IntColumn get placeId => integer()();
  
  // Текстовые поля
  TextColumn get name => text()();
  TextColumn get description => text()();
  
  // Enum значения
  IntColumn get type => intEnum<PlaceType>()();
  
  // Кастомный конвертер для списков
  TextColumn get images => text().map(const ListStringConverter())();
  
  // Числовые значения
  RealColumn get lat => real()();
  RealColumn get lon => real()();
  
  @override
  Set<Column> get primaryKey => {id};
}
```

### 🔄 Конверторы типов

```dart
class ListStringConverter extends TypeConverter<List<String>, String> {
  const ListStringConverter();

  @override
  List<String> fromSql(String fromDb) {
    return fromDb.split(',');
  }

  @override
  String toSql(List<String> value) {
    return value.join(',');
  }
}
```

| Тип Dart | Тип SQL | Назначение |
|-----------|------------|---------------------|
| **List<String>** | **TEXT** | Список изображений через запятую |
| **PlaceType** | **INTEGER** | Enum как числовое значение |
| **DateTime** | **INTEGER** | Unix timestamp |

---

## 🔧 DAO - паттерн доступа к данным

### Базовые операции CRUD

```dart
@DriftAccessor(tables: [FavoritePlacesTable])
class FavoritesDao extends DatabaseAccessor<AppDatabase> with _$FavoritesDaoMixin {
  
  // CREATE - добавление записи
  Future<void> addFavorite(FavoritePlacesTableCompanion place) =>
    into(favoritePlacesTable).insert(place, mode: InsertMode.replace);
  
  // READ - чтение данных  
  Future<List<FavoritePlacesTableData>> fetchFavorites() => 
    select(favoritePlacesTable).get();
  
  // READ - реактивное чтение
  Stream<List<FavoritePlacesTableData>> get favoritesStream => 
    select(favoritePlacesTable).watch();
  
  // DELETE - удаление записи
  Future<void> removeFavorite(int placeId) =>
    (delete(favoritePlacesTable)..where((tbl) => tbl.placeId.equals(placeId))).go();
}
```

### 🎯 Преимущества DAO паттерна:

| Преимущество | Описание |
|-------------|----------|
| **Инкапсуляция** | Скрывает детали работы с базой |
| **Тестируемость** | Легко мокать для unit-тестов |
| **Переиспользование** | Один DAO для всех операций с таблицей |
| **Типобезопасность** | Компилятор проверяет корректность запросов |

---

## 💾 SharedPreferences для настроек

### Реализация Storage интерфейса

```dart
class FilterStorage implements IFilterStorage {
  static final _defaultFilter = FilterPlacesRequestDto.createDefault();
  final SharedPreferences _prefs;
  
  const FilterStorage(this._prefs);

  @override
  Future<FilterPlacesRequestDto> getFilter() async {
    final filter = _prefs.getString(FilterStorageKeys.filter.keyName);
    if (filter == null || filter.trim().isEmpty) return _defaultFilter;

    final decoded = jsonDecode(filter) as Map<String, dynamic>;
    return FilterPlacesRequestDto.fromJson(decoded);
  }

  @override
  Future<void> saveFilter({required FilterPlacesRequestDto filterDto}) async {
    await _prefs.setString(FilterStorageKeys.filter.keyName, jsonEncode(filterDto));
  }
}
```

### 🔑 Управление ключами

```dart
enum FilterStorageKeys {
  filter('filter_settings');

  final String keyName;
  const FilterStorageKeys(this.keyName);
}
```

**Преимущества централизованных ключей:**
- 🎯 Избежание опечаток в ключах
- 🔄 Легкое переименование
- 📊 Обзор всех настроек в одном месте

---

## 🚨 Обработка ошибок при работе с хранилищем

### Стратегии обработки ошибок

```dart
abstract base class BaseStorageRepository {
  @protected
  Future<T> safeStorageCall<T>(Future<T> Function() call, T defaultValue) async {
    try {
      return await call();
    } on DatabaseException catch (e, s) {
      // Проблемы с базой данных
      _logger.error('Database error: ${e.message}', e, s);
      return defaultValue;
    } on FormatException catch (e, s) {
      // Проблемы с сериализацией JSON
      _logger.error('Serialization error: ${e.message}', e, s);
      return defaultValue;
    } on FileSystemException catch (e, s) {
      // Проблемы с файловой системой
      _logger.error('File system error: ${e.message}', e, s);
      return defaultValue;
    } on Object catch (e, s) {
      // Неизвестные ошибки
      _logger.error('Unknown storage error: $e', e, s);
      return defaultValue;
    }
  }
}
```

### 🎯 Основные типы проблем:

| Тип проблемы | Причина | Стратегия обработки |
|-------------|----------|----------|
| **DatabaseException** | Коррупция базы, блокировка | Возврат значений по умолчанию |
| **FormatException** | Неверный JSON, устаревшие данные | Очистка поврежденных данных |
| **FileSystemException** | Нет прав доступа, диск заполнен | Уведомление пользователя |

---

# 🎨 Интеграция с UI слоем

Последний этап - подключение локального хранилища к пользовательскому интерфейсу:

## 🧠 Model с реактивными состояниями

```dart
class FavoritesModel implements IFavoritesModel {
  final FavoritesDao _favoritesDao;
  
  FavoritesModel(this._favoritesDao);

  @override
  Stream<List<PlaceEntity>> get favoritesStream => 
    _favoritesDao.favoritesStream.map(
      (favorites) => favorites.map(_converter.convert).toList()
    );

  @override
  Future<void> addToFavorites(PlaceEntity place) async {
    final companion = FavoritePlacesTableCompanion(
      placeId: Value(place.id),
      name: Value(place.name),
      description: Value(place.description),
      type: Value(place.type),
      images: Value(place.images),
      lat: Value(place.coordinates.lat),
      lon: Value(place.coordinates.lon),
    );
    
    await _favoritesDao.addFavorite(companion);
  }

  @override
  Future<void> removeFromFavorites(int placeId) async {
    await _favoritesDao.removeFavorite(placeId);
  }

  @override
  Future<bool> isFavorite(int placeId) async {
    final favorites = await _favoritesDao.fetchFavorites();
    return favorites.any((fav) => fav.placeId == placeId);
  }
}
```

## 📱 Отображение данных в UI

```dart
class FavoritesPage extends StatelessWidget {
  final IFavoritesModel favoritesModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Избранные места')),
      body: StreamBuilder<List<PlaceEntity>>(
        stream: favoritesModel.favoritesStream,
        builder: (context, snapshot) {
          return switch (snapshot) {
            // Состояние загрузки
            AsyncSnapshot(:final connectionState) when connectionState == ConnectionState.waiting => 
              const Center(child: CircularProgressIndicator()),
            
            // Успешная загрузка данных  
            AsyncSnapshot(:final data) when data != null && data.isNotEmpty => 
              ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) => PlaceCard(
                  place: data[index],
                  onFavoriteToggle: () => _toggleFavorite(data[index]),
                ),
              ),
            
            // Пустой список избранных
            AsyncSnapshot(:final data) when data != null && data.isEmpty => 
              const EmptyFavoritesPlaceholder(),
            
            // Ошибка загрузки
            AsyncSnapshot(:final error) when error != null => 
              ErrorPlaceholder(
                message: 'Ошибка загрузки избранных мест',
                onRetry: () => setState(() {}),
              ),
            
            _ => const SizedBox.shrink(),
          };
        },
      ),
    );
  }

  void _toggleFavorite(PlaceEntity place) async {
    final isFavorite = await favoritesModel.isFavorite(place.id);
    if (isFavorite) {
      await favoritesModel.removeFromFavorites(place.id);
    } else {
      await favoritesModel.addToFavorites(place);
    }
  }
}
```

### 🎨 Компоненты UI для работы с хранилищем:

| Состояние | UI компонент | Действия пользователя |
|-----------|--------------|----------------------|
| **Loading** | `CircularProgressIndicator` | ⏳ Ожидание загрузки |
| **Loaded** | `ListView` с данными | ❤️ Переключение избранных |
| **Empty** | `EmptyPlaceholder` | 🔍 Добавить в избранное |
| **Error** | `ErrorPlaceholder` | 🔄 Повторить загрузку |

---

# 📋 Пошаговое руководство по реализации

Теперь пошагово интегрируем локальное хранилище в существующее приложение:

## 🚀 Шаг 1: Подготовка зависимостей

Убедитесь, что в `pubspec.yaml` подключены необходимые пакеты:

```yaml
dependencies:
  # Простое ключ-значение хранилище
  shared_preferences: ^2.2.2
  
  # SQL база данных ORM
  drift: ^2.14.1
  
  # Получение путей файловой системы
  path_provider: ^2.1.2
  path: ^1.8.3
  
  # Сериализация JSON
  json_annotation: ^4.8.1

dev_dependencies:
  # Генерация кода
  build_runner: ^2.4.7
  drift_dev: ^2.14.1
  json_serializable: ^6.7.1
```

**Выполните команды:**
```bash
flutter pub get
dart run build_runner build # Генерация DAO и таблиц
```

## 🔧 Шаг 2: Регистрация в DI системе

В файле DI конфигурации зарегистрируйте компоненты хранилища:

```dart
// Инициализация SharedPreferences
final sharedPreferences = await SharedPreferences.getInstance();

// Создание хранилищ настроек
final filterStorage = FilterStorage(sharedPreferences);
final themeModeStorage = ThemeModeStorage(sharedPreferences);

// Создание базы данных
final database = AppDatabase();

// Создание DAO
final favoritesDao = database.favoritesDao;
final historySearchDao = database.historySearchDao;

// Создание моделей
final favoritesModel = FavoritesModel(favoritesDao);
final searchHistoryModel = SearchHistoryModel(historySearchDao);
```

## ✅ Шаг 3: Проверка работы хранилища

После интеграции проверьте функциональность:

| Проверка | Ожидаемый результат | Что тестируем |
|---------|---------------------|-----------------|
| **💾 Сохранение** | Данные остаются после перезапуска | Избранные, настройки |
| **🔄 Реактивность** | UI обновляется при изменении данных | StreamBuilder |
| **🚨 Ошибки** | Обработка исключений хранилища | Поврежденные данные |
| **⚡ Производительность** | Быстрая загрузка при старте | Оптимизация запросов |

---

# 🎯 Задания для самостоятельной работы

## 🟢 Задание на оценку "3" *(базовый уровень)*

**🎯 Цель:** Повторить то, что было в рамках методички - изучить существующий функционал

### 📋 Задачи для реализации:
1. **Изучите архитектуру локального хранилища**
   - Проанализируйте структуру директории `lib/persistence/`
   - Изучите работу `AppDatabase` и регистрацию таблиц
   - Разберите различия между `SharedPreferences` и `Drift` подходами

2. **Протестируйте работу избранных мест**
   - Добавьте несколько мест в избранное
   - Закройте и перезапустите приложение
   - Убедитесь, что избранные места сохранились
   - Изучите код `FavoritesDao` и методы работы с базой

3. **Изучите сохранение настроек темы**
   - Переключите тему приложения (светлую/темную)
   - Перезапустите приложение и убедитесь, что тема сохранилась
   - Разберите код `ThemeModeStorage` и принципы работы с `SharedPreferences`

4. **Исследуйте историю поиска**
   - Выполните несколько поисковых запросов
   - Изучите, как сохраняется история в `HistorySearchDao`
   - Протестируйте функциональность очистки истории

---

## 🟡 Задание на оценку "4" *(продвинутый уровень)*

**🎯 Цель:** Реализовать локальное хранилище для фильтрации

**🎯 Дополнительно к предыдущим требованиям:**

### 📋 Задачи для реализации:

- Реализуйте `FilterStorage` для сохранения настроек фильтров в SharedPreferences
- Протестируйте сохранение различных типов фильтров между сессиями приложения
- Убедитесь, что фильтры автоматически применяются при запуске приложения
- Добавьте кнопку "Очистить все фильтры" в настройках

---

## 🔴 Задание на оценку "5" *(экспертный уровень)*

**🎯 Цель:** Реализовать хранение фильтров через Drift

**🎯 Дополнительно к предыдущим требованиям:**

### 📋 Основные задачи:

1. **Создайте таблицу для хранения фильтров**
   - Создайте `FilterSettingsTable` в Drift с полями для всех параметров фильтра
   - Добавьте поля для метаданных: `id`, `name`, `createdAt`, `updatedAt`, `isDefault`
   - Реализуйте конвертеры для сложных типов данных (список категорий, диапазоны)
   - Добавьте индексы для оптимизации запросов по дате и имени

2. **Реализуйте FilterSettingsDao**
   - Создайте DAO с методами CRUD операций для фильтров
   - Реализуйте получение активного фильтра и списка сохранённых фильтров
   - Добавьте методы для работы с пресетами фильтров
   - Реализуйте поиск фильтров по имени и дате создания

3. **Обновите FilterStorage для работы с Drift**
   - Перепишите `FilterStorage` для использования `FilterSettingsDao` вместо SharedPreferences  
   - Сохраните совместимость с существующим интерфейсом `IFilterStorage`
   - Добавьте миграцию данных из старого SharedPreferences хранилища
   - Реализуйте кэширование часто используемых фильтров в памяти

4. **Реализуйте миграцию базы данных**
   - Увеличьте `schemaVersion` в `AppDatabase`
   - Создайте миграцию для добавления новой таблицы фильтров
   - Добавьте логику переноса данных из SharedPreferences в Drift
   - Предусмотрите откат миграции в случае ошибок
