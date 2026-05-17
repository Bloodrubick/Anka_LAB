/// Строковые константы.
abstract class AppStrings {
  /// Онбординг.
  static const onboardingSkipButton = 'Пропустить';
  static const onboardingPage1Title = 'Добро пожаловать\nв Путеводитель';
  static const onboardingPage1Description = 'Ищи новые локации и сохраняй\nсамые любимые.';
  static const onboardingPage2Title = 'Построй маршрут\nи отправляйся в путь';
  static const onboardingPage2Description = 'Достигай цели максимально\nбыстро и комфортно.';
  static const onboardingPage3Title = 'Добавляй места,\nкоторые нашёл сам';
  static const onboardingPage3Description = 'Делись самыми интересными\nи помоги нам стать лучше!';
  static const onboardingStartButton = 'На старт';

  /// Общие
  static const commonSearch = 'Поиск';
  static const commonClear = 'Очистить';
  static const commonCancel = 'Отмена';
  static const commonSave = 'Сохранить';
  static const commonRemove = 'Удалить';
  static const commonEmptyStateTitle = 'Ничего не найдено.';
  static const commonEmptyStateDescription = 'Попробуйте изменить параметры поиска';

  /// Список мест.
  static const placesAppBarTitle = 'Список\nинтересных мест';
  static const placesAppBarTitleSmall = 'Интересные места';

  /// Детальный экран места.
  static const placeDetailsAddToFavouritesButton = 'В Избранное';
  static const placeDetailsIsFavouritesButton = 'В Избранном';

  /// Ошибки
  static const errorRetryButton = 'Повторить';
  static const errorNoInternetTitle = 'Нет соединения с интернетом';
  static const errorNoInternetDescription = 'Проверьте подключение к сети или попробуйте подключиться позже';
  static const errorDefaultTitle = 'Ошибка';
  static const errorDefaultDescription = 'Что то пошло не так. Попробуйте повторить.';

  /// Фильтр.
  static const filterClearButtonTitle = 'Очистить';
  static const filterCategories = 'Категории';
  static const placeTypeMuseum = 'Музей';
  static const placeTypePark = 'Парк';
  static const placeTypeCafe = 'Кафе';
  static const placeTypeRestaurant = 'Ресторан';
  static const placeTypeHotel = 'Отель';
  static const placeTypeTemplate = 'Храм';
  static const placeTypeMonument = 'Памятник';
  static const placeTypeTheatre = 'Театр';
  static const placeTypeOther = 'Особое место';
  static const filterDistance = 'Расстояние';
  static const filterDistanceM = 'м';
  static const filterDistanceKm = 'км';

  static String filterResultButtonTitle(int count) => 'Показать ($count)';

  /// Настройки
  static const settingsAppBarTitle = 'Настройки';
  static const settingThemeDarkTitle = 'Тёмная тема';
  static const settingTutorialTitle = 'Смотреть туториал';

  /// Избранное
  static const favoritesAppBarTitle = 'Избранное';
  static const favoritesEmptyStateTitle = 'Пусто';
  static const favoritesEmptyStateDescription = 'Отмечайте понравившиеся места и они появятся здесь.';

  /// Список мест.
  static const searchAppBarTitle = 'Список интересных мест';
  static const searchHistoryListTitle = 'Вы искали';
  static const searchClearHistory = 'Очистить историю';
}
