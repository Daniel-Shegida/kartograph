import 'package:get_storage/get_storage.dart';
import 'package:latlng/latlng.dart';

/// Хранилище информации о пользователе
class LastCordsStorage {
  static const _keyLastCords = 'LAST_CORDS';

  final GetStorage _getStorage;

  LastCordsStorage(this._getStorage);

  /// Очистка хранилища,
  Future<void> clearData() async {
    await _getStorage.erase();
  }

  Future<void> saveLastCords(LatLng cords) async {
    await _getStorage.write(_keyLastCords, cords);
  }


  Future<LatLng?> getLastCords() async {
    return _getStorage.read<LatLng>(_keyLastCords);
  }

}
