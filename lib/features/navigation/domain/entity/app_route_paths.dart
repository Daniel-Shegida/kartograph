/// List of all the paths that are used to navigate in temp feature.
///
/// Have to been filled with the entries like this:
/// ```dart
/// /// Path description.
/// static const String screenPath = '/screenPath';
/// ```
abstract class AppRoutePaths {
  /// Path to tabs.
  static const String tabs = '/tabs/';

  /// Path to map screen.
  static const String mapScreen = 'mapScreen/';

  /// Path to places screen.
  static const String placesScreen = 'placesScreen/';

  /// Path to settings screen.
  static const String settingScreen = 'settingScreen/';

  /// Path to change place
  static const String changingPlaceScreen = 'changingPlaceScreen/';

  /// Path to creating place
  static const String creatingPlaceScreen = 'creatingPlaceScreen/';

  /// Path to map with adding place
  static const String mapAdding = 'mapAdding/';
}
