import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:liaz/app/utils/convert_util.dart';

part 'app_config.g.dart';

@HiveField(2)
class AppConfig {
  @HiveField(0)
  String fileUrl;
  @HiveField(1)
  bool resourceAuthority;

  AppConfig({
    required this.fileUrl,
    required this.resourceAuthority,
  });

  factory AppConfig.fromJson(Map<String, dynamic> json) => AppConfig(
        fileUrl: ConvertUtil.asT<String>(json['fileUrl'])!,
        resourceAuthority: ConvertUtil.asT<bool>(json['resourceAuthority'])!,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'fileUrl': fileUrl,
        'resourceAuthority': resourceAuthority,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
