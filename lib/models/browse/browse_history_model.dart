import 'dart:convert';

import 'package:liaz/app/utils/convert_util.dart';

class BrowseHistoryModel {
  int browseId;
  int userId;
  int objId;
  int assetType;
  String title;
  String cover;
  int chapterId;
  String chapterName;
  int stopIndex;
  int createdAt;
  int updatedAt;

  BrowseHistoryModel({
    required this.browseId,
    required this.userId,
    required this.objId,
    required this.assetType,
    required this.title,
    required this.cover,
    required this.chapterId,
    required this.chapterName,
    required this.stopIndex,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BrowseHistoryModel.fromJson(Map<String, dynamic> json) =>
      BrowseHistoryModel(
        browseId: ConvertUtil.asT<int>(json['browseId'])!,
        userId: ConvertUtil.asT<int>(json['userId'])!,
        objId: ConvertUtil.asT<int>(json['objId'])!,
        assetType: ConvertUtil.asT<int>(json['assetType'])!,
        title: ConvertUtil.asT<String>(json['title'])!,
        cover: ConvertUtil.asT<String>(json['cover'])!,
        chapterId: ConvertUtil.asT<int>(json['chapterId'])!,
        chapterName: ConvertUtil.asT<String>(json['chapterName'])!,
        stopIndex: ConvertUtil.asT<int>(json['stopIndex'])!,
        createdAt: ConvertUtil.asT<int>(json['createdAt'])!,
        updatedAt: ConvertUtil.asT<int>(json['updatedAt'])!,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'browseId': browseId,
        'userId': userId,
        'objId': objId,
        'assetType': assetType,
        'title': title,
        'cover': cover,
        'chapterId': chapterId,
        'chapterName': chapterName,
        'stopIndex': stopIndex,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
