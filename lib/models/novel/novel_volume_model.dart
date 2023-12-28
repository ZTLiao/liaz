import 'dart:convert';

import 'package:liaz/app/utils/convert_util.dart';
import 'package:liaz/models/novel/novel_chapter_model.dart';

class NovelVolumeModel {
  int novelVolumeId;
  String? volumeName;
  int? seqNo;
  List<NovelChapterModel> chapters;

  NovelVolumeModel({
    required this.novelVolumeId,
    this.volumeName,
    this.seqNo,
    required this.chapters,
  });

  factory NovelVolumeModel.fromJson(Map<String, dynamic> json) {
    final List<NovelChapterModel> chapters = <NovelChapterModel>[];
    if (json['chapters'] is List) {
      for (final dynamic chapter in json['chapters']!) {
        chapters.add(NovelChapterModel.fromJson(chapter));
      }
    }
    return NovelVolumeModel(
      novelVolumeId: ConvertUtil.asT<int>(json['novelVolumeId'])!,
      volumeName: ConvertUtil.asT<String>(json['volumeName']),
      seqNo: ConvertUtil.asT<int>(json['seqNo']),
      chapters: chapters,
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
      'seqNo': seqNo,
      'chapters': list,
    };
  }

  @override
  String toString() {
    return jsonEncode(this);
  }
}
