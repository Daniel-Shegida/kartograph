import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartograph/api/domain/place_response.dart';
import 'package:kartograph/features/places/service/bloc/place_event.dart';
import 'package:kartograph/features/places/service/bloc/place_state.dart';
import 'package:kartograph/api/service/place_rep/place_rep.dart';

/// Bloc for working with profile states.
class PlaceBloc extends Bloc<BasePlaceEvent, BasePlaceState> {
  late final PlaceRepository _rep;

  /// Constructor of [PlaceBloc]
  PlaceBloc(this._rep) : super(InitPlaceContentState()) {
    on<PlaceSearchEvent>((event, emit) async {
      final list = await _rep.getSearchedPlaces(
        /// TODO посмотреть возможность добавления координат при связывании приложения
        60,
        30,
        3000000.0,
        event.searchingTypeList,
        event.search,
      );
      emit(PlaceContentState(list: list));
    });

    on<PlacePostEvent>((event, emit) async {
      // для создания уникального id который был бы еще и положительным
      final id = ((event.place.lng + event.place.lat) * 1000000).toInt().abs();
      await _rep.postPlace(
        PlaceResponse(
          id: id,
          name: event.place.name,
          description: event.place.description,
          placeType: event.place.placeType.name,
          urls: [],
          lng: event.place.lng,
          lat: event.place.lat,
        ),
      );
    });

    on<PlacePutEvent>((event, emit) async {
      await _rep.putPlace(
        event.place.id.toString(),
        PlaceResponse(
          id: event.place.id,
          name: event.place.name,
          description: event.place.description,
          placeType: event.place.placeType.name,
          urls: [],
          lng: event.place.lng,
          lat: event.place.lat,
        ),
      );
    });
  }
}
