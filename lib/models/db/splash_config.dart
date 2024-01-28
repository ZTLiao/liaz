import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:liaz/app/enums/skip_type_enum.dart';
import 'package:liaz/app/utils/str_util.dart';

part 'splash_config.g.dart';

@HiveType(typeId: 12)
class SplashConfig {
  @HiveField(0)
  bool enabled;
  @HiveField(1)
  String cover;
  @HiveField(2)
  int skipType;
  @HiveField(3)
  String skipValue;
  @HiveField(4)
  int duration;

  SplashConfig({
    this.enabled = false,
    this.cover = StrUtil.empty,
    this.skipType = 0,
    this.skipValue = StrUtil.empty,
    this.duration = 3000,
  });

  factory SplashConfig.fromJson(Map<String, dynamic> json) {
    var enabled = json['enabled'] ?? false;
    var cover = json['cover'] ?? StrUtil.empty;
    var skipType = json['skipType'] ?? SkipTypeEnum.h5.index;
    var skipValue = json['skipValue'] ?? StrUtil.empty;
    var duration = json['duration'] ?? 3000;
    return SplashConfig(
      enabled: enabled,
      cover: cover,
      skipType: skipType,
      skipValue: skipValue,
      duration: duration,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'enabled': enabled,
        'cover': cover,
        'skipType': skipType,
        'skipValue': skipValue,
        'duration': duration,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
