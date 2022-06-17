import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:kartograph/api/data/place.dart';
import 'package:kartograph/assets/enums/categories.dart';
import 'package:kartograph/features/places/screen/places_screeen_model.dart';
import 'package:kartograph/features/places/screen/places_screen.dart';
import 'package:kartograph/features/places/service/bloc/place_bloc.dart';
import 'package:kartograph/features/places/service/bloc/place_state.dart';
import 'package:kartograph/features/places/widgets/places_choise_dialog.dart';

/// Factory for [PlacesWidgetModel]
PlacesWidgetModel placesWidgetModelFactory(BuildContext context) {
  return PlacesWidgetModel(PlacesModel(PlaceBloc()));
}

/// WidgetModel for [PlacesScreen]
class PlacesWidgetModel extends WidgetModel<PlacesScreen, PlacesModel>
    with SingleTickerProviderWidgetModelMixin
    implements IPlacesWidgetModel {
  final _controller = TextEditingController();

  final EntityStateNotifier<List<Place>> _placesListState =
      EntityStateNotifier<List<Place>>();

  final List<String> _searchParams = [];

  final List<StateNotifier<bool>> _checkBoxNotifier =
      List<StateNotifier<bool>>.generate(
    Categories.values.length,
    (index) => StateNotifier<bool>(),
  );

  @override
  TextEditingController get controller => _controller;

  @override
  EntityStateNotifier<List<Place>> get placesListState => _placesListState;

  /// standard consctructor for elem
  PlacesWidgetModel(PlacesModel model) : super(model);

  @override
  void initWidgetModel() {
    model.placeStateStream.listen(_updateState);
    placesListState.loading();
    controller.addListener(_searchPlace);
    for (var i = 0; i < _checkBoxNotifier.length; i++) {
      _checkBoxNotifier[i].accept(true);
      _searchParams.add(Categories.values.elementAt(i).name);
    }
    _searchPlace();
    super.initWidgetModel();
  }

  @override
  void dispose() {
    _controller.dispose();
    _placesListState.dispose();
    for (final e in _checkBoxNotifier) {
      e.dispose();
    }
    super.dispose();
  }

  @override
  void showPicker() {
    showModalBottomSheet<void>(
      context: context,
      builder: (_) {
        return PlacesChoiseDialogWidget(statesList: _checkBoxNotifier, onChanged: _changeSearchTypes,);
      },
    );
  }

  void _updateState(BasePlaceState state) {
    if (state is PlaceContentState) {
      _placesListState.content(state.list);
    }
  }

  void _searchPlace() {
    model.search(_searchParams, controller.text);
  }

  void _changeSearchTypes(bool? isSearched, int index) {
    _checkBoxNotifier[index].accept(isSearched);
    if (isSearched ?? false) {
      _searchParams.add(Categories.values.elementAt(index).name);
    } else {
      _searchParams.remove(Categories.values.elementAt(index).name);
    }
    _searchPlace();
  }
}

/// Interface of [PlacesWidgetModel].
abstract class IPlacesWidgetModel extends IWidgetModel {
  /// Text editing controller Main Screen.
  TextEditingController get controller;

  /// показываемые темы
  EntityStateNotifier<List<Place>> get placesListState;

  /// action of dialog
  void showPicker();
}
