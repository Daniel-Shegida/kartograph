import 'package:flutter/material.dart';
import 'package:kartograph/api/domain/place.dart';
import 'package:kartograph/assets/enums/categories.dart';
import 'package:kartograph/features/navigation/domain/entity/app_route_paths.dart';
import 'package:routemaster/routemaster.dart';

/// виджет маркера на карте
class TransferMarker extends StatelessWidget {
  /// иконка маркера
  final Place place;

  /// конструктор [TransferMarker]
  const TransferMarker({
    required this.place,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Icon(
          place.placeType.categoryIcon,
          color: place.placeType.categoryColor,
          size: 48,
        ),
        onTap: () {
          if (place.placeType != Categories.newPlace) {
            Routemaster.of(context).push(
              '${AppRoutePaths.tabs}${AppRoutePaths.placesScreen}${AppRoutePaths.changingPlaceScreen}${place.id}',
              queryParameters: {
                'category': place.placeType.name,
                'name': place.name,
                'description': place.description,
                'lat': place.lat.toString(),
                'lng': place.lng.toString(),
              },
            );
          }
        },
      );
  }
}
