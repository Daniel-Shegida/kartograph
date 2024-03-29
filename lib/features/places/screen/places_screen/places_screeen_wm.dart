import 'dart:async';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:kartograph/api/domain/place.dart';
import 'package:kartograph/features/app/di/app_scope.dart';
import 'package:kartograph/features/navigation/utils/navigation_helper.dart';
import 'package:kartograph/features/places/domain/types_to_show.dart';
import 'package:kartograph/features/places/screen/places_screen/places_screeen_model.dart';
import 'package:kartograph/features/places/screen/places_screen/places_screen.dart';
import 'package:kartograph/features/places/service/bloc/place_bloc.dart';
import 'package:kartograph/features/places/service/bloc/place_state.dart';
import 'package:kartograph/features/places/widgets/places_choise_dialog.dart';
import 'package:provider/provider.dart';

/// Factory for [PlacesWidgetModel]
PlacesWidgetModel placesWidgetModelFactory(BuildContext context) {
  return PlacesWidgetModel(
    PlacesModel(
      PlaceBloc(
        context.read<IAppScope>().repository,
      ),
    ),
    context.read<IAppScope>().navigationHelper,
  );
}

/// WidgetModel for [PlacesScreen]
class PlacesWidgetModel extends WidgetModel<PlacesScreen, PlacesModel>
    with SingleTickerProviderWidgetModelMixin
    implements IPlacesWidgetModel {
  late final NavigationHelper _navigationHelper;

  final _controller = TextEditingController();

  final EntityStateNotifier<List<Place>> _placesListState =
      EntityStateNotifier<List<Place>>();

  final List<String> _searchParams = [];

  final StateNotifier<PlaceFiltersList> _checkBoxNotifier =
      StateNotifier<PlaceFiltersList>();

  @override
  TextEditingController get controller => _controller;

  @override
  ListenableState<EntityState<List<Place>>> get placesListState =>
      _placesListState;

  late StreamSubscription _blocSubscription;

  /// standard consctructor for elem
  PlacesWidgetModel(
    PlacesModel model,
    this._navigationHelper,
  ) : super(model);

  @override
  void initWidgetModel() {
    _blocSubscription = model.placeStateStream.listen(_updateState);
    _placesListState.loading();
    controller.addListener(_searchPlace);
    _checkBoxNotifier.accept(PlaceFiltersList.init());
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
    _navigationHelper.moveToPlaceDetailScreen(place, context);
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
  ListenableState<EntityState<List<Place>>> get placesListState;

  /// action of dialog
  void showPicker();

  /// action of navigate to a place on card
  void navigateToPlaceDetails(Place place);
}
