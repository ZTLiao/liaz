import 'dart:convert';

import 'package:liaz/app/utils/convert_util.dart';

class ComicItemModel {
  int comicId;
  String title;
  String cover;
  List<String> types;
  List<String> authors;
  String upgradeChapter;
  int updated;
  int comicChapterId;

  ComicItemModel({
    required this.comicId,
    required this.title,
    required this.cover,
    required this.types,
    required this.authors,
    required this.upgradeChapter,
    required this.updated,
    required this.comicChapterId,
  });

  factory ComicItemModel.fromJson(Map<String, dynamic> json) {
    final List<String>? types = json['types'] is List ? <String>[] : null;
    if (types != null && types.isNotEmpty) {
      for (final dynamic type in json['types']!) {
        types.add(ConvertUtil.asT<String>(type)!);
      }
    }
    final List<String>? authors = json['authors'] is List ? <String>[] : null;
    if (authors != null && authors.isNotEmpty) {
      for (final dynamic author in json['authors']!) {
        authors.add(ConvertUtil.asT<String>(author)!);
      }
    }
    return ComicItemModel(
        comicId: ConvertUtil.asT<int>(json['comicId'])!,
        title: ConvertUtil.asT<String>(json['title'])!,
        cover: ConvertUtil.asT<String>(json['cover'])!,
        types: types ?? [],
        authors: authors ?? [],
        upgradeChapter: ConvertUtil.asT<String>(json['upgradeChapter'])!,
        updated: ConvertUtil.asT<int>(json['updated'])!,
        comicChapterId: ConvertUtil.asT<int>(json['comicChapterId'])!);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'comicId': comicId,
        'title': title,
        'cover': cover,
        'types': types,
        'authors': authors,
        'upgradeChapter': upgradeChapter,
        'updated': updated,
        'comicChapterId': comicChapterId,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
