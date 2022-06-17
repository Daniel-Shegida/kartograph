import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartograph/features/places/place_api/place_api.dart';
import 'package:kartograph/features/places/service/bloc/place_event.dart';
import 'package:kartograph/features/places/service/bloc/place_state.dart';
import 'package:kartograph/features/places/service/place_rep.dart';

/// Bloc for working with profile states.
class PlaceBloc extends Bloc<BasePlaceEvent, BasePlaceState> {
  final PlaceRepository _rep = PlaceRepository(
    RestClient(
      Dio(),
    ),
  );

  /// Constructor of [PlaceBloc]
  PlaceBloc() : super(InitPlaceContentState()) {
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
  }
}
