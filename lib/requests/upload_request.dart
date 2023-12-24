import 'dart:io';

import 'package:liaz/app/http/request.dart';
import 'package:liaz/app/utils/str_util.dart';

class UploadRequest {
  Future<String> upload(String bucketName, File file) async {
    dynamic result =
        Request.instance.uploadFile('/api/file/upload', file, data: {
      'bucketName': bucketName,
    });
    if (result is String) {
      return result;
    }
    return StrUtil.empty;
  }
}
