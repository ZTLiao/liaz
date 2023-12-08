import 'dart:convert';

import 'package:liaz/app/utils/convert_util.dart';

class ClientInitModel {
  KeyConfig? key;
  AppConfig? app;

  ClientInitModel({
    this.key,
    this.app,
  });

  factory ClientInitModel.fromJson(Map<String, dynamic> json) {
    var keyJson = json['key'];
    var appJson = json['app'];
    KeyConfig? key;
    if (keyJson != null) {
      key = KeyConfig.fromJson(keyJson);
    }
    AppConfig? app;
    if (appJson != null) {
      app = AppConfig.fromJson(jsonDecode(appJson));
    }
    return ClientInitModel(
      key: key,
      app: app,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'key': key,
        'app': app,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}

class KeyConfig {
  String k1;
  String k2;

  KeyConfig({
    required this.k1,
    required this.k2,
  });

  factory KeyConfig.fromJson(Map<String, dynamic> json) => KeyConfig(
        k1: ConvertUtil.asT<String>(json['k1'])!,
        k2: ConvertUtil.asT<String>(json['k2'])!,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'k1': k1,
        'k2': k2,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}

class AppConfig {
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
