/// Strings of Kartograph project
abstract class ProjectStrings {
  /// PlacesScreen bottom name.
  static const String placesBottom = 'places';
  /// MapScreen bottom name.
  static const String mapBottom = 'map';
  /// SettingScreen bottom name.
  static const String settingBottom = 'setting';
  /// Сайт откуда берется карта.
  static const String mapSite = 'https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/';
  /// Персональный токен.
  static const String mapToken = '?access_token=pk.eyJ1IjoidGVzdGVyLWRvbm8iLCJhIjoiY2wzbG1idXVuMW9jZzNkcXdnNGZwN2NlOSJ9.LGGfGe5NuuAyD-FFepK47g';

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
  /// широта.
  static const String latitude = 'Широта';
  /// долгота.
  static const String longitude = 'Долгота';


  /// Метод возвращающий url.
  static String getUrl(int x, int y, int z){
    return '${ProjectStrings.mapSite}$z/$x/$y${ProjectStrings.mapToken}';

  }
}