import 'dart:convert';

import 'package:liaz/app/utils/convert_util.dart';

class BannerModel {
  int? bannerId;
  String title;
  String url;
  int? skipType;
  String? skipValue;

  BannerModel({
    required this.bannerId,
    required this.title,
    required this.url,
    required this.skipType,
    required this.skipValue,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        bannerId: ConvertUtil.asT<int?>(json['bannerId']),
        title: ConvertUtil.asT<String>(json['title'])!,
        url: ConvertUtil.asT<String>(json['url'])!,
        skipType: ConvertUtil.asT<int?>(json['skipType']),
        skipValue: ConvertUtil.asT<String?>(json['skipValue']),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'title': title,
        'url': url,
        'skipType': skipType,
        'skipValue': skipValue,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
