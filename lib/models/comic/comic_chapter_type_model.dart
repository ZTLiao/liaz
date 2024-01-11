import 'dart:convert';

import 'package:get/get.dart';
import 'package:liaz/app/constants/comic_flag.dart';
import 'package:liaz/app/enums/sort_type_enum.dart';
import 'package:liaz/app/utils/convert_util.dart';
import 'package:liaz/models/comic/comic_chapter_model.dart';

class ComicChapterTypeModel {
  int chapterType;
  int flag;
  RxInt sortType;
  RxList<ComicChapterModel> chapters;
  var isShowAll = RxBool(false);

  bool get isShowMoreButton => chapters.length > 15;

  ComicChapterTypeModel({
    required this.chapterType,
    required this.flag,
    required this.sortType,
    required this.chapters,
  });

  factory ComicChapterTypeModel.fromJson(Map<String, dynamic> json) {
    final List<ComicChapterModel> chapters = [];
    for (final dynamic chapter in json['chapters']!) {
      chapters.add(ComicChapterModel.fromJson(chapter));
    }
    int flag = ConvertUtil.asT<int>(json['flag'])!;
    return ComicChapterTypeModel(
      chapterType: ConvertUtil.asT<int>(json['chapterType'])!,
      flag: ConvertUtil.asT<int>(json['flag'])!,
      sortType: RxInt((flag & ComicFlag.hide) >> 3),
      chapters: RxList(chapters),
    );
  }

  Map<String, dynamic> toJson() {
    RxList<Map<String, dynamic>> list = RxList([]);
    for (final ComicChapterModel chapter in chapters) {
      list.add(chapter.toJson());
    }
    return <String, dynamic>{
      'chapterType': chapterType,
      'flag': flag,
      'sortType': sortType,
      'chapters': list,
    };
  }

  @override
  String toString() {
    return jsonEncode(this);
  }

  void sort() {
    if (sortType.value == SortTypeEnum.asc.index) {
      chapters.sort((a, b) => b.seqNo.compareTo(a.seqNo));
    } else {
      chapters.sort((a, b) => a.seqNo.compareTo(b.seqNo));
    }
  }
}
