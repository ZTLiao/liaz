import 'dart:convert';

import 'package:get/get.dart';
import 'package:liaz/app/constants/novel_flag.dart';
import 'package:liaz/app/enums/sort_type_enum.dart';
import 'package:liaz/app/utils/convert_util.dart';
import 'package:liaz/models/novel/novel_chapter_model.dart';

class NovelVolumeModel {
  int novelVolumeId;
  String? volumeName;
  int flag;
  int? seqNo;
  RxInt sortType;
  RxList<NovelChapterModel> chapters;
  var isLoadingMore = RxBool(false);

  RxInt pageSize = RxInt(25);

  NovelVolumeModel({
    required this.novelVolumeId,
    this.volumeName,
    required this.flag,
    this.seqNo,
    required this.sortType,
    required this.chapters,
  });

  factory NovelVolumeModel.fromJson(Map<String, dynamic> json) {
    final List<NovelChapterModel> chapters = <NovelChapterModel>[];
    if (json['chapters'] is List) {
      for (final dynamic chapter in json['chapters']!) {
        chapters.add(NovelChapterModel.fromJson(chapter));
      }
    }
    int flag = ConvertUtil.asT<int>(json['flag'])!;
    return NovelVolumeModel(
      novelVolumeId: ConvertUtil.asT<int>(json['novelVolumeId'])!,
      volumeName: ConvertUtil.asT<String>(json['volumeName']),
      flag: flag,
      seqNo: ConvertUtil.asT<int>(json['seqNo']),
      sortType: RxInt((flag & NovelFlag.sort) != 0
          ? SortTypeEnum.desc.index
          : SortTypeEnum.asc.index),
      chapters: RxList(chapters),
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> list = [];
    for (final NovelChapterModel chapter in chapters) {
      list.add(chapter.toJson());
    }
    return <String, dynamic>{
      'novelVolumeId': novelVolumeId,
      'volumeName': volumeName,
      'flag': flag,
      'seqNo': seqNo,
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
