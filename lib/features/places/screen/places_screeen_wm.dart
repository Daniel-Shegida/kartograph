// Builder for [SpecialWidgetModel]
import 'package:elementary/elementary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kartograph/api/data/place.dart';
import 'package:kartograph/assets/enums/categories.dart';
import 'package:kartograph/features/places/screen/places_screeen_model.dart';
import 'package:kartograph/features/places/screen/places_screen.dart';
import 'package:kartograph/features/places/service/bloc/place_bloc.dart';
import 'package:kartograph/features/places/service/bloc/place_state.dart';

PlacesWidgetModel placesWidgetModelFactory(BuildContext context) {
  return PlacesWidgetModel(PlacesModel(PlaceBloc()));
}

/// WidgetModel for [PlacesScreen]
class PlacesWidgetModel extends WidgetModel<PlacesScreen, PlacesModel>
    with SingleTickerProviderWidgetModelMixin
    implements IPlacesWidgetModel {
  final  _controller = TextEditingController();

  final StateNotifier<List<Place>> _places = StateNotifier<List<Place>>();

  final StateNotifier<bool> _bool = StateNotifier<bool>();

  final List<String> searchParams = [];

  final List<StateNotifier<bool>> _test = List<StateNotifier<bool>>.generate(
    Categories.values.length,
    (index) => StateNotifier<bool>(),
  );

  @override
  TextEditingController get controller => _controller;


  @override
  StateNotifier<List<Place>> get places => _places;

  @override
  StateNotifier<bool> get boola => _bool;

  /// standard consctructor for elem
  PlacesWidgetModel(PlacesModel model) : super(model);

  @override
  void initWidgetModel() {
    model.placeStateStream.listen(_updateState);
    _places.accept([
      Place(
        lng: 2,
        id: 1,
        urls: [],
        name: 'sadasd',
        description: '',
        placeType: Categories.cafe,
        lat: 2,
      ),
    ]);
    _bool.accept(false);
    for (final e in _test) {
      e.accept(false);
    }
    super.initWidgetModel();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void showPicker() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children:
              List<Widget>.generate(Categories.values.length, (int index) {
            return StateNotifierBuilder<bool>(
              listenableState: _test[index],
              builder: (_, value) {
                return CheckboxListTile(
                  title: Text(Categories.values.elementAt(index).categoryName),
                  value: value,
                  onChanged: (bool? value) {
                    _test[index].accept(value);
                    if (value == true) {
                      // ignore: avoid_print
                      print("$value, and index: $index");
                      // ignore: avoid_print
                      print(Categories.values.elementAt(index).name);
                      searchParams.add(Categories.values.elementAt(index).name);
                      _searchPlace(searchParams);
                    } else {
                      searchParams
                          .remove(Categories.values.elementAt(index).name);
                      _searchPlace(searchParams);
                    }
                  },
                  secondary: Icon(
                    Icons.circle,
                    color: Categories.values.elementAt(index).categoryColor,
                  ),
                );
              },
            );
          }),
        );
      },
    );
  }

  void _updateState(BasePlaceState state) {
    if (state is PlaceContentTestState) {
      // ignore: avoid_print
      print("hmm");
      _places.accept(state.list);
    }
  }

  void _loadPlaces(int page) {}

  void _searchPlace(List<String> list) {
    // ignore: avoid_print
    print("wm");
    model.search(list);
  }
}

/// Interface of [PlacesWidgetModel].
abstract class IPlacesWidgetModel extends IWidgetModel {
  /// Text editing controller Main Screen.
  TextEditingController get controller;

  /// показываемые темы
  StateNotifier<List<Place>> get places;

  /// состояния поля долготы
  StateNotifier<bool> get boola;

  /// action of dialog
  void showPicker();
}
