import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// карточка с возможными параметрами переключателя и иконки
class CardWidget extends StatelessWidget {
  /// имя карточки
  final String cardName;
  /// функция при нажатии на карточку
  final VoidCallback onPressed;
  /// значениеи переключателя
  final bool? switchFlag;
  /// функция переключателя
  final Function(bool)? switchFun;
  /// иконка карточки
  final SvgPicture? icon;
  /// функция при нажатии на карточку
  final VoidCallback? onHelper;

  /// создает базовую карточку
  const CardWidget({
    required this.cardName,
    required this.onPressed,
    this.switchFlag,
    this.switchFun,
    this.icon,
    this.onHelper,
    Key? key,
  }) : super(key: key);

  /// создает карточку с переключателем
  const CardWidget.withSwitch({
    required this.cardName,
    required this.onPressed,
    required this.switchFlag,
    required this.switchFun,
    this.icon,
    this.onHelper,
    Key? key,
  }) : super(key: key);

  /// создает карточку с иконкой
  const CardWidget.withHelper({
    required this.cardName,
    required this.onPressed,
    required this.icon,
    required this.onHelper,
    this.switchFlag,
    this.switchFun,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cardName,
                ),
              ],
            ),
            const Spacer(),
            if (switchFlag != null)
              Switch(value: switchFlag!, onChanged: switchFun),
            if (icon != null)
              InkWell(
                onTap: onHelper,
                child: icon,
              ),
          ],
        ),
      ),
    );
  }
}
