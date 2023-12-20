import 'dart:convert';

import 'package:liaz/app/constants/comic_flag.dart';
import 'package:liaz/app/logger/log.dart';
import 'package:liaz/app/utils/convert_util.dart';
import 'package:liaz/models/comic/comic_chapter_item_model.dart';

class ComicDetailModel {
  int comicId;
  String title;
  String cover;
  List<int> authorIds;
  List<String> authors;
  List<int> categoryIds;
  List<String> categories;
  int subscribeNum;
  int hitNum;
  int updated;
  String description;
  int flag;
  int direction;
  bool isSerializated;
  bool isLong;
  bool isHide;
  Map<int, List<ComicChapterItemModel>>? chapterMap;

  factory ComicDetailModel.empty() => ComicDetailModel(
        comicId: 0,
        title: '',
        cover: '',
        authorIds: [],
        authors: [],
        categoryIds: [],
        categories: [],
        subscribeNum: 0,
        hitNum: 0,
        updated: 0,
        description: '',
        flag: 0,
        direction: 0,
        isSerializated: false,
        isLong: false,
        isHide: false,
        chapterMap: {},
      );

  ComicDetailModel({
    required this.comicId,
    required this.title,
    required this.cover,
    required this.authorIds,
    required this.authors,
    required this.categoryIds,
    required this.categories,
    required this.subscribeNum,
    required this.hitNum,
    required this.updated,
    required this.description,
    required this.flag,
    required this.direction,
    required this.isSerializated,
    required this.isLong,
    required this.isHide,
    this.chapterMap,
  });

  factory ComicDetailModel.fromJson(Map<String, dynamic> json) {
    final List<int>? authorIds = json['authorIds'] is List ? <int>[] : null;
    if (authorIds != null) {
      for (final dynamic authorId in json['authorIds']!) {
        authorIds.add(ConvertUtil.asT<int>(authorId)!);
      }
    }
    final List<String>? authors = json['authors'] is List ? <String>[] : null;
    if (authors != null) {
      for (final dynamic author in json['authors']!) {
        authors.add(ConvertUtil.asT<String>(author)!);
      }
    }
    final List<int>? categoryIds = json['categoryIds'] is List ? <int>[] : null;
    if (categoryIds != null) {
      for (final dynamic categoryId in json['categoryIds']!) {
        categoryIds.add(ConvertUtil.asT<int>(categoryId)!);
      }
    }
    final List<String>? categories =
        json['categories'] is List ? <String>[] : null;
    if (categories != null) {
      for (final dynamic category in json['categories']!) {
        categories.add(ConvertUtil.asT<String>(category)!);
      }
    }
    Map<int, List<ComicChapterItemModel>>? chapterMap = {};
    if (json['chapterMap'] is Map) {
      for (final dynamic element in json['chapterMap'].entries) {
        var key = element.key;
        var value = element.value;
        List<ComicChapterItemModel> list = <ComicChapterItemModel>[];
        if (value is List) {
          for (final dynamic item in value) {
            list.add(ComicChapterItemModel.fromJson(item));
          }
        }
        chapterMap.putIfAbsent(int.parse(key.toString()), () => list);
      }
    }
    int flag = ConvertUtil.asT<int>(json['flag'])!;
    return ComicDetailModel(
      comicId: ConvertUtil.asT<int>(json['comicId'])!,
      title: ConvertUtil.asT<String>(json['title'])!,
      cover: ConvertUtil.asT<String>(json['cover'])!,
      authorIds: authorIds ?? [],
      authors: authors ?? [],
      categoryIds: categoryIds ?? [],
      categories: categories ?? [],
      subscribeNum: ConvertUtil.asT<int>(json['subscribeNum'])!,
      hitNum: ConvertUtil.asT<int>(json['hitNum'])!,
      updated: ConvertUtil.asT<int>(json['updated'])!,
      description: ConvertUtil.asT<String>(json['description'])!,
      flag: flag,
      direction: ConvertUtil.asT<int>(json['direction'])!,
      isSerializated: (flag & ComicFlag.serializated) != 0,
      isLong: (flag & ComicFlag.long) != 0,
      isHide: (flag & ComicFlag.hide) != 0,
      chapterMap: chapterMap,
    );
  }

  Map<String, dynamic> toJson() {
    Map<int, List<Map<String, dynamic>>> map = {};
    if (chapterMap != null) {
      for (final dynamic element in chapterMap!.entries) {
        var key = element.key;
        var value = element.value;
        List<Map<String, dynamic>> list = [];
        if (value is List) {
          for (ComicChapterItemModel item in value) {
            list.add(item.toJson());
          }
        }
        map.putIfAbsent(key, () => list);
      }
    }
    return <String, dynamic>{
      'comicId': comicId,
      'title': title,
      'cover': cover,
      'authorIds': authorIds,
      'authors': authors,
      'categoryIds': categoryIds,
      'categories': categories,
      'subscribeNum': subscribeNum,
      'hitNum': hitNum,
      'updated': updated,
      'description': description,
      'flag': flag,
      'direction': direction,
      'isSerializated': isSerializated,
      'isLong': isLong,
      'isHide': isHide,
      'chapterMap': map,
    };
  }

  @override
  String toString() {
    return jsonEncode(this);
  }
}
