import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:kartograph/features/tutorial/screen/tutorial_screen_wm.dart';


class TutorialScreen extends ElementaryWidget<ITutorialWidgetModel> {

  /// standard consctructor for elem
  const TutorialScreen({
    Key? key,
    WidgetModelFactory wmFactory = specialWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(ITutorialWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
      ),
    );
  }
}