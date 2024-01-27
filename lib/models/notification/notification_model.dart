import 'dart:convert';

import 'package:liaz/app/utils/convert_util.dart';

class NotificationModel {
  int notificationId;
  String title;
  String content;
  int createdAt;

  NotificationModel({
    required this.notificationId,
    required this.title,
    required this.content,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        notificationId: ConvertUtil.asT<int>(json['notificationId'])!,
        title: ConvertUtil.asT<String>(json['title'])!,
        content: ConvertUtil.asT<String>(json['content'])!,
        createdAt: ConvertUtil.asT<int>(json['createdAt'])!,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'notificationId': notificationId,
        'title': title,
        'content': content,
        'createdAt': createdAt,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
