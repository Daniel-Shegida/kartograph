import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kartograph/assets/colors/colors.dart';
import 'package:kartograph/assets/enums/categories.dart';
import 'package:kartograph/assets/res/project_icons.dart';

/// виджет для выбора из нескольких элементов
class SelectorWidget extends StatelessWidget {
  /// текущее выбранное значение
  final Categories currentValue;

  /// список из выбора элементов
  final List<DropdownMenuItem<Categories>> list;

  /// функция переключающее элементы
  final void Function(Categories?) onChange;

  /// конструктор [SelectorWidget]
  const SelectorWidget({
    required this.currentValue,
    required this.list,
    required this.onChange,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Categories>(
      value: currentValue,
      icon: SvgPicture.asset(
        ProjectIcons.view,
        color: Theme.of(context).iconTheme.color,
      ),
      isExpanded: true,
      elevation: 16,
      // style: const TextStyle(color: ProjectColors.textColorGrey),
      underline: Container(
        height: 2,
        color: Theme.of(context).dividerColor,
      ),
      onChanged: onChange,
      items: list,
    );
  }
}
