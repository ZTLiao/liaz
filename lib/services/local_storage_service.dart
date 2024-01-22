import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:liaz/app/constants/db.dart';
import 'package:liaz/app/logger/log.dart';
import 'package:path_provider/path_provider.dart';

class LocalStorageService extends GetxService {
  static LocalStorageService get instance {
    if (Get.isRegistered<LocalStorageService>()) {
      return Get.find<LocalStorageService>();
    }
    return Get.put(LocalStorageService());
  }

  Box<dynamic>? box;

  Future<void> init() async {
    if (box == null) {
      var dir = await getApplicationSupportDirectory();
      box = await Hive.openBox(
        Db.localStorage,
        path: dir.path,
      );
    }
  }

  T getValue<T>(dynamic key, T defaultValue) {
    var value = box!.get(key, defaultValue: defaultValue) as T;
    Log.d("Get LocalStorage：$key\r\n$value");
    return value;
  }

  Future<dynamic> setValue<T>(dynamic key, T value) async {
    Log.d("Set LocalStorage：$key\r\n$value");
    return await box!.put(key, value);
  }

  Future<void> removeValue<T>(dynamic key) async {
    Log.d("Remove LocalStorage：$key");
    return await box!.delete(key);
  }
}
