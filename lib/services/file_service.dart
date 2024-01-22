import 'package:get/get.dart';
import 'package:liaz/requests/file_request.dart';

class FileService extends GetxService {
  static FileService get instance {
    if (Get.isRegistered<FileService>()) {
      return Get.find<FileService>();
    }
    return Get.put(FileService());
  }

  final _fileRequest = FileRequest();

  Future<String> getObject(String path) async {
    return await _fileRequest.getObject(path);
  }
}
