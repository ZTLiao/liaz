import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/models/db/device_info.dart';
import 'package:uuid/uuid.dart';

class DeviceInfoUtil {
  static final _deviceInfoPlugin = DeviceInfoPlugin();
  static late IosDeviceInfo _iosDeviceInfo;
  static late AndroidDeviceInfo _androidDeviceInfo;

  static Future<DeviceInfo> getDeviceInfo() async {
    String os = Platform.operatingSystem;
    String osVersion = Platform.operatingSystemVersion;
    String model = StrUtil.empty;
    String imei = StrUtil.empty;
    String deviceId = StrUtil.empty;
    if (Platform.isIOS) {
      _iosDeviceInfo = await _deviceInfoPlugin.iosInfo;
      var identifierForVendor = _iosDeviceInfo.identifierForVendor;
      imei = identifierForVendor ?? const Uuid().v4();
      if (_iosDeviceInfo.name.isNotEmpty) {
        model = _iosDeviceInfo.name;
      } else {
        model = _iosDeviceInfo.utsname.machine;
      }
    } else if (Platform.isAndroid) {
      _androidDeviceInfo = await _deviceInfoPlugin.androidInfo;
      imei = _androidDeviceInfo.id;
      model =
          _androidDeviceInfo.board + StrUtil.space + _androidDeviceInfo.model;
    }
    if (imei.isNotEmpty) {
      deviceId = const Uuid().v5(Uuid.NAMESPACE_URL, imei);
    } else {
      deviceId = const Uuid().v4();
    }
    return DeviceInfo(
      os: os,
      osVersion: osVersion,
      model: model,
      imei: imei,
      deviceId: deviceId,
    );
  }
}
