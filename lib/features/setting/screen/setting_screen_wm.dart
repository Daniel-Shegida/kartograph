import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:kartograph/features/setting/screen/setting_screen.dart';
import 'package:kartograph/features/setting/screen/setting_screen_model.dart';


/// Builder for [SettingWidgetModel]
SettingWidgetModel settingWidgetModelFactory(BuildContext context) {
  return SettingWidgetModel(SettingModel());
}

/// WidgetModel for [SettingScreen]
class SettingWidgetModel extends WidgetModel<SettingScreen, SettingModel> with SingleTickerProviderWidgetModelMixin
    implements ISettingWidgetModel  {

  /// standard consctructor for elem
  SettingWidgetModel(SettingModel model) : super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
  }

  @override
  void dispose() {
    super.dispose();
  }
}

/// Interface of [SettingWidgetModel].
abstract class ISettingWidgetModel extends IWidgetModel {
}
