import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartograph/features/places/place_api/place_api.dart';
import 'package:kartograph/features/places/service/bloc/place_event.dart';
import 'package:kartograph/features/places/service/bloc/place_state.dart';
import 'package:kartograph/features/places/service/place_rep.dart';

/// Bloc for working with profile states.
class PlaceBloc extends Bloc<BasePlaceEvent, BasePlaceState> {
  /// Constructor of [PlaceBloc]
  PlaceBloc() : super(PlaceContentState()) {
    /// при событии загрузки статей запускаем стейт со статьями
    on<PlaceLoadEvent>((event, emit) async {
      _rep.getPlaces(15);
      emit(PlaceContentState());
    });

    on<PlaceSearchEvent>((event, emit) async {
      final list = await _rep.getSearchedPlaces(60, 30, 3000000.0, event.list,"" );
      emit(PlaceContentTestState(list: list));
    });
  }

  final PlaceRepository _rep = PlaceRepository(
    RestClient(
      Dio(),
    ),
  );
}
