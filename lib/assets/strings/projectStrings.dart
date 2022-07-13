/// Strings of Kartograph project
abstract class ProjectStrings {
  /// Название страницы настроек.
  static const String settings = 'Настройки';

  /// Название темной темы.
  static const String darkTheme = 'Темная тема';

  /// Название светлой темы.
  static const String lightTheme = 'Светлая тема';

  /// Название страницы настроек.
  static const String tutorialCard = 'Смотреть туториал';

  /// PlacesScreen bottom name.
  static const String placesBottom = 'places';

  /// MapScreen bottom name.
  static const String mapBottom = 'map';

  /// SettingScreen bottom name.
  static const String settingBottom = 'setting';

  /// Сайт откуда берется светлая карта.
  static const String ligthmapSite =
      'https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/{z}/{x}/{y}@2x?access_token=';

  /// Сайт откуда берется темная карта.
  static const String darkMapSite =
      'https://api.mapbox.com/styles/v1/mapbox/dark-v10/tiles/{z}/{x}/{y}@2x?access_token=';

  /// Персональный токен.
  static const String mapToken =
      'pk.eyJ1IjoidGVzdGVyLWRvbm8iLCJhIjoiY2wzbG1idXVuMW9jZzNkcXdnNGZwN2NlOSJ9.LGGfGe5NuuAyD-FFepK47g';

  /// PlacesScreen название фильтра.
  static const String filter = 'фильтр';

  /// PlacesScreen название поиска.
  static const String search = 'Поиск';

  /// Отель.
  static const String hotel = 'Отель';

  /// Рестаран.
  static const String restaurant = 'Рестаран';

  /// Другое.
  static const String other = 'Другое';

  /// Кафе.
  static const String cafe = 'Кафе';

  /// Музей.
  static const String museum = 'Музей';

  /// Парк.
  static const String park = 'Парк';

  /// Ошибочные параметры поиска.
  static const String wrongSearch = 'Ничего не найдено';

  /// Ошибочные параметры поиска пояснение.
  static const String wrongSearch2 = 'Попробуйте изменить параметры поиска';

  /// leading нэкрана добавить место
  static const String cancel = 'Отмена';

  /// Название экрана добавить место
  static const String newPlace = 'Новое место';

  /// добавить место категория.
  static const String category = 'Категория';

  /// добавить место название места.
  static const String name = 'Название';

  /// добавить место описание места.
  static const String description = 'Описание';

  /// добавить место подсказка полей.
  static const String hint = 'Text';

  /// добавить место указать на катре кнопка.
  static const String show = 'Указать на карте';

  /// добавить место создать место.
  static const String create = 'Создать';

  /// добавить место изменить место.
  static const String change = 'Изменить место';

  /// широта.
  static const String latitude = 'Широта';

  /// долгота.
  static const String longitude = 'Долгота';

  /// Название экрана добавить место
  static const String addPlace = 'Новое место';

  /// местоположение на экране добавить место
  static const String location = 'Местоположение';

  /// готово на экране добавить место
  static const String ready = 'готово';

  /// подсказка на экране добавить место
  static const String mapAddHint =
      'потяните карту чтобы выбрать правильное местоположение';

  /// Метод возвращающий url светлой карты.
  static String getLightUrl() {
    return '${ProjectStrings.ligthmapSite}${ProjectStrings.mapToken}';
  }

  /// Метод возвращающий url темной карты.
  static String getDarkUrl() {
    return '${ProjectStrings.darkMapSite}${ProjectStrings.mapToken}';
  }
}
