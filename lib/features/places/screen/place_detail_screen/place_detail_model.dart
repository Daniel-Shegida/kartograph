import 'package:elementary/elementary.dart';
import 'package:kartograph/api/domain/place.dart';
import 'package:kartograph/features/places/service/bloc/place_bloc.dart';
import 'package:kartograph/features/places/service/bloc/place_event.dart';
import 'package:kartograph/features/places/service/bloc/place_state.dart';

/// модель PlaceAddingWidgetModel
class PlaceDetailModel extends ElementaryModel {
  /// Блок с которого получают состояния.
  final PlaceBloc _placeBloc;

  /// Подписка на блок.
  Stream<BasePlaceState> get placeStateStream => _placeBloc.stream;

  /// Получает стейт из блока.
  BasePlaceState get currentState => _placeBloc.state;

  /// конструктор[PlaceDetailModel]
  PlaceDetailModel(this._placeBloc);

  /// метод для создания места.
  void postPlace(Place place) {
    _placeBloc.add(
      PlacePostEvent(
        place: place,
      ),
    );
  }

  /// метод для изменения места.
  void putPlace(Place place) {
    _placeBloc.add(
      PlacePutEvent(
        place: place,
      ),
    );
  }
}
