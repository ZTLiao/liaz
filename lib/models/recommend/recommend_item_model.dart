import 'dart:convert';

import 'package:liaz/app/utils/convert_util.dart';

class RecommendItemModel {
  int recommendItemId;
  String title;
  String? subTitle;
  String showValue;
  int skipType;
  String? skipValue;
  int? objId;

  RecommendItemModel({
    required this.recommendItemId,
    required this.title,
    this.subTitle,
    required this.showValue,
    required this.skipType,
    this.skipValue,
    this.objId,
  });

  factory RecommendItemModel.fromJson(Map<String, dynamic> json) =>
      RecommendItemModel(
        recommendItemId: ConvertUtil.asT<int>(json['recommendItemId'])!,
        title: ConvertUtil.asT<String>(json['title'])!,
        subTitle: ConvertUtil.asT<String?>(json['subTitle']),
        showValue: ConvertUtil.asT<String>(json['showValue'])!,
        skipType: ConvertUtil.asT<int>(json['skipType'])!,
        skipValue: ConvertUtil.asT<String?>(json['skipValue']),
        objId: ConvertUtil.asT<int?>(json['objId']),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'title': title,
        'subTitle': subTitle,
        'showValue': showValue,
        'skipType': skipType,
        'skipValue': skipValue,
        'objId': objId,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
