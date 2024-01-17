import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:liaz/app/constants/db.dart';
import 'package:liaz/app/logger/log.dart';
import 'package:path_provider/path_provider.dart';

class LocalStorageService extends GetxService {
  static LocalStorageService get instance => Get.find<LocalStorageService>();

  late Box box;

  Future init() async {
    var dir = await getApplicationSupportDirectory();
    box = await Hive.openBox(
      Db.localStorage,
      path: dir.path,
    );
  }

  T getValue<T>(dynamic key, T defaultValue) {
    var value = box.get(key, defaultValue: defaultValue) as T;
    Log.d("Get LocalStorage：$key\r\n$value");
    return value;
  }

  Future setValue<T>(dynamic key, T value) async {
    Log.d("Set LocalStorage：$key\r\n$value");
    return await box.put(key, value);
  }

  Future removeValue<T>(dynamic key) async {
    Log.d("Remove LocalStorage：$key");
    return await box.delete(key);
  }
}
