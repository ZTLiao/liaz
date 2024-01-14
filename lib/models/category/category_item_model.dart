import 'dart:convert';

import 'package:liaz/app/constants/yes_or_no.dart';
import 'package:liaz/app/utils/convert_util.dart';
import 'package:liaz/app/utils/str_util.dart';

class CategoryItemModel {
  int categoryId;
  int assetType;
  String title;
  String cover;
  int objId;
  int chapterId;
  String upgradeChapter;
  int updatedAt;
  int isUpgrade;

  CategoryItemModel({
    required this.categoryId,
    required this.assetType,
    required this.title,
    required this.cover,
    required this.objId,
    required this.chapterId,
    this.upgradeChapter = StrUtil.empty,
    this.updatedAt = 0,
    this.isUpgrade = YesOrNo.no,
  });

  factory CategoryItemModel.fromJson(Map<String, dynamic> json) =>
      CategoryItemModel(
        categoryId: ConvertUtil.asT<int>(json['categoryId'])!,
        assetType: ConvertUtil.asT<int>(json['assetType'])!,
        title: ConvertUtil.asT<String>(json['title'])!,
        cover: ConvertUtil.asT<String>(json['cover'])!,
        objId: ConvertUtil.asT<int>(json['objId'])!,
        chapterId: ConvertUtil.asT<int>(json['chapterId'])!,
        upgradeChapter: ConvertUtil.asT<String>(json['upgradeChapter'])!,
        updatedAt: ConvertUtil.asT<int>(json['updatedAt'])!,
        isUpgrade: ConvertUtil.asT<int>(json['isUpgrade'])!,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'categoryId': categoryId,
        'assetType': assetType,
        'title': title,
        'cover': cover,
        'objId': objId,
        'chapterId': chapterId,
        'upgradeChapter': upgradeChapter,
        'updatedAt': updatedAt,
        'isUpgrade': isUpgrade,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
