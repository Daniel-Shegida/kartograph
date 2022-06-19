import 'dart:async';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:kartograph/api/data/place.dart';
import 'package:kartograph/features/navigation/domain/entity/app_route_paths.dart';
import 'package:kartograph/features/places/domain/types_to_show.dart';
import 'package:kartograph/features/places/screen/places_screeen_model.dart';
import 'package:kartograph/features/places/screen/places_screen.dart';
import 'package:kartograph/features/places/service/bloc/place_bloc.dart';
import 'package:kartograph/features/places/service/bloc/place_state.dart';
import 'package:kartograph/features/places/widgets/places_choise_dialog.dart';
import 'package:routemaster/routemaster.dart';

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

  final StateNotifier<ListPlacesToShow> _checkBoxNotifier =
      StateNotifier<ListPlacesToShow>();

  @override
  TextEditingController get controller => _controller;

  @override
  EntityStateNotifier<List<Place>> get placesListState => _placesListState;

  late StreamSubscription _blocSubscription;

  /// standard consctructor for elem
  PlacesWidgetModel(PlacesModel model) : super(model);

  @override
  void initWidgetModel() {
    _blocSubscription = model.placeStateStream.listen(_updateState);
    placesListState.loading();
    controller.addListener(_searchPlace);
    _checkBoxNotifier.accept(ListPlacesToShow.createStandard());
    for (final e in _checkBoxNotifier.value!.listCategoriesToShow) {
      _searchParams.add(e.category.name);
    }
    _searchPlace();
    super.initWidgetModel();
  }

  @override
  void dispose() {
    _controller.dispose();
    _placesListState.dispose();
    _checkBoxNotifier.dispose();
    _blocSubscription.cancel();
    super.dispose();
  }

  @override
  void showPicker() {
    showModalBottomSheet<void>(
      context: context,
      builder: (_) {
        return PlacesChoiseDialogWidget(
          statesList: _checkBoxNotifier,
          onChanged: _changeSearchTypes,
        );
      },
    );
  }

  @override
  void navigateToPlaceDetails(Place place) {
    // ignore: avoid_print
    print("da");
    Routemaster.of(context).push('/Rest', queryParameters: {
      'category': place.placeType.name,
      'name': place.name,
      'description': place.description,
      'lat': place.lat.toString(),
      'lng': place.lng.toString(),
    });
    // Routemaster.of(context).push('${AppRoutePaths.tabs}/test',);
    // Routemaster.of(context).push('/MapAdding');
  }

  void _updateState(BasePlaceState state) {
    if (state is PlaceContentState) {
      _placesListState.content(state.list);
    }
  }

  void _searchPlace() {
    // ignore: avoid_print
    print('_searchPlace');
    // ignore: avoid_print
    print(_searchParams);
    // ignore: avoid_print
    print(controller.text);
    model.search(_searchParams, controller.text);
  }

  void _changeSearchTypes(bool? isSearched, int index) {
    if (isSearched ?? false) {
      _searchParams.add(
        _checkBoxNotifier.value!.listCategoriesToShow[index].category.name,
      );
    } else {
      _searchParams.remove(
        _checkBoxNotifier.value!.listCategoriesToShow[index].category.name,
      );
    }
    _checkBoxNotifier.accept(_checkBoxNotifier.value!
        .copyWith(indexToChange: index, valueToChange: isSearched!));

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

  /// action of navigate to a place on card
  void navigateToPlaceDetails(Place place);
}
