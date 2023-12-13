import 'dart:convert';

import 'package:liaz/app/utils/convert_util.dart';

class ComicChapterModel {
  int comicChapterId;
  int comicId;
  String chapterName;
  int pageNum;
  int seqNo;
  int updatedAt;

  ComicChapterModel({
    required this.comicChapterId,
    required this.comicId,
    required this.chapterName,
    required this.pageNum,
    required this.seqNo,
    required this.updatedAt,
  });

  factory ComicChapterModel.fromJson(Map<String, dynamic> json) =>
      ComicChapterModel(
        comicChapterId: ConvertUtil.asT<int>(json['comicChapterId'])!,
        comicId: ConvertUtil.asT<int>(json['comicId'])!,
        chapterName: ConvertUtil.asT<String>(json['chapterName'])!,
        pageNum: ConvertUtil.asT<int>(json['pageNum'])!,
        seqNo: ConvertUtil.asT<int>(json['seqNo'])!,
        updatedAt: ConvertUtil.asT<int>(json['updatedAt'])!,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'comicChapterId': comicChapterId,
        'comicId': comicId,
        'chapterName': chapterName,
        'pageNum': pageNum,
        'seqNo': seqNo,
        'updatedAt': updatedAt,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
