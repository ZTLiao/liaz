import 'dart:convert';

import 'package:liaz/app/constants/comic_flag.dart';
import 'package:liaz/app/constants/novel_flag.dart';
import 'package:liaz/app/utils/convert_util.dart';
import 'package:liaz/models/novel/novel_volume_model.dart';

class NovelDetailModel {
  int novelId;
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
  bool isHide;
  int sortType;
  List<NovelVolumeModel> volumes;

  factory NovelDetailModel.empty() => NovelDetailModel(
        novelId: 0,
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
        isHide: false,
        sortType: 0,
        volumes: [],
      );

  NovelDetailModel({
    required this.novelId,
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
    required this.isHide,
    required this.sortType,
    required this.volumes,
  });

  factory NovelDetailModel.fromJson(Map<String, dynamic> json) {
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
    final List<NovelVolumeModel> volumes = <NovelVolumeModel>[];
    for (final dynamic volume in json['volumes']!) {
      volumes.add(NovelVolumeModel.fromJson(volume));
    }
    int flag = ConvertUtil.asT<int>(json['flag'])!;
    return NovelDetailModel(
      novelId: ConvertUtil.asT<int>(json['novelId'])!,
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
      isSerializated: (flag & NovelFlag.serializated) != 0,
      isHide: (flag & NovelFlag.hide) != 0,
      sortType: (flag & ComicFlag.sort) >> 3,
      volumes: volumes,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> list = [];
    for (final NovelVolumeModel volume in volumes) {
      list.add(volume.toJson());
    }
    return <String, dynamic>{
      'novelId': novelId,
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
      'isHide': isHide,
      'sortType': sortType,
      'volumes': list,
    };
  }

  @override
  String toString() {
    return jsonEncode(this);
  }
}
