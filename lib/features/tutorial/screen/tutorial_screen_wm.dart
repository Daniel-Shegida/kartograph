import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:kartograph/features/tutorial/screen/tutorial_screen.dart';
import 'package:kartograph/features/tutorial/screen/tutorial_screen_model.dart';



/// Builder for [TutorialWidgetModel]
TutorialWidgetModel specialWidgetModelFactory(BuildContext context) {
  return TutorialWidgetModel(TutorialModel());
}

/// WidgetModel for [TutorialScreen]
class TutorialWidgetModel extends WidgetModel<TutorialScreen, TutorialModel> with SingleTickerProviderWidgetModelMixin
    implements ITutorialWidgetModel  {

  /// standard consctructor for elem
  TutorialWidgetModel(TutorialModel model) : super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
  }

  @override
  void dispose() {
    super.dispose();
  }
}

/// Interface of [TutorialWidgetModel].
abstract class ITutorialWidgetModel extends IWidgetModel {
}
