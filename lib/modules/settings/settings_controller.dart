import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_settings.dart';
import 'package:liaz/app/logger/log.dart';
import 'package:liaz/services/app_settings_service.dart';
import 'package:path_provider/path_provider.dart';

import 'package:path/path.dart' as p;

class SettingsController extends GetxController {
  var imageCacheSize = "正在计算缓存...".obs;
  var novelCacheSize = "正在计算缓存...".obs;

  @override
  void onInit() {
    super.onInit();
    getImageCachedSize();
    getNovelCachedSize();
  }

  void getImageCachedSize() async {
    try {
      imageCacheSize.value = "正在计算缓存...";
      var bytes = await getCachedSizeBytes();
      imageCacheSize.value = "${(bytes / 1024 / 1024).toStringAsFixed(1)}MB";
    } catch (e) {
      imageCacheSize.value = "缓存计算失败";
    }
  }

  void getNovelCachedSize() async {
    try {
      novelCacheSize.value = "正在计算缓存...";
      var bytes = await getNovelCacheSize();
      novelCacheSize.value = "${(bytes / 1024 / 1024).toStringAsFixed(1)}MB";
    } catch (e) {
      novelCacheSize.value = "缓存计算失败";
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

  Future<Directory> getNovelCacheDirectory() async {
    var dir = await getApplicationSupportDirectory();
    var novelDir = Directory(p.join(dir.path, "novel_cache"));
    if (!await novelDir.exists()) {
      novelDir = await novelDir.create();
    }
    return novelDir;
  }

  void cleanImageCache() async {
    var result = await clearDiskCachedImages();
    if (!result) {
      SmartDialog.showToast("清除失败");
    }
    getImageCachedSize();
  }

  void cleanNovelCache() async {
    var result = await cleanNovelCacheSize();
    if (!result) {
      SmartDialog.showToast("清除失败");
    }
    getNovelCachedSize();
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

  void setDownloadComicTask() {
    Get.dialog(
      SimpleDialog(
        title: const Text("漫画最大任务数"),
        children: [0, 1, 2, 3, 4, 5]
            .map(
              (e) => RadioListTile<int>(
            title: Text(e == 0 ? "无限制" : "$e个"),
            value: e,
            groupValue: AppSettings.downloadComicTaskCount.value,
            onChanged: (e) {
              Get.back();
              AppSettingsService.instance.setDownloadComicTaskCount(e ?? 0);
            },
          ),
        )
            .toList(),
      ),
    );
  }

  void setDownloadNovelTask() {
    Get.dialog(
      SimpleDialog(
        title: const Text("小说最大任务数"),
        children: [0, 1, 2, 3, 4, 5]
            .map(
              (e) => RadioListTile<int>(
            title: Text(e == 0 ? "无限制" : "$e个"),
            value: e,
            groupValue: AppSettings.downloadNovelTaskCount.value,
            onChanged: (e) {
              Get.back();
              AppSettingsService.instance.setDownloadNovelTaskCount(e ?? 0);
            },
          ),
        )
            .toList(),
      ),
    );
  }
}
