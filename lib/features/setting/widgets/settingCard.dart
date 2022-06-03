import 'package:flutter/material.dart';

class IconCardWidget extends StatelessWidget {
  final String cardName;
  final Color? iconColor;
  final bool? switchFlag;
  final Function(bool)? switchFun;
  final VoidCallback onTap;

  const IconCardWidget({
    Key? key,
    required this.icon,
    this.cardName = '',
    this.cardExtraName,
    this.textColor = Colors.black,
    this.iconColor = ProjectColors.primaryColor,
    required this.onTap,
    this.switchFlag,
    this.switchFun,
  }) : super(key: key);

  const IconCardWidget.withSwitch({
    Key? key,
    required this.icon,
    required this.cardName,
    this.cardExtraName,
    this.textColor = Colors.black,
    this.iconColor = ProjectColors.primaryColor,
    required this.onTap,
    required this.switchFlag,
    required this.switchFun,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(
              icon,
              size: 24,
              color: iconColor,
            ),
            const SizedBox(
              width: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cardName,
                  style: TextStyle(color: textColor),
                ),
                if (cardExtraName != null) ...[
                  Text(
                    cardExtraName!,
                    style: const TextStyle(color: ProjectColors.disabledColor),
                  ),
                ],
              ],
            ),
            const Spacer(),
            if (switchFlag != null)
              Switch(value: switchFlag!, onChanged: switchFun!),
          ],
        ),
      ),
    );
  }
}