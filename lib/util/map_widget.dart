import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kartograph/assets/strings/projectStrings.dart';
import 'package:map/map.dart';

/// виджет, отображающий карту на MapScreen
class MapWidget extends StatelessWidget {
  /// контроллер отвечающие за перемещение и зум карты
  final MapController mapController;
  /// конструктор принимабщий в стебя контроллер
  const MapWidget({required this.mapController, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Map(
      controller: mapController,
      builder: (context, x, y, z) {

        final url = ProjectStrings.getUrl(x, y, z);


        return CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.cover,
        );
      },
    );
  }
}
