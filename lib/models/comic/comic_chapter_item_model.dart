import 'dart:convert';

import 'package:liaz/app/constants/comic_flag.dart';
import 'package:liaz/app/utils/convert_util.dart';

class ComicChapterItemModel {
  int comicChapterId;
  int comicId;
  int comicFlag;
  String chapterName;
  int seqNo;
  List<String> paths;
  bool isLocal;
  bool isSerializated;
  int direction;
  bool isLong;
  bool isHide;

  ComicChapterItemModel({
    required this.comicChapterId,
    required this.comicId,
    required this.comicFlag,
    required this.chapterName,
    required this.seqNo,
    required this.paths,
    this.isLocal = false,
    required this.isSerializated,
    required this.direction,
    required this.isLong,
    required this.isHide,
  });

  factory ComicChapterItemModel.fromJson(Map<String, dynamic> json) {
    final List<String>? paths = json['paths'] is List ? <String>[] : null;
    if (paths != null && paths.isNotEmpty) {
      for (final dynamic path in json['paths']!) {
        paths.add(ConvertUtil.asT<String>(path)!);
      }
    }
    int comicFlag = ConvertUtil.asT<int>(json['comicFlag'])!;
    return ComicChapterItemModel(
      comicChapterId: ConvertUtil.asT<int>(json['comicChapterId'])!,
      comicId: ConvertUtil.asT<int>(json['comicId'])!,
      comicFlag: comicFlag,
      chapterName: ConvertUtil.asT<String>(json['chapterName'])!,
      seqNo: ConvertUtil.asT<int>(json['seqNo'])!,
      paths: paths ?? [],
      isSerializated: (comicFlag & ComicFlag.serializated) != 0,
      direction: (comicFlag & ComicFlag.direction) >> 1,
      isLong: (comicFlag & ComicFlag.long) != 0,
      isHide: (comicFlag & ComicFlag.hide) != 0,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'comicChapterId': comicChapterId,
        'comicId': comicId,
        'comicFlag': comicFlag,
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
