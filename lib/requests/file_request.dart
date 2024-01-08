import 'dart:io';

import 'package:liaz/app/constants/app_constant.dart';
import 'package:liaz/app/global/global.dart';
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
    if (path.isEmpty) {
      return path;
    }
    if (path.startsWith(AppConstant.https) ||
        path.startsWith(AppConstant.http)) {
      return path;
    }
    String requestUri = path;
    var fileUrl = Global.appConfig.fileUrl;
    var isAuthority = Global.appConfig.resourceAuthority;
    if (isAuthority) {
      dynamic result = await Request.instance.get('/api/file$path');
      if (result is String) {
        requestUri = result;
      }
    }
    if (requestUri.startsWith(AppConstant.https) ||
        requestUri.startsWith(AppConstant.http)) {
      return requestUri;
    }
    var bucketName = StrUtil.empty;
    var pathArray = path.split(StrUtil.slash);
    if (pathArray.length > 1) {
      bucketName = path[1];
    }
    var objectName = StrUtil.empty;
    if (pathArray.length > 2) {
      objectName = path[2];
    }
    var bucketTemplate = '{bucketName}';
    var objectTemplate = '{objectName}';
    if (fileUrl.contains(bucketTemplate) && fileUrl.contains(objectTemplate)) {
      return fileUrl
          .replaceAll(bucketTemplate, bucketName)
          .replaceAll(objectTemplate, objectName);
    }
    return fileUrl + requestUri;
  }
}
