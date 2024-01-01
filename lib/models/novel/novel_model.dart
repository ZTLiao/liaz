import 'dart:convert';

import 'package:liaz/app/utils/convert_util.dart';

class NovelModel {
  int novelId;
  String title;
  String cover;

  NovelModel({
    required this.novelId,
    required this.title,
    required this.cover,
  });

  factory NovelModel.fromJson(Map<String, dynamic> json) {
    return NovelModel(
      novelId: ConvertUtil.asT<int>(json['novelId'])!,
      title: ConvertUtil.asT<String>(json['title'])!,
      cover: ConvertUtil.asT<String>(json['cover'])!,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'novelId': novelId,
    'title': title,
    'cover': cover,
  };

  @override
  String toString() {
    return jsonEncode(this);
  }
}