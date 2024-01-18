import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:liaz/app/constants/db.dart';
import 'package:liaz/app/utils/device_info_util.dart';
import 'package:liaz/models/db/device_info.dart';
import 'package:path_provider/path_provider.dart';

class DeviceInfoService extends GetxService {
  static DeviceInfoService get instance {
    if (Get.isRegistered<DeviceInfoService>()) {
      return Get.find<DeviceInfoService>();
    }
    return Get.put(DeviceInfoService());
  }

  late Box<DeviceInfo> box;

  Future<void> init() async {
    var appDir = await getApplicationSupportDirectory();
    box = await Hive.openBox(
      Db.deviceInfo,
      path: appDir.path,
    );
    if (box.values.toList().isEmpty) {
      put(await DeviceInfoUtil.getDeviceInfo());
    }
  }

  Future<void> put(DeviceInfo deviceInfo) async {
    await box.put(deviceInfo.deviceId, deviceInfo);
  }

  DeviceInfo get() {
    return box.values.first;
  }
}
