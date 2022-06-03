import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartograph/features/map/service/map_event.dart';
import 'package:kartograph/features/map/service/map_state.dart';

/// Bloc for working with profile states.
class MapBloc extends Bloc<BaseMapEvent, BaseMapState> {
  /// Constructor of [MapBloc]
  MapBloc() : super(MapContentState()) {
    /// при событии загрузки статей запускаем стейт со статьями
    on<MapLoadEvent>((event, emit) async {
      try {} catch (_) {
      }
    });
  }
}
