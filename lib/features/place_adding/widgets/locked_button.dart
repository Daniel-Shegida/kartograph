import 'package:flutter/material.dart';
import 'package:kartograph/assets/colors/colors.dart';
import 'package:kartograph/assets/strings/projectStrings.dart';

/// кнопка, которая блокируется
class LockedButton extends StatelessWidget {
  /// метод кнопки
  final VoidCallback onPressed;

  /// заблокирована ли кнопка
  final bool isReady;

  /// конструктор [LockedButton]
  const LockedButton({
    required this.onPressed,
    required this.isReady,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: MaterialButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        color: ProjectColors.mainGreenColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            Text(
              ProjectStrings.create,
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ],
        ),
        onPressed: isReady ? onPressed : null,
      ),
    );
  }
}
