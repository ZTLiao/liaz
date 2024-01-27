import 'dart:convert';

import 'package:liaz/app/utils/convert_util.dart';

class AppVersionModel {
  int versionId;
  String os;
  String appVersion;
  String channel;
  String description;
  String downloadLink;
  String fileMd5;
  int createdAt;

  AppVersionModel({
    required this.versionId,
    required this.os,
    required this.appVersion,
    required this.channel,
    required this.description,
    required this.downloadLink,
    required this.fileMd5,
    required this.createdAt,
  });

  factory AppVersionModel.fromJson(Map<String, dynamic> json) =>
      AppVersionModel(
        versionId: ConvertUtil.asT<int>(json['objId'])!,
        os: ConvertUtil.asT<String>(json['os'])!,
        appVersion: ConvertUtil.asT<String>(json['appVersion'])!,
        channel: ConvertUtil.asT<String>(json['channel'])!,
        description: ConvertUtil.asT<String>(json['description'])!,
        downloadLink: ConvertUtil.asT<String>(json['downloadLink'])!,
        fileMd5: ConvertUtil.asT<String>(json['fileMd5'])!,
        createdAt: ConvertUtil.asT<int>(json['createdAt'])!,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'versionId': versionId,
        'os': os,
        'appVersion': appVersion,
        'channel': channel,
        'description': description,
        'downloadLink': downloadLink,
        'fileMd5': fileMd5,
        'createdAt': createdAt,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
