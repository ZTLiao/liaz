import 'dart:io';

import 'package:liaz/app/http/dio_request.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/models/db/file_item.dart';

class FileItemRequest {
  Future<String> upload(String bucketName, File file) async {
    dynamic result =
        await DioRequest.instance.uploadFile('/api/file/upload', file, data: {
      'bucketName': bucketName,
    });
    if (result is String) {
      return result;
    }
    return StrUtil.empty;
  }

  Future<String> getObject(String path) async {
    return await DioRequest.instance.get('/api/file$path');
  }

  Future<FileItem> getTemporaryObject(String path) async {
    var model = FileItem();
    var result = await DioRequest.instance.get('/api/file/temporary$path');
    if (result != null && result is Map) {
      model = FileItem.fromJson(result as Map<String, dynamic>);
    }
    return model;
  }
}
