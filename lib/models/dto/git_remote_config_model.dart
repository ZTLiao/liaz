import 'dart:convert';

import 'package:liaz/app/utils/convert_util.dart';

class GitRemoteConfigModel {
  String domain;

  GitRemoteConfigModel({
    required this.domain,
  });

  factory GitRemoteConfigModel.fromJson(Map<String, dynamic> json) =>
      GitRemoteConfigModel(
        domain: ConvertUtil.asT<String>(json['domain'])!,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'domain': domain,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
