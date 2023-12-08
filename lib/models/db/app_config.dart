import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:liaz/app/utils/convert_util.dart';

part 'app_config.g.dart';

@HiveField(2)
class AppConfig {
  @HiveField(0)
  String fileUrl;

  AppConfig({
    required this.fileUrl,
  });

  factory AppConfig.fromJson(Map<String, dynamic> json) => AppConfig(
        fileUrl: ConvertUtil.asT<String>(json['fileUrl'])!,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'fileUrl': fileUrl,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
