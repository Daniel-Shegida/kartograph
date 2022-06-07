import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:kartograph/features/place_adding/screen/place_add_screen.dart';
import 'package:kartograph/features/place_adding/screen/place_screen_model.dart';

/// factory for [PlaceAddingScreen]
PlaceAddingWidgetModel placeAddingWidgetModelFactory(BuildContext context) {
  return PlaceAddingWidgetModel(PlaceAddingModel());
}

/// WidgetModel for [PlaceAddingScreen]
class PlaceAddingWidgetModel
    extends WidgetModel<PlaceAddingScreen, PlaceAddingModel>
    with SingleTickerProviderWidgetModelMixin
    implements IPlaceAddingWidgetModel {
  final StateNotifier<bool> _nameState = StateNotifier<bool>();

  final StateNotifier<bool> _describeState = StateNotifier<bool>();

  final StateNotifier<bool> _lonState = StateNotifier<bool>();

  final StateNotifier<bool> _latState = StateNotifier<bool>();

  final StateNotifier<bool> _readyState = StateNotifier<bool>();

  final StateNotifier<String> _currentValue = StateNotifier<String>();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _describeController = TextEditingController();

  final TextEditingController _lonController = TextEditingController();

  final TextEditingController _latController = TextEditingController();

  final List<DropdownMenuItem<String>> _choises = [
    'hotel',
    'restaurant',
    'other',
    'cafe',
    'museum',
    'park',
  ].map<DropdownMenuItem<String>>((value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    );
  }).toList();

  @override
  TextEditingController get nameController => _nameController;

  @override
  TextEditingController get describeController => _describeController;

  @override
  TextEditingController get latController => _latController;

  @override
  TextEditingController get lonController => _lonController;

  @override
  StateNotifier<bool> get describeState => _describeState;

  @override
  StateNotifier<bool> get latState => _latState;

  @override
  StateNotifier<bool> get lonState => _lonState;

  @override
  StateNotifier<bool> get readyState => _readyState;

  @override
  StateNotifier<bool> get nameState => _nameState;

  @override
  List<DropdownMenuItem<String>> get choises => _choises;

  @override
  StateNotifier<String> get currentState => _currentValue;

  /// standard consctructor for elem
  PlaceAddingWidgetModel(PlaceAddingModel model) : super(model);

  @override
  void initWidgetModel() {
    _describeState.accept(false);
    _nameState.accept(false);
    _readyState.accept(false);
    _currentValue.accept('other');
    _nameController.addListener(nameHandle);
    _describeController.addListener(describeHandle);
    _latController.addListener(latHandle);
    _lonController.addListener(lonHandle);

    super.initWidgetModel();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void createPlace() {
    _describeState.accept(true);
  }

  @override
  void changeType(String? newType) {
    _currentValue.accept(newType);
  }

  /// функция для листенера контроллера поля имени
  void nameHandle() {
    if (_nameController.text.isNotEmpty) {
      _nameState.accept(true);
      checkPreparation();
    } else {
      _nameState.accept(false);
    }
  }

  /// функция для листенера контроллера поля описания
  void describeHandle() {
    if (_describeController.text.isNotEmpty) {
      _describeState.accept(true);
      checkPreparation();
    } else {
      _describeState.accept(false);
    }
  }

  /// функция для листенера контроллера поля широты
  void latHandle() {
    if (_latController.text.isNotEmpty &&
        double.tryParse(_latController.text) != null) {
      _latState.accept(true);
      checkPreparation();
    } else {
      _latState.accept(false);
    }
  }

  /// функция для листенера контроллера поля долготы
  void lonHandle() {
    if (double.tryParse(_lonController.text) != null) {
      _lonState.accept(true);
      checkPreparation();
    } else {
      _lonState.accept(false);
    }
  }

  /// функция проверяющая все ли поля заполнены нормально
  void checkPreparation() {
    if (_nameState.value! &&
        _describeState.value! &&
        _latState.value! &&
        _lonState.value!) {
      _readyState.accept(true);
    } else {
      _readyState.accept(false);
    }
  }
}

/// Interface of [PlaceAddingWidgetModel].
abstract class IPlaceAddingWidgetModel extends IWidgetModel {
  /// состояния поля имени
  StateNotifier<bool> get nameState;

  /// состояния поля описания
  StateNotifier<bool> get describeState;

  /// состояния поля широты
  StateNotifier<bool> get latState;

  /// состояния поля долготы
  StateNotifier<bool> get lonState;

  /// состояния кнопки
  StateNotifier<bool> get readyState;

  /// выбронный тип места
  StateNotifier<String> get currentState;

  ///  контроллер поля имени
  TextEditingController get nameController;

  /// контроллер поля описания
  TextEditingController get describeController;

  /// контроллер поля широты
  TextEditingController get latController;

  /// контроллер поля долготы
  TextEditingController get lonController;

  /// список типов мест
  List<DropdownMenuItem<String>> get choises;

  /// метод изменения  типа
  void changeType(String? newType);

  /// метод создания нового места
  void createPlace();
}
