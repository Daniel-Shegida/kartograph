import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:kartograph/assets/enums/categories.dart';

/// виджет, который показывает, которые типы мест ищутся
class PlacesChoiseDialogWidget extends StatelessWidget {
  /// список найденных мест
  final List<ListenableState<bool>> statesList;

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: List<Widget>.generate(Categories.values.length, (index) {
        return StateNotifierBuilder<bool>(
          listenableState: statesList[index],
          builder: (_, value) {
            return CheckboxListTile(
              title: Text(Categories.values.elementAt(index).categoryName),
              value: value,
              onChanged: (value) {
                onChanged(value, index);
              },
              secondary: Icon(
                Icons.circle,
                color: Categories.values.elementAt(index).categoryColor,
              ),
            );
          },
        );
      }),
    );
  }
}
