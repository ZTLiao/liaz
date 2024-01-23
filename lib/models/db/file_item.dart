import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:liaz/app/utils/str_util.dart';

part 'file_item.g.dart';

@HiveType(typeId: 11)
class FileItem {
  @HiveField(0)
  String path;

  @HiveField(1)
  int expireTime;

  @HiveField(2)
  String requestUri;

  FileItem({
    this.path = StrUtil.empty,
    this.expireTime = -1,
    this.requestUri = StrUtil.empty,
  });

  factory FileItem.fromJson(Map<String, dynamic> json) {
    String path = json['path'] ?? StrUtil.empty;
    int expireTime = json['expireTime'] ?? -1;
    String requestUri = json['requestUri'] ?? StrUtil.empty;
    return FileItem(
      path: path,
      expireTime: expireTime,
      requestUri: requestUri,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'path': path,
        'expireTime': expireTime,
        'requestUri': requestUri,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}
