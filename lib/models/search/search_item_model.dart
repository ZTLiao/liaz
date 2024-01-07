import 'dart:convert';

import 'package:liaz/app/utils/convert_util.dart';

class SearchItemModel {
  int objId;
  String title;
  String cover;
  int assetType;
  String? categories;
  String? authors;
  String upgradeChapter;

  SearchItemModel({
    required this.objId,
    required this.title,
    required this.cover,
    required this.assetType,
    this.categories,
    this.authors,
    required this.upgradeChapter,
  });

  factory SearchItemModel.fromJson(Map<String, dynamic> json) =>
      SearchItemModel(
        objId: ConvertUtil.asT<int>(json['objId'])!,
        title: ConvertUtil.asT<String>(json['title'])!,
        cover: ConvertUtil.asT<String>(json['cover'])!,
        assetType: ConvertUtil.asT<int>(json['assetType'])!,
        categories: ConvertUtil.asT<String?>(json['categories']),
        authors: ConvertUtil.asT<String?>(json['authors']),
        upgradeChapter: ConvertUtil.asT<String>(json['upgradeChapter'])!,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'objId': objId,
        'title': title,
        'cover': cover,
        'assetType': assetType,
        'categories': categories,
        'authors': authors,
        'upgradeChapter': upgradeChapter,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
