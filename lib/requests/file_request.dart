import 'dart:io';

import 'package:liaz/app/http/request.dart';
import 'package:liaz/app/utils/str_util.dart';

class FileRequest {
  Future<String> upload(String bucketName, File file) async {
    dynamic result =
        await Request.instance.uploadFile('/api/file/upload', file, data: {
      'bucketName': bucketName,
    });
    if (result is String) {
      return result;
    }
    return StrUtil.empty;
  }

  Future<String> getObject(String path) async {
    dynamic result = await Request.instance.get('/api/file$path');
    if (result is String) {
      return result;
    }
    return StrUtil.empty;
  }
}
