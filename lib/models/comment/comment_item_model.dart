import 'dart:convert';

import 'package:liaz/app/utils/convert_util.dart';
import 'package:liaz/app/utils/str_util.dart';

class CommentItemModel {
  int discussId;
  int userId;
  String nickname;
  String avatar;
  int gender;
  String content;
  int thumbNum;
  int discussNum;
  int createdAt;
  List<String> paths;
  List<CommentItemModel> parents;

  CommentItemModel({
    required this.discussId,
    required this.userId,
    required this.nickname,
    required this.avatar,
    required this.gender,
    required this.content,
    required this.thumbNum,
    required this.discussNum,
    required this.createdAt,
    required this.paths,
    required this.parents,
  });

  factory CommentItemModel.fromJson(Map<String, dynamic> json) {
    var avatar = json['avatar'] ?? StrUtil.empty;
    var content = json['content'] ?? StrUtil.empty;
    final List<String> paths = json['paths'] is List ? <String>[] : [];
    if (json['paths'] != null) {
      for (final dynamic path in json['paths']!) {
        paths.add(ConvertUtil.asT<String>(path)!);
      }
    }
    final List<CommentItemModel> parents = [];
    if (json['parents'] != null) {
      for (final dynamic parent in json['parents']!) {
        parents.add(CommentItemModel.fromJson(parent));
      }
    }
    return CommentItemModel(
      discussId: ConvertUtil.asT<int>(json['discussId'])!,
      userId: ConvertUtil.asT<int>(json['userId'])!,
      nickname: ConvertUtil.asT<String>(json['nickname'])!,
      avatar: avatar,
      gender: ConvertUtil.asT<int>(json['gender'])!,
      content: content,
      thumbNum: ConvertUtil.asT<int>(json['thumbNum'])!,
      discussNum: ConvertUtil.asT<int>(json['discussNum'])!,
      createdAt: ConvertUtil.asT<int>(json['createdAt'])!,
      paths: paths,
      parents: parents,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> list = [];
    for (final CommentItemModel parent in parents) {
      list.add(parent.toJson());
    }
    return <String, dynamic>{
      'discussId': discussId,
      'userId': userId,
      'nickname': nickname,
      'avatar': avatar,
      'gender': gender,
      'content': content,
      'thumbNum': thumbNum,
      'discussNum': discussNum,
      'createdAt': createdAt,
      'paths': paths,
      'parents': list,
    };
  }

  @override
  String toString() {
    return jsonEncode(this);
  }
}
