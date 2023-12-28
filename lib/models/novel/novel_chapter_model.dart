import 'dart:convert';

import 'package:liaz/app/utils/convert_util.dart';

class NovelChapterModel {
  int novelChapterId;
  int novelId;
  int flag;
  String chapterName;
  int chapterType;
  int pageNum;
  int seqNo;
  int direction;
  int updatedAt;
  List<String> paths;
  List<String> types;

  NovelChapterModel({
    required this.novelChapterId,
    required this.novelId,
    required this.flag,
    required this.chapterName,
    required this.chapterType,
    required this.pageNum,
    required this.seqNo,
    required this.direction,
    required this.updatedAt,
    required this.paths,
    required this.types,
  });

  factory NovelChapterModel.empty() => NovelChapterModel(
        novelChapterId: 0,
        novelId: 0,
        flag: 0,
        chapterName: '',
        chapterType: 0,
        pageNum: 0,
        seqNo: 0,
        direction: 0,
        updatedAt: 0,
        paths: [],
        types: [],
      );

  factory NovelChapterModel.fromJson(Map<String, dynamic> json) {
    final List<String>? paths = json['paths'] is List ? <String>[] : null;
    if (paths != null) {
      for (final dynamic path in json['paths']!) {
        paths.add(ConvertUtil.asT<String>(path)!);
      }
    }
    final List<String>? types = json['types'] is List ? <String>[] : null;
    if (types != null) {
      for (final dynamic type in json['types']!) {
        types.add(ConvertUtil.asT<String>(type)!);
      }
    }
    return NovelChapterModel(
      novelChapterId: ConvertUtil.asT<int>(json['novelChapterId'])!,
      novelId: ConvertUtil.asT<int>(json['novelId'])!,
      flag: ConvertUtil.asT<int>(json['flag'])!,
      chapterName: ConvertUtil.asT<String>(json['chapterName'])!,
      chapterType: ConvertUtil.asT<int>(json['chapterType'])!,
      pageNum: ConvertUtil.asT<int>(json['pageNum'])!,
      seqNo: ConvertUtil.asT<int>(json['seqNo'])!,
      direction: ConvertUtil.asT<int>(json['direction'])!,
      updatedAt: ConvertUtil.asT<int>(json['updatedAt'])!,
      paths: paths ?? [],
      types: types ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'novelChapterId': novelChapterId,
      'novelId': novelId,
      'flag': flag,
      'chapterName': chapterName,
      'chapterType': chapterType,
      'pageNum': pageNum,
      'seqNo': seqNo,
      'direction': direction,
      'updatedAt': updatedAt,
      'paths': paths,
      'types': types,
    };
  }

  @override
  String toString() {
    return jsonEncode(this);
  }
}
