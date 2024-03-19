import 'dart:convert';

import 'package:liaz/app/utils/convert_util.dart';

class ComicChapterModel {
  int comicChapterId;
  int comicId;
  int flag;
  String chapterName;
  int chapterType;
  int pageNum;
  int seqNo;
  int direction;
  int updatedAt;
  List<String> paths;
  int currentIndex;
  bool isLocal;

  ComicChapterModel({
    required this.comicChapterId,
    required this.comicId,
    required this.flag,
    required this.chapterName,
    required this.chapterType,
    required this.pageNum,
    required this.seqNo,
    required this.direction,
    required this.updatedAt,
    required this.paths,
    required this.currentIndex,
    this.isLocal = false,
  });

  factory ComicChapterModel.empty() => ComicChapterModel(
        comicChapterId: 0,
        comicId: 0,
        flag: 0,
        chapterName: '',
        chapterType: 0,
        pageNum: 0,
        seqNo: 0,
        direction: 0,
        updatedAt: 0,
        paths: [],
        currentIndex: 0,
      );

  factory ComicChapterModel.fromJson(Map<String, dynamic> json) {
    final List<String>? paths = json['paths'] is List ? <String>[] : null;
    if (paths != null) {
      for (final dynamic path in json['paths']!) {
        paths.add(ConvertUtil.asT<String>(path)!);
      }
    }
    var currentIndex = json['currentIndex'] ?? 0;
    return ComicChapterModel(
      comicChapterId: ConvertUtil.asT<int>(json['comicChapterId'])!,
      comicId: ConvertUtil.asT<int>(json['comicId'])!,
      flag: ConvertUtil.asT<int>(json['flag'])!,
      chapterName: ConvertUtil.asT<String>(json['chapterName'])!,
      chapterType: ConvertUtil.asT<int>(json['chapterType'])!,
      pageNum: ConvertUtil.asT<int>(json['pageNum'])!,
      seqNo: ConvertUtil.asT<int>(json['seqNo'])!,
      direction: ConvertUtil.asT<int>(json['direction'])!,
      updatedAt: ConvertUtil.asT<int>(json['updatedAt'])!,
      paths: paths ?? [],
      currentIndex: currentIndex,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'comicChapterId': comicChapterId,
      'comicId': comicId,
      'flag': flag,
      'chapterName': chapterName,
      'chapterType': chapterType,
      'pageNum': pageNum,
      'seqNo': seqNo,
      'direction': direction,
      'updatedAt': updatedAt,
      'paths': paths,
      'currentIndex': currentIndex,
    };
  }

  @override
  String toString() {
    return jsonEncode(this);
  }
}
