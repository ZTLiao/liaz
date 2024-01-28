import 'dart:convert';

import 'package:get/get.dart';
import 'package:liaz/app/constants/comic_flag.dart';
import 'package:liaz/app/enums/sort_type_enum.dart';
import 'package:liaz/app/utils/convert_util.dart';
import 'package:liaz/models/comic/comic_chapter_model.dart';

class ComicVolumeModel {
  int comicVolumeId;
  String? volumeName;
  int flag;
  int? seqNo;
  RxInt sortType;
  RxList<ComicChapterModel> chapters;
  var isShowAll = RxBool(false);

  bool get isShowMoreButton => chapters.length > 15;

  ComicVolumeModel({
    required this.comicVolumeId,
    this.volumeName,
    required this.flag,
    this.seqNo,
    required this.sortType,
    required this.chapters,
  });

  factory ComicVolumeModel.fromJson(Map<String, dynamic> json) {
    final List<ComicChapterModel> chapters = [];
    for (final dynamic chapter in json['chapters']!) {
      chapters.add(ComicChapterModel.fromJson(chapter));
    }
    int flag = ConvertUtil.asT<int>(json['flag'])!;
    return ComicVolumeModel(
      comicVolumeId: ConvertUtil.asT<int>(json['comicVolumeId'])!,
      volumeName: ConvertUtil.asT<String>(json['volumeName']),
      flag: flag,
      seqNo: ConvertUtil.asT<int>(json['seqNo']),
      sortType: RxInt((flag & ComicFlag.sort) != 0
          ? SortTypeEnum.desc.index
          : SortTypeEnum.asc.index),
      chapters: RxList(chapters),
    );
  }

  Map<String, dynamic> toJson() {
    RxList<Map<String, dynamic>> list = RxList([]);
    for (final ComicChapterModel chapter in chapters) {
      list.add(chapter.toJson());
    }
    return <String, dynamic>{
      'comicVolumeId': comicVolumeId,
      'volumeName': volumeName,
      'flag': flag,
      'seqNo': seqNo,
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
