import 'dart:convert';

import 'package:liaz/app/constants/comic_flag.dart';
import 'package:liaz/app/constants/novel_flag.dart';
import 'package:liaz/app/utils/convert_util.dart';

class NovelChapterItemModel {
  int novelChapterId;
  int novelId;
  int flag;
  String chapterName;
  int seqNo;
  List<String> paths;
  List<String> types;
  int direction;
  bool isLocal;
  bool isSerializated;
  bool isHide;

  NovelChapterItemModel({
    required this.novelChapterId,
    required this.novelId,
    required this.flag,
    required this.chapterName,
    required this.seqNo,
    required this.paths,
    required this.types,
    required this.direction,
    this.isLocal = false,
    this.isSerializated = false,
    this.isHide = false,
  });

  factory NovelChapterItemModel.empty() => NovelChapterItemModel(
        novelChapterId: 0,
        novelId: 0,
        flag: 0,
        chapterName: '',
        seqNo: 0,
        paths: [],
        types: [],
        direction: 0,
        isSerializated: false,
        isHide: false,
      );

  factory NovelChapterItemModel.fromJson(Map<String, dynamic> json) {
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
    int flag = ConvertUtil.asT<int>(json['flag'])!;
    return NovelChapterItemModel(
      novelChapterId: ConvertUtil.asT<int>(json['novelChapterId'])!,
      novelId: ConvertUtil.asT<int>(json['novelId'])!,
      flag: flag,
      chapterName: ConvertUtil.asT<String>(json['chapterName'])!,
      seqNo: ConvertUtil.asT<int>(json['seqNo'])!,
      paths: paths ?? [],
      types: types ?? [],
      direction: ConvertUtil.asT<int>(json['direction'])!,
      isSerializated: (flag & NovelFlag.serializated) != 0,
      isHide: (flag & ComicFlag.hide) != 0,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'novelChapterId': novelChapterId,
        'novelId': novelId,
        'flag': flag,
        'chapterName': chapterName,
        'seqNo': seqNo,
        'paths': paths,
        'types': types,
        'isSerializated': isSerializated,
        'direction': direction,
        'isHide': isHide,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
