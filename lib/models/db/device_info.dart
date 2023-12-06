import 'package:hive/hive.dart';

part 'device_info.g.dart';

@HiveField(1)
class DeviceInfo {
  @HiveField(0)
  String deviceId;

  @HiveField(1)
  String os;

  @HiveField(2)
  String osVersion;

  @HiveField(3)
  String model;

  @HiveField(4)
  String imei;

  DeviceInfo({
    required this.deviceId,
    required this.os,
    required this.osVersion,
    required this.model,
    required this.imei,
  });
}
