import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
        final url =
            'https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/$z/$x/$y?access_token=pk.eyJ1IjoidGVzdGVyLWRvbm8iLCJhIjoiY2wzbG1idXVuMW9jZzNkcXdnNGZwN2NlOSJ9.LGGfGe5NuuAyD-FFepK47g';

        return CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.cover,
        );
      },
    );
  }
}
