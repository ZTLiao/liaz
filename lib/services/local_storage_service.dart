import 'dart:io';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:liaz/app/logger/log.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class LocalStorageService extends GetxService {
  static LocalStorageService get instance => Get.find<LocalStorageService>();

  late Box settingsBox;

  Future init() async {
    var dir = await getApplicationSupportDirectory();
    settingsBox = await Hive.openBox(
      "LocalStorage",
      path: dir.path,
    );
  }

  T getValue<T>(dynamic key, T defaultValue) {
    var value = settingsBox.get(key, defaultValue: defaultValue) as T;
    Log.d("Get LocalStorage：$key\r\n$value");
    return value;
  }

  Future setValue<T>(dynamic key, T value) async {
    Log.d("Set LocalStorage：$key\r\n$value");
    return await settingsBox.put(key, value);
  }

  Future removeValue<T>(dynamic key) async {
    Log.d("Remove LocalStorage：$key");
    return await settingsBox.delete(key);
  }

  Future<Directory> getNovelCacheDirectory() async {
    var dir = await getApplicationSupportDirectory();
    var novelDir = Directory(path.join(dir.path, "novel_cache"));
    if (!await novelDir.exists()) {
      novelDir = await novelDir.create();
    }
    return novelDir;
  }

  Future saveNovelContent({
    required int volumeId,
    required int chapterId,
    required String content,
  }) async {
    try {
      var novelDir = await getNovelCacheDirectory();
      var fileName = path.join(novelDir.path, "${volumeId}_$chapterId.txt");
      var file = File(fileName);
      await file.writeAsString(content);
    } catch (e) {
      Log.logPrint(e);
    }
  }

  Future<String?> getNovelContent(
      {required int volumeId, required int chapterId}) async {
    try {
      var novelDir = await getNovelCacheDirectory();
      var fileName = path.join(novelDir.path, "${volumeId}_$chapterId.txt");
      var file = File(fileName);
      if (await file.exists()) {
        var content = await file.readAsString();
        return content;
      }
      return null;
    } catch (e) {
      Log.logPrint(e);
      return null;
    }
  }

  Future<int> getNovelCacheSize() async {
    var novelDir = await getNovelCacheDirectory();
    var size = 0;
    await for (var item in novelDir.list()) {
      size += item.statSync().size;
    }
    return size;
  }

  Future<bool> cleanNovelCacheSize() async {
    try {
      var novelDir = await getNovelCacheDirectory();
      await novelDir.delete(recursive: true);
      return true;
    } catch (e) {
      Log.logPrint(e);
      return false;
    }
  }
}
