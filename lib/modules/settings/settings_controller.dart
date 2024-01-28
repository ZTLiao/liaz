import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_event.dart';
import 'package:liaz/app/constants/app_settings.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/events/event_bus.dart';
import 'package:liaz/app/logger/log.dart';
import 'package:liaz/modules/settings/user_logout_listener.dart';
import 'package:liaz/services/app_settings_service.dart';
import 'package:liaz/services/novel_service.dart';

class SettingsController extends GetxController {
  var cacheSize = RxString(AppString.calculateCache);

  @override
  void onInit() {
    EventBus.instance
        .subscribe(AppEvent.kUserLogoutTopic, UserLogoutListener());
    super.onInit();
    calcCacheSize();
  }

  @override
  void onClose() {
    EventBus.instance.unSubscribe(AppEvent.kUserLogoutTopic);
    super.onClose();
  }

  void calcCacheSize() async {
    try {
      cacheSize.value = AppString.calculateCache;
      var imageBytes = await getCachedSizeBytes();
      var novelBytes = await NovelService.instance.getCachedSizeBytes();
      cacheSize.value =
          "${((imageBytes + novelBytes) / 1024 / 1024).toStringAsFixed(1)}MB";
    } catch (e) {
      Log.logPrint(e);
      cacheSize.value = AppString.calculateCacheFail;
    }
  }

  void cleanCache() async {
    if (!(await clearDiskCachedImages() &&
        await NovelService.instance.clearDiskCachedNovels())) {
      SmartDialog.showToast(AppString.clearFail);
    }
    calcCacheSize();
  }

  void setDownloadTask() {
    Get.dialog(
      SimpleDialog(
        title: const Text(AppString.downloadTaskNum),
        children: [0, 1, 2, 3, 4, 5]
            .map(
              (e) => RadioListTile<int>(
                title: Text(e == 0 ? AppString.unlimit : '$e${AppString.unit}'),
                value: e,
                groupValue: AppSettings.downloadTaskCount.value,
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

}
