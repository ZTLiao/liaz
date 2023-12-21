import 'dart:convert';

import 'package:liaz/app/constants/comic_flag.dart';
import 'package:liaz/app/utils/convert_util.dart';

class ComicChapterItemModel {
  int comicChapterId;
  int comicId;
  int flag;
  String chapterName;
  int seqNo;
  List<String> paths;
  int direction;
  bool isLocal;
  bool isSerializated;
  bool isLong;
  bool isHide;

  ComicChapterItemModel({
    required this.comicChapterId,
    required this.comicId,
    required this.flag,
    required this.chapterName,
    required this.seqNo,
    required this.paths,
    required this.direction,
    this.isLocal = false,
    this.isSerializated = false,
    this.isLong = false,
    this.isHide = false,
  });

  factory ComicChapterItemModel.empty() => ComicChapterItemModel(
        comicChapterId: 0,
        comicId: 0,
        flag: 0,
        chapterName: '',
        seqNo: 0,
        paths: [],
        direction: 0,
        isSerializated: false,
        isLong: false,
        isHide: false,
      );

  factory ComicChapterItemModel.fromJson(Map<String, dynamic> json) {
    final List<String>? paths = json['paths'] is List ? <String>[] : null;
    if (paths != null) {
      for (final dynamic path in json['paths']!) {
        paths.add(ConvertUtil.asT<String>(path)!);
      }
    }
    int flag = ConvertUtil.asT<int>(json['flag'])!;
    return ComicChapterItemModel(
      comicChapterId: ConvertUtil.asT<int>(json['comicChapterId'])!,
      comicId: ConvertUtil.asT<int>(json['comicId'])!,
      flag: flag,
      chapterName: ConvertUtil.asT<String>(json['chapterName'])!,
      seqNo: ConvertUtil.asT<int>(json['seqNo'])!,
      paths: paths ?? [],
      direction: ConvertUtil.asT<int>(json['direction'])!,
      isSerializated: (flag & ComicFlag.serializated) != 0,
      isLong: (flag & ComicFlag.long) != 0,
      isHide: (flag & ComicFlag.hide) != 0,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'comicChapterId': comicChapterId,
        'comicId': comicId,
        'flag': flag,
        'chapterName': chapterName,
        'seqNo': seqNo,
        'paths': paths,
        'isSerializated': isSerializated,
        'direction': direction,
        'isLong': isLong,
        'isHide': isHide,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
