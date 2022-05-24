import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:kartograph/features/splash/screen/splash_screen.dart';
import 'package:kartograph/features/splash/screen/splash_screen_model.dart';


/// Builder for [SplashWidgetModel]
SplashWidgetModel specialWidgetModelFactory(BuildContext context) {
  return SplashWidgetModel(SplashModel());
}

/// WidgetModel for [SplashScreen]
class SplashWidgetModel extends WidgetModel<SplashScreen, SplashModel> with SingleTickerProviderWidgetModelMixin
    implements ISplashWidgetModel  {

  /// standard consctructor for elem
  SplashWidgetModel(SplashModel model) : super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
  }

  @override
  void dispose() {
    super.dispose();
  }
}

/// Interface of [SplashWidgetModel].
abstract class ISplashWidgetModel extends IWidgetModel {
}