import 'package:flutter/material.dart';

/// виджет маркера на карте
class Marker extends StatelessWidget {
  /// конструктор [Marker]
  const Marker(
      {required this.leftPos,
      required this.topPos,
      required this.iconData,
      required this.color,
      Key? key,})
      : super(key: key);

  final double leftPos;
  final double topPos;
  final IconData iconData;
  final Color color;

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
        onTap: () {
          // ignore: avoid_print
          print("touch");
        },
      ),
    );
  }
}
