import 'dart:convert';

import 'package:liaz/app/utils/convert_util.dart';

class RankItemModel {
  int objId;
  String title;
  String cover;
  int assetType;
  String categories;
  String authors;
  int score;
  int updatedAt;

  RankItemModel({
    required this.objId,
    required this.title,
    required this.cover,
    required this.assetType,
    required this.categories,
    required this.authors,
    required this.score,
    required this.updatedAt,
  });

  factory RankItemModel.fromJson(Map<String, dynamic> json) => RankItemModel(
        objId: ConvertUtil.asT<int>(json['objId'])!,
        title: ConvertUtil.asT<String>(json['title'])!,
        cover: ConvertUtil.asT<String>(json['cover'])!,
        assetType: ConvertUtil.asT<int>(json['assetType'])!,
        categories: ConvertUtil.asT<String>(json['categories'])!,
        authors: ConvertUtil.asT<String>(json['authors'])!,
        score: ConvertUtil.asT<int>(json['score'])!,
        updatedAt: ConvertUtil.asT<int>(json['updatedAt'])!,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'objId': objId,
        'title': title,
        'cover': cover,
        'assetType': assetType,
        'categories': categories,
        'authors': authors,
        'score': score,
        'updatedAt': updatedAt,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
