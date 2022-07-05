import 'package:get_storage/get_storage.dart';
import 'package:latlng/latlng.dart';

/// Хранилище информации о пользователе
class LastCordsStorage {
  static const _keyLastCords = 'LAST_CORDS';

  final GetStorage _getStorage;

  /// Стандартный иницилизатор [LastCordsStorage]
  LastCordsStorage(this._getStorage);

  /// Очистка хранилища,
  Future<void> clearData() async {
    await _getStorage.erase();
  }

  /// сохраняет последние полученные координаты
  Future<void> saveLastCords(LatLng cords) async {
    await _getStorage.write(_keyLastCords, cords);
  }

  /// удаляет последние полученные координаты
  Future<LatLng?> getLastCords() async {
    return _getStorage.read<LatLng>(_keyLastCords);
  }
}
