import 'dart:convert';

import 'package:liaz/app/utils/convert_util.dart';

class NovelItemModel {
  int novelId;
  String title;
  String cover;
  List<String> types;
  List<String> authors;
  String upgradeChapter;
  int updated;
  int novelChapterId;

  NovelItemModel({
    required this.novelId,
    required this.title,
    required this.cover,
    required this.types,
    required this.authors,
    required this.upgradeChapter,
    required this.updated,
    required this.novelChapterId,
  });

  factory NovelItemModel.fromJson(Map<String, dynamic> json) {
    final List<String>? types = json['types'] is List ? <String>[] : null;
    if (types != null && types.isNotEmpty) {
      for (final String type in json['types']!) {
        types.add(type);
      }
    }
    final List<String>? authors = json['authors'] is List ? <String>[] : null;
    if (authors != null && authors.isNotEmpty) {
      for (final String author in json['authors']!) {
        authors.add(author);
      }
    }
    return NovelItemModel(
        novelId: ConvertUtil.asT<int>(json['novelId'])!,
        title: ConvertUtil.asT<String>(json['title'])!,
        cover: ConvertUtil.asT<String>(json['cover'])!,
        types: types ?? [],
        authors: authors ?? [],
        upgradeChapter: ConvertUtil.asT<String>(json['upgradeChapter'])!,
        updated: ConvertUtil.asT<int>(json['updated'])!,
        novelChapterId: ConvertUtil.asT<int>(json['novelChapterId'])!);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'novelId': novelId,
    'title': title,
    'cover': cover,
    'types': types,
    'authors': authors,
    'upgradeChapter': upgradeChapter,
    'updated': updated,
    'novelChapterId': novelChapterId,
  };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
