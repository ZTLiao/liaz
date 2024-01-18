import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:liaz/app/utils/convert_util.dart';
import 'package:liaz/app/utils/str_util.dart';

part 'app_config.g.dart';

@HiveType(typeId: 2)
class AppConfig {
  @HiveField(0)
  String fileUrl;
  @HiveField(1)
  bool resourceAuthority;
  @HiveField(2)
  String shareUrl;
  @HiveField(3)
  String signKey;
  @HiveField(4)
  String publicKey;

  AppConfig({
    this.fileUrl = StrUtil.empty,
    this.resourceAuthority = false,
    this.shareUrl = StrUtil.empty,
    this.signKey = StrUtil.empty,
    this.publicKey = StrUtil.empty,
  });

  factory AppConfig.fromJson(Map<String, dynamic> json) {
    var fileUrl = json['fileUrl'] ?? StrUtil.empty;
    var resourceAuthority = json['resourceAuthority'] ?? false;
    var shareUrl = json['shareUrl'] ?? StrUtil.empty;
    var signKey = json['signKey'] ?? StrUtil.empty;
    var publicKey = json['publicKey'] ?? StrUtil.empty;
    return AppConfig(
      fileUrl: fileUrl,
      resourceAuthority: resourceAuthority,
      shareUrl: shareUrl,
      signKey: signKey,
      publicKey: publicKey,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'fileUrl': fileUrl,
        'resourceAuthority': resourceAuthority,
        'shareUrl': shareUrl,
        'signKey': signKey,
        'publicKey': publicKey,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
