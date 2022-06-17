import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:kartograph/assets/enums/categories.dart';
import 'package:kartograph/features/places/domain/types_to_show.dart';

/// виджет, который показывает, которые типы мест ищутся
class PlacesChoiseDialogWidget extends StatelessWidget {
  /// список найденных мест
  final ListenableState<ListPlacesToShow> statesList;

  /// функция изменения типа места
  final void Function(bool?, int) onChanged;

  /// конструктор [PlacesChoiseDialogWidget]
  const PlacesChoiseDialogWidget({
    required this.statesList,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StateNotifierBuilder<ListPlacesToShow>(
      listenableState: statesList,
      builder: (_, value) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: List<Widget>.generate(
            value!.listCategoriesToShow.length,
            (index) {
              return CheckboxListTile(
                title: Text(
                  value.listCategoriesToShow[index].category.categoryName,
                ),
                value: value.listCategoriesToShow[index].isChosen,
                onChanged: (value) {
                  onChanged(value, index);
                },
                secondary: Icon(
                  Icons.circle,
                  color: Categories.values.elementAt(index).categoryColor,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
