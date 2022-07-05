import 'package:latlong2/latlong.dart';

/// Координаты проекта.
abstract class ProjectCoordinates {
  /// начальные координаты широты.
  static LatLng get staringCords => LatLng(32, -127);
}