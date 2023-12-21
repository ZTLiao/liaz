import 'dart:convert';

import 'package:liaz/app/utils/convert_util.dart';

class CategoryItemModel {
  int categoryId;
  int assetType;
  String title;
  String cover;
  List<String> authors;
  int objId;

  CategoryItemModel({
    required this.categoryId,
    required this.assetType,
    required this.title,
    required this.cover,
    required this.authors,
    required this.objId,
  });

  factory CategoryItemModel.fromJson(Map<String, dynamic> json) {
    final List<String>? authors = json['authors'] is List ? <String>[] : null;
    if (authors != null) {
      for (final dynamic author in json['authors']!) {
        authors.add(ConvertUtil.asT<String>(author)!);
      }
    }
    return CategoryItemModel(
      categoryId: ConvertUtil.asT<int>(json['categoryId'])!,
      assetType: ConvertUtil.asT<int>(json['assetType'])!,
      title: ConvertUtil.asT<String>(json['title'])!,
      cover: ConvertUtil.asT<String>(json['cover'])!,
      authors: authors ?? [],
      objId: ConvertUtil.asT<int>(json['objId'])!,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'categoryId': categoryId,
        'assetType': assetType,
        'title': title,
        'cover': cover,
        'authors': authors,
        'objId': objId,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
