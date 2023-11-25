import 'dart:convert';

import 'package:liaz/app/utils/convert_util.dart';
import 'package:liaz/models/recommend/recommend_item_model.dart';

class RecommendModel {
  int recommendId;
  String title;
  int type;
  List<RecommendItemModel> items;

  RecommendModel({
    required this.recommendId,
    required this.title,
    required this.type,
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
      type: ConvertUtil.asT<int>(json['type'])!,
      items: items ?? [],
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'title': title,
        'type': type,
        'items': items,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
