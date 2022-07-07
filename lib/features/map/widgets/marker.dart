import 'package:flutter/material.dart';
import 'package:kartograph/api/domain/place.dart';
import 'package:kartograph/assets/enums/categories.dart';

/// виджет маркера на карте
class TransferMarker extends StatelessWidget {
  /// иконка маркера
  final Place place;

  /// функция перехода на экран подробностей места
  final void Function(Place place, BuildContext context) onTap;

  /// конструктор [TransferMarker]
  const TransferMarker({
    required this.place,
    required this.onTap,
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
          onTap(place, context);
        }
      },
    );
  }
}
