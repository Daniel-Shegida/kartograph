import 'package:flutter/material.dart';
import 'package:kartograph/assets/strings/projectStrings.dart';

/// поле ввода с двумя состояниями
class CustomTextField extends StatelessWidget {
  /// на сколько строк отображается виджет
  final int lines;

  /// состояние виджета
  final bool isPrepare;

  /// контроллер виджета
  final TextEditingController controller;

  /// конеструктор [CustomTextField]
  const CustomTextField({
    required this.isPrepare,
    required this.controller,
    this.lines = 1,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: isPrepare
                ? Theme.of(context).focusColor
                : Theme.of(context).disabledColor,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        hintText: ProjectStrings.hint,
        hintStyle:
            TextStyle(fontSize: 16.0, color: Theme.of(context).hintColor),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      ),
      minLines: lines,
      maxLines: lines,
    );
  }
}
