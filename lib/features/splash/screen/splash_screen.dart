import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:kartograph/features/splash/screen/splash_screen_wm.dart';

class SplashScreen extends ElementaryWidget<ISplashWidgetModel> {
  /// standard consctructor for elem
  const SplashScreen({
    Key? key,
    WidgetModelFactory wmFactory = specialWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(ISplashWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(),
    );
  }
}
