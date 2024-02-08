import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:liaz/app/utils/str_util.dart';

part 'ads_config.g.dart';

@HiveType(typeId: 13)
class AdsConfig {
  @HiveField(0)
  bool enabled;
  @HiveField(1)
  int adsType;
  @HiveField(2)
  int adsFlag;
  @HiveField(3)
  String appId;
  @HiveField(4)
  String appName;
  @HiveField(5)
  String splashCodeId;
  @HiveField(6)
  String bannerCodeId;
  @HiveField(7)
  String nativeCodeId;
  @HiveField(8)
  String rewardCodeId;
  @HiveField(9)
  String drawCodeId;
  @HiveField(10)
  String screenCodeId;
  @HiveField(11)
  String detailBannerCodeId;
  @HiveField(12)
  String readBannerCodeId;
  @HiveField(13)
  String bottomBannerCodeId;

  AdsConfig({
    this.enabled = false,
    this.adsType = 0,
    this.adsFlag = 0,
    this.appId = StrUtil.empty,
    this.appName = StrUtil.empty,
    this.splashCodeId = StrUtil.empty,
    this.bannerCodeId = StrUtil.empty,
    this.nativeCodeId = StrUtil.empty,
    this.rewardCodeId = StrUtil.empty,
    this.drawCodeId = StrUtil.empty,
    this.screenCodeId = StrUtil.empty,
    this.detailBannerCodeId = StrUtil.empty,
    this.readBannerCodeId = StrUtil.empty,
    this.bottomBannerCodeId = StrUtil.empty,
  });

  factory AdsConfig.fromJson(Map<String, dynamic> json) {
    var enabled = json['enabled'] ?? false;
    var adsType = json['adsType'] ?? 0;
    var adsFlag = json['adsFlag'] ?? 0;
    var appId = json['appId'] ?? StrUtil.empty;
    var appName = json['appName'] ?? StrUtil.empty;
    var splashCodeId = json['splashCodeId'] ?? StrUtil.empty;
    var bannerCodeId = json['bannerCodeId'] ?? StrUtil.empty;
    var nativeCodeId = json['nativeCodeId'] ?? StrUtil.empty;
    var rewardCodeId = json['rewardCodeId'] ?? StrUtil.empty;
    var drawCodeId = json['drawCodeId'] ?? StrUtil.empty;
    var screenCodeId = json['screenCodeId'] ?? StrUtil.empty;
    var detailBannerCodeId = json['detailBannerCodeId'] ?? StrUtil.empty;
    var readBannerCodeId = json['readBannerCodeId'] ?? StrUtil.empty;
    var bottomBannerCodeId = json['bottomBannerCodeId'] ?? StrUtil.empty;
    return AdsConfig(
      enabled: enabled,
      adsType: adsType,
      adsFlag: adsFlag,
      appId: appId,
      appName: appName,
      splashCodeId: splashCodeId,
      bannerCodeId: bannerCodeId,
      nativeCodeId: nativeCodeId,
      rewardCodeId: rewardCodeId,
      drawCodeId: drawCodeId,
      screenCodeId: screenCodeId,
      detailBannerCodeId: detailBannerCodeId,
      readBannerCodeId: readBannerCodeId,
      bottomBannerCodeId: bottomBannerCodeId,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'enabled': enabled,
        'adsType': adsType,
        'adsFlag': adsFlag,
        'appId': appId,
        'appName': appName,
        'splashCodeId': splashCodeId,
        'bannerCodeId': bannerCodeId,
        'nativeCodeId': nativeCodeId,
        'rewardCodeId': rewardCodeId,
        'drawCodeId': drawCodeId,
        'screenCodeId': screenCodeId,
        'detailBannerCodeId': detailBannerCodeId,
        'readBannerCodeId': readBannerCodeId,
        'bottomBannerCodeId': bottomBannerCodeId,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
