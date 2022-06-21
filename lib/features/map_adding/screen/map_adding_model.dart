import 'package:elementary/elementary.dart';
import 'package:kartograph/features/map/service/map_bloc.dart';
import 'package:kartograph/features/map/service/map_event.dart';
import 'package:kartograph/features/map/service/map_state.dart';

/// модель SpecialWidgetModel
class MapAddingModel extends ElementaryModel {

  /// блок работающий с состояниями карты.
  final MapBloc _mapBloc;

  /// поток отслеживающий состояния из блока
  Stream<BaseMapState> get mapStateStream => _mapBloc.stream;

  /// получение текущего потока.
  BaseMapState get currentState => _mapBloc.state;

  /// стандартный конструктор.
  MapAddingModel(
    this._mapBloc,
  ) : super();

  @override
  void init() {
    super.init();
    _mapBloc.add(MapGetLocationEvent());
  }

  /// метод, который отправляет ивент получения информации о карте в [MapBloc].
  void getCurrentLocation() {
    _mapBloc.add(
      MapGetLocationEvent(),
    );
  }
}
