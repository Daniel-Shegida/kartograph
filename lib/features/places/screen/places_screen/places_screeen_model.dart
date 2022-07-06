import 'package:elementary/elementary.dart';
import 'package:kartograph/features/places/service/bloc/place_bloc.dart';
import 'package:kartograph/features/places/service/bloc/place_event.dart';
import 'package:kartograph/features/places/service/bloc/place_state.dart';

/// Модель экрана мест
class PlacesModel extends ElementaryModel {
  /// Блок с которого получают состояния.
  final PlaceBloc _placeBloc;

  /// Подписка на блок.
  Stream<BasePlaceState> get placeStateStream => _placeBloc.stream;

  /// Получает стейт из блока.
  BasePlaceState get currentState => _placeBloc.state;

  /// Конструктор [PlacesModel].
  PlacesModel(
    this._placeBloc,
  ) : super();

  /// закрытие потоков
  @override
  void dispose() {
    _placeBloc.close();
    super.dispose();
  }

  /// получить список мест с параметрами поиска
  void search(List<String> searchingTypeList, String search) {
    _placeBloc.add(
        PlaceSearchEvent(searchingTypeList: searchingTypeList, search: search));
  }
}
