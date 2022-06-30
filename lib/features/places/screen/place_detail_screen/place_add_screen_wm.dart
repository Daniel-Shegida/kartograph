import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:kartograph/api/domain/place.dart';
import 'package:kartograph/assets/enums/categories.dart';
import 'package:kartograph/config/app_config.dart';
import 'package:kartograph/config/environment/environment.dart';
import 'package:kartograph/features/app/di/app_scope.dart';
import 'package:kartograph/features/map/screen/map_adding_screen/map_adding_screen.dart';
import 'package:kartograph/features/places/domain/entity_place.dart';
import 'package:kartograph/features/places/screen/place_detail_screen/place_add_screen.dart';
import 'package:kartograph/features/places/screen/place_detail_screen/place_screen_model.dart';
import 'package:kartograph/features/places/service/bloc/place_bloc.dart';
import 'package:latlng/latlng.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';

/// фабрика создания [PlaceAddingWidgetModel]
PlaceAddingWidgetModel Function(BuildContext context)
    placeAddingWidgetModelFactoryWithParams(EntityPlace place) {
  return (context) {
    return PlaceAddingWidgetModel(
      PlaceAddingModel(
        PlaceBloc(
          context.read<IAppScope>().repository,
        ),
      ),
      place,
    );
  };
}

/// WidgetModel for [PlaceAddingScreen]
class PlaceAddingWidgetModel
    extends WidgetModel<PlaceAddingScreen, PlaceAddingModel>
    with SingleTickerProviderWidgetModelMixin
    implements IPlaceAddingWidgetModel {
  /// сущность места, приходящая из других экранов
  late final EntityPlace entityPlace;

  final StateNotifier<bool> _nameState = StateNotifier<bool>();

  final StateNotifier<bool> _describeState = StateNotifier<bool>();

  final StateNotifier<bool> _lonState = StateNotifier<bool>();

  final StateNotifier<bool> _latState = StateNotifier<bool>();

  final StateNotifier<bool> _readyState = StateNotifier<bool>();

  final StateNotifier<Categories> _categoriesState =
      StateNotifier<Categories>();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _describeController = TextEditingController();

  final TextEditingController _lonController = TextEditingController();

  final TextEditingController _latController = TextEditingController();

  late final bool _isChange;

  final List<DropdownMenuItem<Categories>> _choises =
      Categories.values.map<DropdownMenuItem<Categories>>((value) {
    return DropdownMenuItem<Categories>(
      value: value,
      child: Text(value.categoryName),
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
  List<DropdownMenuItem<Categories>> get choises => _choises;

  @override
  StateNotifier<Categories> get categoriesState => _categoriesState;

  @override
  bool get isChange => _isChange;

  /// standard consctructor for elem
  PlaceAddingWidgetModel(PlaceAddingModel model, this.entityPlace)
      : super(model);

  @override
  void initWidgetModel() {
    _setStartingStates();
    _setControllers();
    if (entityPlace.id != null) {
      _isChange = true;
      _categoriesState.accept(entityPlace.placeType);
      _nameController.text = entityPlace.name!;
      _describeController.text = entityPlace.description!;
    } else {
      _isChange = false;
    }
    _latController.text = entityPlace.lat.toString();
    _lonController.text = entityPlace.lng.toString();
    super.initWidgetModel();
  }

  @override
  void dispose() {
    _nameState.dispose();
    _describeState.dispose();
    _readyState.dispose();
    _latState.dispose();
    _lonState.accept(false);
    _categoriesState.dispose();
    _nameController.dispose();
    _describeController.dispose();
    _latController.dispose();
    _lonController.dispose();
    super.dispose();
  }

  @override
  Future<void> moveToMap() async {
    // ignore: omit_local_variable_types
    final LatLng? result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapAddingScreen(
          coordinates: LatLng(
            double.tryParse(_latController.text) ??
                Environment<AppConfig>.instance().config.lat,
            double.tryParse(_lonController.text) ??
                Environment<AppConfig>.instance().config.lng,
          ),
        ),
      ),
    );
    if (result != null) {
      _latController.text = result.latitude.toString();
      _lonController.text = result.longitude.toString();
    }
  }

  @override
  void pop() {
    Routemaster.of(context).pop();
  }

  @override
  void createPlace() {
    if (entityPlace.id != null) {
      model.putPlace(
        Place(
          placeType: _categoriesState.value!,
          id: entityPlace.id!,
          name: _nameController.text,
          description: _describeController.text,
          lat: double.parse(_latController.text),
          lng: double.parse(_lonController.text),
          urls: [],
        ),
      );
    } else {
      model.postPlace(
        Place(
          placeType: _categoriesState.value ?? Categories.other,
          name: _nameController.text,
          description: _describeController.text,
          lat: double.parse(_latController.text),
          lng: double.parse(_lonController.text),
          id: 0,
          urls: [],
        ),
      );
    }
    Routemaster.of(context).pop();
  }

  @override
  void changeType(Categories? newType) {
    _categoriesState.accept(newType);
  }

  /// функция для листенера контроллера поля имени
  void _nameHandle() {
    if (_nameController.text.isNotEmpty) {
      _nameState.accept(true);
      _checkPreparation();
    } else {
      _nameState.accept(false);
    }
  }

  /// функция для листенера контроллера поля описания
  void _describeHandle() {
    if (_describeController.text.isNotEmpty) {
      _describeState.accept(true);
      _checkPreparation();
    } else {
      _describeState.accept(false);
    }
  }

  /// функция для листенера контроллера поля широты
  void _latHandle() {
    if (_latController.text.isNotEmpty &&
        double.tryParse(_latController.text) != null) {
      _latState.accept(true);
      _checkPreparation();
    } else {
      _latState.accept(false);
    }
  }

  /// функция для листенера контроллера поля долготы
  void _lonHandle() {
    if (double.tryParse(_lonController.text) != null) {
      _lonState.accept(true);
      _checkPreparation();
    } else {
      _lonState.accept(false);
    }
  }

  void _checkPreparation() {
    if (_nameState.value! &&
        _describeState.value! &&
        _latState.value! &&
        _lonState.value!) {
      _readyState.accept(true);
    } else {
      _readyState.accept(false);
    }
  }

  /// функция проверяющая все ли поля заполнены нормально
  void _setStartingStates() {
    _nameState.accept(false);
    _describeState.accept(false);
    _readyState.accept(false);
    _latState.accept(false);
    _lonState.accept(false);
    _categoriesState.accept(Categories.other);
  }

  /// функция проверяющая все ли поля заполнены нормально
  void _setControllers() {
    _nameController.addListener(_nameHandle);
    _describeController.addListener(_describeHandle);
    _latController.addListener(_latHandle);
    _lonController.addListener(_lonHandle);
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
  StateNotifier<Categories> get categoriesState;

  ///  контроллер поля имени
  TextEditingController get nameController;

  /// контроллер поля описания
  TextEditingController get describeController;

  /// контроллер поля широты
  TextEditingController get latController;

  /// контроллер поля долготы
  TextEditingController get lonController;

  /// список типов мест
  List<DropdownMenuItem<Categories>> get choises;

  /// изменять или создавать новое место
  bool get isChange;

  /// метод изменения  типа
  void changeType(Categories? newType);

  /// метод перехода на карту
  void moveToMap();

  /// метод закрытия экрана
  void pop();

  /// метод создания нового места
  void createPlace();
}
