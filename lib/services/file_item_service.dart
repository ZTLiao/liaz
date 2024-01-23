import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:liaz/app/constants/app_constant.dart';
import 'package:liaz/app/constants/db.dart';
import 'package:liaz/app/global/global.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/models/db/file_item.dart';
import 'package:liaz/requests/file_item_request.dart';
import 'package:path_provider/path_provider.dart';

class FileItemService extends GetxService {
  static FileItemService get instance {
    if (Get.isRegistered<FileItemService>()) {
      return Get.find<FileItemService>();
    }
    return Get.put(FileItemService());
  }

  final _fileItemRequest = FileItemRequest();

  Box<FileItem>? box;

  Future<void> init() async {
    if (box == null) {
      var dir = await getApplicationSupportDirectory();
      box = await Hive.openBox(
        Db.fileItem,
        path: dir.path,
      );
    }
  }

  void put(FileItem fileItem) async {
    if (fileItem.path.isEmpty || fileItem.requestUri.isEmpty) {
      return;
    }
    await init();
    box!.put(fileItem.path, fileItem);
  }

  Future<FileItem?> get(String key) async {
    await init();
    return box!.get(key);
  }

  void delete(String key) {
    box!.delete(key);
  }

  void clear() {
    var keys = box!.values.toList().map((e) => e.path).toList();
    if (keys.isNotEmpty) {
      box!.deleteAll(keys);
    }
  }

  Future<String> getObject(String path) async {
    if (path.isEmpty) {
      return path;
    }
    if (path.startsWith(AppConstant.https) ||
        path.startsWith(AppConstant.http)) {
      return path;
    }
    String requestUri = StrUtil.empty;
    var fileUrl = Global.appConfig.fileUrl;
    var isAuthority = Global.appConfig.resourceAuthority;
    if (isAuthority) {
      var fileItem = await get(path);
      if (fileItem != null) {
        var expireTime = fileItem.expireTime;
        if (expireTime != -1) {
          if (DateTime.now().millisecond < expireTime) {
            requestUri = fileItem.requestUri;
          } else {
            delete(path);
          }
        }
      }
      if (requestUri.isEmpty) {
        fileItem = await _fileItemRequest.getTemporaryObject(path);
        put(fileItem);
        if (fileItem.requestUri.isNotEmpty) {
          requestUri = fileItem.requestUri;
        }
      }
    } else {
      requestUri = path;
    }
    if (requestUri.startsWith(AppConstant.https) ||
        requestUri.startsWith(AppConstant.http)) {
      return requestUri;
    }
    var bucketTemplate = '{bucketName}';
    var objectTemplate = '{objectName}';
    if (fileUrl.contains(bucketTemplate)) {
      var bucketName = StrUtil.empty;
      var pathArray = path.split(StrUtil.slash);
      if (pathArray.length > 1) {
        bucketName = path[1];
      }
      var objectName = StrUtil.empty;
      if (pathArray.length > 2) {
        objectName = path[2];
      }
      return fileUrl
          .replaceFirst(bucketTemplate, bucketName)
          .replaceFirst(objectTemplate, objectName);
    }
    return fileUrl + requestUri;
  }
}
