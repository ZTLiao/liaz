import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:liaz/app/utils/device_info_util.dart';
import 'package:liaz/models/db/device_info.dart';
import 'package:path_provider/path_provider.dart';

class DeviceInfoService extends GetxService {
  static DeviceInfoService get instance => Get.find<DeviceInfoService>();
  late Box<DeviceInfo> deviceInfoBox;

  Future<void> init() async {
    var appDir = await getApplicationSupportDirectory();
    deviceInfoBox = await Hive.openBox(
      "deviceInfo",
      path: appDir.path,
    );
    if (deviceInfoBox.values.toList().isEmpty) {
      putDeviceInfo(await DeviceInfoUtil.getDeviceInfo());
    }
  }

  Future<void> putDeviceInfo(DeviceInfo deviceInfo) async {
    await deviceInfoBox.put(deviceInfo.deviceId, deviceInfo);
  }

  DeviceInfo getDeviceInfo() {
    return deviceInfoBox.values.first;
  }
}
