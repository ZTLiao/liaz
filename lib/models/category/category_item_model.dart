import 'dart:convert';

import 'package:liaz/app/utils/convert_util.dart';

class CategoryItemModel {
  int categoryId;
  int assetType;
  String title;
  String cover;
  int objId;
  String upgradeChapter;

  CategoryItemModel({
    required this.categoryId,
    required this.assetType,
    required this.title,
    required this.cover,
    required this.objId,
    required this.upgradeChapter,
  });

  factory CategoryItemModel.fromJson(Map<String, dynamic> json) =>
      CategoryItemModel(
        categoryId: ConvertUtil.asT<int>(json['categoryId'])!,
        assetType: ConvertUtil.asT<int>(json['assetType'])!,
        title: ConvertUtil.asT<String>(json['title'])!,
        cover: ConvertUtil.asT<String>(json['cover'])!,
        upgradeChapter: ConvertUtil.asT<String>(json['upgradeChapter'])!,
        objId: ConvertUtil.asT<int>(json['objId'])!,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'categoryId': categoryId,
        'assetType': assetType,
        'title': title,
        'cover': cover,
        'upgradeChapter': upgradeChapter,
        'objId': objId,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
