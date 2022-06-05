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
  /// Сайт откуда берется карта.
  static const String mapSite = 'https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/';
  /// Персональный токен.
  static const String mapToken = '?access_token=pk.eyJ1IjoidGVzdGVyLWRvbm8iLCJhIjoiY2wzbG1idXVuMW9jZzNkcXdnNGZwN2NlOSJ9.LGGfGe5NuuAyD-FFepK47g';


  /// Метод возвращающий url.
  static String getUrl(int x, int y, int z){
    return '${ProjectStrings.mapSite}$z/$x/$y${ProjectStrings.mapToken}';

  }
}