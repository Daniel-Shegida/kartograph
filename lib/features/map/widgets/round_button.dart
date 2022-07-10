import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kartograph/assets/colors/colors.dart';

/// кастомная круглая кнопка
class RoundButton extends StatelessWidget {
  /// путь к svg
  final String svgPath;

  /// метод кнопки
  final VoidCallback onPressed;

  /// конструктор [RoundButton]
  const RoundButton({required this.svgPath, required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 50,
      child: MaterialButton(
        onPressed: onPressed,
        child: SvgPicture.asset(
          svgPath,
          color: ProjectColors.textColorPrimary,
        ),
        shape: const CircleBorder(),
        color: Theme.of(context).backgroundColor,
      ),
    );
  }
}
