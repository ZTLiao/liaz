import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:liaz/app/utils/convert_util.dart';

part 'app_config.g.dart';

@HiveType(typeId: 2)
class AppConfig {
  @HiveField(0)
  String fileUrl;
  @HiveField(1)
  bool resourceAuthority;
  @HiveField(2)
  String shareUrl;

  AppConfig({
    required this.fileUrl,
    required this.resourceAuthority,
    required this.shareUrl,
  });

  factory AppConfig.fromJson(Map<String, dynamic> json) => AppConfig(
        fileUrl: ConvertUtil.asT<String>(json['fileUrl'])!,
        resourceAuthority: ConvertUtil.asT<bool>(json['resourceAuthority'])!,
        shareUrl: ConvertUtil.asT<String>(json['shareUrl'])!,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'fileUrl': fileUrl,
        'resourceAuthority': resourceAuthority,
        'shareUrl': shareUrl,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
