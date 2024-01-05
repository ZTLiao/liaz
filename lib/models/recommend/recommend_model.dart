import 'dart:convert';

import 'package:liaz/app/utils/convert_util.dart';
import 'package:liaz/models/recommend/recommend_item_model.dart';

class RecommendModel {
  int recommendId;
  int recommendType;
  String title;
  int showType;
  bool isShowTitle;
  int optType;
  String? optValue;
  List<RecommendItemModel> items;

  RecommendModel({
    required this.recommendId,
    required this.recommendType,
    required this.title,
    required this.showType,
    required this.isShowTitle,
    required this.optType,
    this.optValue,
    required this.items,
  });

  factory RecommendModel.fromJson(Map<String, dynamic> json) {
    final List<RecommendItemModel>? items =
        json['items'] is List ? <RecommendItemModel>[] : null;
    if (items != null) {
      for (final dynamic item in json['items']!) {
        if (item != null) {
          items.add(RecommendItemModel.fromJson(
              ConvertUtil.asT<Map<String, dynamic>>(item)!));
        }
      }
    }
    return RecommendModel(
      recommendId: ConvertUtil.asT<int>(json['recommendId'])!,
      recommendType: ConvertUtil.asT<int>(json['recommendType'])!,
      title: ConvertUtil.asT<String>(json['title'])!,
      showType: ConvertUtil.asT<int>(json['showType'])!,
      isShowTitle: ConvertUtil.asT<bool>(json['isShowTitle'])!,
      optType: ConvertUtil.asT<int>(json['optType'])!,
      optValue: ConvertUtil.asT<String?>(json['optValue']),
      items: items ?? [],
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'recommendId': recommendId,
        'recommendType': recommendType,
        'title': title,
        'showType': showType,
        'isShowTitle': isShowTitle,
        'optType': optType,
        'optValue': optValue,
        'items': items,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
