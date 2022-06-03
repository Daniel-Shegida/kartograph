import 'package:flutter/material.dart';

/// виджет маркера на карте
class Marker extends StatelessWidget {
  /// горизонтальная позиция маркера
  final double leftPos;

  /// вертикальная позиция маркера
  final double topPos;

  /// иконка маркера
  final IconData iconData;

  /// цвет маркера
  final Color color;

  /// цвет маркера
  final VoidCallback onPressed;

  /// конструктор [Marker]
  const Marker({
    required this.leftPos,
    required this.topPos,
    required this.iconData,
    required this.color,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: leftPos - 24,
      top: topPos - 24,
      width: 48,
      height: 48,
      child: GestureDetector(
        child: Icon(
          iconData,
          color: color,
          size: 48,
        ),
        onTap: onPressed,
      ),
    );
  }
}
