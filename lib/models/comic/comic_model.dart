import 'dart:convert';

import 'package:liaz/app/utils/convert_util.dart';

class ComicModel {
  int comicId;
  String title;
  String cover;

  ComicModel({
    required this.comicId,
    required this.title,
    required this.cover,
  });

  factory ComicModel.fromJson(Map<String, dynamic> json) {
    return ComicModel(
      comicId: ConvertUtil.asT<int>(json['comicId'])!,
      title: ConvertUtil.asT<String>(json['title'])!,
      cover: ConvertUtil.asT<String>(json['cover'])!,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'comicId': comicId,
        'title': title,
        'cover': cover,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
