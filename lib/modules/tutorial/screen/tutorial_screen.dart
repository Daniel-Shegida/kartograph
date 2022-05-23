import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

import 'tutorial_screen_wm.dart';

class TutorialScreen extends ElementaryWidget<ITutorialWidgetModel> {
  const TutorialScreen({
    Key? key,
    WidgetModelFactory wmFactory = specialWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(ITutorialWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(

              ),
            ],
          ),
        ),
      ),
      floatingActionButton:  _SendRequestButton(
        onPressed: wm.start,
        iconData: Icons.not_started,
      ),
    );
  }
}

class _SendRequestButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback? onPressed;

  const _SendRequestButton({
    Key? key,
    required this.iconData,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      tooltip: 'start',
      child: Icon(iconData),
    );
  }
}