import 'package:flutter_map/flutter_map.dart';

/// Содержит параметра для экрана карт
class ProjectMapSettings {
  /// Параметры флагов для возможностей карты (на данный момент доступно все
  /// кроме вращения)
  static const int interactiveFlags = InteractiveFlag.all & ~InteractiveFlag.rotate;

  /// Стартовое значение зума при иницилизации
  static const double zoom = 5.0;

  /// Ширина отображаемых маркеров
  static const double markersWidth = 80.0;

  /// Высота отображаемых маркеров
  static const double markersHeight = 80.0;


}
