import 'dart:convert';

import 'package:liaz/app/utils/convert_util.dart';
import 'package:liaz/models/recommend/recommend_item_model.dart';

class RecommendModel {
  int recommendId;
  String title;
  int showType;
  int showTitle;
  int optType;
  String? optValue;
  List<RecommendItemModel> items;

  RecommendModel({
    required this.recommendId,
    required this.title,
    required this.showType,
    required this.showTitle,
    required this.optType,
    this.optValue,
    required this.items,
  });

  factory RecommendModel.fromJson(Map<String, dynamic> json) {
    final List<RecommendItemModel>? items =
        json['items'] is List ? <RecommendItemModel>[] : null;
    if (items != null && items.isNotEmpty) {
      for (final dynamic item in json['items']!) {
        if (item != null) {
          items.add(RecommendItemModel.fromJson(
              ConvertUtil.asT<Map<String, dynamic>>(item)!));
        }
      }
    }
    return RecommendModel(
      recommendId: ConvertUtil.asT<int>(json['recommendId'])!,
      title: ConvertUtil.asT<String>(json['title'])!,
      showType: ConvertUtil.asT<int>(json['showType'])!,
      showTitle: ConvertUtil.asT<int>(json['showTitle'])!,
      optType: ConvertUtil.asT<int>(json['optType'])!,
      optValue: ConvertUtil.asT<String?>(json['optValue']),
      items: items ?? [],
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'title': title,
        'showType': showType,
        'showTitle': showTitle,
        'optType': optType,
        'optValue': optValue,
        'items': items,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
