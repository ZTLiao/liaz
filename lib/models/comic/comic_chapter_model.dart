import 'dart:convert';

import 'package:liaz/app/utils/convert_util.dart';
import 'package:liaz/models/comic/comic_chapter_item_model.dart';

class ComicChapterModel {
  int comicChapterId;
  int comicId;
  String chapterName;
  int chapterType;
  int pageNum;
  int seqNo;
  int updatedAt;
  List<ComicChapterItemModel>? items;

  ComicChapterModel({
    required this.comicChapterId,
    required this.comicId,
    required this.chapterName,
    required this.chapterType,
    required this.pageNum,
    required this.seqNo,
    required this.updatedAt,
    this.items,
  });

  factory ComicChapterModel.fromJson(Map<String, dynamic> json) {
    final List<ComicChapterItemModel>? items =
        json['items'] is List ? <ComicChapterItemModel>[] : null;
    if (items != null) {
      for (final dynamic item in json['items']!) {
        items.add(ComicChapterItemModel.fromJson(item));
      }
    }
    return ComicChapterModel(
      comicChapterId: ConvertUtil.asT<int>(json['comicChapterId'])!,
      comicId: ConvertUtil.asT<int>(json['comicId'])!,
      chapterName: ConvertUtil.asT<String>(json['chapterName'])!,
      chapterType: ConvertUtil.asT<int>(json['chapterType'])!,
      pageNum: ConvertUtil.asT<int>(json['pageNum'])!,
      seqNo: ConvertUtil.asT<int>(json['seqNo'])!,
      updatedAt: ConvertUtil.asT<int>(json['updatedAt'])!,
      items: items ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> list = [];
    if (items != null) {
      for (final ComicChapterItemModel item in items!) {
        list.add(item.toJson());
      }
    }
    return <String, dynamic>{
      'comicChapterId': comicChapterId,
      'comicId': comicId,
      'chapterName': chapterName,
      'chapterType': chapterType,
      'pageNum': pageNum,
      'seqNo': seqNo,
      'updatedAt': updatedAt,
      'items': list,
    };
  }

  @override
  String toString() {
    return jsonEncode(this);
  }
}
