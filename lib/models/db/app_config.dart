import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/models/db/splash_config.dart';

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
  @HiveField(5)
  String downloadApp;
  @HiveField(6)
  SplashConfig splash;

  AppConfig({
    this.fileUrl = StrUtil.empty,
    this.resourceAuthority = false,
    this.shareUrl = StrUtil.empty,
    this.signKey = StrUtil.empty,
    this.publicKey = StrUtil.empty,
    this.downloadApp = StrUtil.empty,
    required this.splash,
  });

  factory AppConfig.fromJson(Map<String, dynamic> json) {
    var fileUrl = json['fileUrl'] ?? StrUtil.empty;
    var resourceAuthority = json['resourceAuthority'] ?? false;
    var shareUrl = json['shareUrl'] ?? StrUtil.empty;
    var signKey = json['signKey'] ?? StrUtil.empty;
    var publicKey = json['publicKey'] ?? StrUtil.empty;
    var downloadApp = json['downloadApp'] ?? StrUtil.empty;
    var splash = SplashConfig();
    if (json['splash'] != null && json['splash'] is Map) {
      splash = SplashConfig.fromJson(json['splash'] as Map<String, dynamic>);
    }
    return AppConfig(
      fileUrl: fileUrl,
      resourceAuthority: resourceAuthority,
      shareUrl: shareUrl,
      signKey: signKey,
      publicKey: publicKey,
      downloadApp: downloadApp,
      splash: splash,
    );
  }

  Map<String, dynamic> toJson() {
    var splashMap = splash.toJson();
    return <String, dynamic>{
      'fileUrl': fileUrl,
      'resourceAuthority': resourceAuthority,
      'shareUrl': shareUrl,
      'signKey': signKey,
      'publicKey': publicKey,
      'downloadApp': downloadApp,
      'splash': splashMap,
    };
  }

  @override
  String toString() {
    return jsonEncode(this);
  }
}
