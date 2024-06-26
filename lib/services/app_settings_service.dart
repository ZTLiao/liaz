import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_settings.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/constants/local_storage.dart';
import 'package:liaz/app/enums/screen_direction_enum.dart';
import 'package:liaz/app/logger/log.dart';
import 'package:liaz/services/local_storage_service.dart';
import 'package:screen_brightness/screen_brightness.dart';

class AppSettingsService extends GetxService {
  static AppSettingsService get instance {
    if (Get.isRegistered<AppSettingsService>()) {
      return Get.find<AppSettingsService>();
    }
    return Get.put(AppSettingsService());
  }

  void init() async {
    AppSettings.themeMode.value =
        LocalStorageService.instance.getValue(LocalStorage.kThemeMode, 0);
    AppSettings.firstRun =
        LocalStorageService.instance.getValue(LocalStorage.kFirstRun, true);
    //设置后续为非首次标识
    if (AppSettings.firstRun) {
      setNoFirstRun();
    }
    //漫画
    AppSettings.comicReaderDirection.value = LocalStorageService.instance
        .getValue(LocalStorage.kComicReaderDirection, 0);
    AppSettings.comicReaderFullScreen.value = LocalStorageService.instance
        .getValue(LocalStorage.kComicReaderFullScreen, true);
    AppSettings.comicReaderShowStatus.value = LocalStorageService.instance
        .getValue(LocalStorage.kComicReaderShowStatus, true);
    AppSettings.comicReaderShowStatus.value = LocalStorageService.instance
        .getValue(LocalStorage.kComicReaderShowStatus, true);
    AppSettings.comicReaderLeftHandMode.value = LocalStorageService.instance
        .getValue(LocalStorage.kComicReaderLeftHandMode, false);
    AppSettings.comicReaderPageAnimation.value = LocalStorageService.instance
        .getValue(LocalStorage.kComicReaderPageAnimation, true);
    //小说
    AppSettings.novelReaderDirection.value = LocalStorageService.instance
        .getValue(LocalStorage.kNovelReaderDirection, 0);
    AppSettings.novelReaderFontSize.value = LocalStorageService.instance
        .getValue(LocalStorage.kNovelReaderFontSize, 16);
    AppSettings.novelReaderLineSpacing.value = LocalStorageService.instance
        .getValue(LocalStorage.kNovelReaderLineSpacing, 1.5);
    AppSettings.novelReaderTheme.value = LocalStorageService.instance
        .getValue(LocalStorage.kNovelReaderTheme, 0);
    AppSettings.novelReaderFullScreen.value = LocalStorageService.instance
        .getValue(LocalStorage.kNovelReaderFullScreen, true);
    AppSettings.novelReaderShowStatus.value = LocalStorageService.instance
        .getValue(LocalStorage.kNovelReaderShowStatus, true);
    AppSettings.novelReaderLeftHandMode.value = LocalStorageService.instance
        .getValue(LocalStorage.kNovelReaderLeftHandMode, false);
    AppSettings.novelReaderPageAnimation.value = LocalStorageService.instance
        .getValue(LocalStorage.kNovelReaderPageAnimation, true);
    //下载
    AppSettings.downloadAllowCellular.value = LocalStorageService.instance
        .getValue(LocalStorage.kDownloadAllowCellular, true);
    AppSettings.downloadTaskCount.value = LocalStorageService.instance
        .getValue(LocalStorage.kDownloadTaskCount, 5);
    //屏幕亮度
    var currentBrightness = await getCurrentBrightness();
    setScreenBrightness(currentBrightness);
    //屏幕方向
    AppSettings.screenDirection.value =
        LocalStorageService.instance.getValue(LocalStorage.kScreenDirection, 0);
    setScreenDirection(AppSettings.screenDirection.value);
  }

  void changeTheme() {
    Get.dialog(
      SimpleDialog(
        title: const Text(AppString.settingTheme),
        children: [
          RadioListTile<int>(
            title: const Text(AppString.followSystem),
            value: 0,
            groupValue: AppSettings.themeMode.value,
            onChanged: (e) {
              Get.back();
              setTheme(e ?? 0);
            },
          ),
          RadioListTile<int>(
            title: const Text(AppString.lightTheme),
            value: 1,
            groupValue: AppSettings.themeMode.value,
            onChanged: (e) {
              Get.back();
              setTheme(e ?? 1);
            },
          ),
          RadioListTile<int>(
            title: const Text(AppString.darkTheme),
            value: 2,
            groupValue: AppSettings.themeMode.value,
            onChanged: (e) {
              Get.back();
              setTheme(e ?? 2);
            },
          ),
        ],
      ),
    );
  }

  void setTheme(int i) {
    AppSettings.themeMode.value = i;
    var mode = ThemeMode.values[i];
    LocalStorageService.instance.setValue(LocalStorage.kThemeMode, i);
    Get.changeThemeMode(mode);
  }

  void setComicReaderDirection(int direction) {
    if (AppSettings.comicReaderDirection.value == direction) {
      return;
    }
    AppSettings.comicReaderDirection.value = direction;
    LocalStorageService.instance
        .setValue(LocalStorage.kComicReaderDirection, direction);
  }

  void setComicReaderFullScreen(bool value) {
    AppSettings.comicReaderFullScreen.value = value;
    LocalStorageService.instance
        .setValue(LocalStorage.kComicReaderFullScreen, value);
  }

  void setComicReaderShowStatus(bool value) {
    AppSettings.comicReaderShowStatus.value = value;
    LocalStorageService.instance
        .setValue(LocalStorage.kComicReaderShowStatus, value);
  }

  void setNovelReaderDirection(int direction) {
    if (AppSettings.novelReaderDirection.value == direction) {
      return;
    }
    AppSettings.novelReaderDirection.value = direction;
    LocalStorageService.instance
        .setValue(LocalStorage.kNovelReaderDirection, direction);
  }

  void setNovelReaderFontSize(int size) {
    if (size < 5) {
      size = 5;
    }
    if (size > 56) {
      size = 56;
    }
    AppSettings.novelReaderFontSize.value = size;
    LocalStorageService.instance
        .setValue(LocalStorage.kNovelReaderFontSize, size);
  }

  void setNovelReaderLineSpacing(double spacing) {
    if (spacing < 1) {
      spacing = 1;
    }
    //应该没人需要这么大的字体吧...
    if (spacing > 5) {
      spacing = 5;
    }
    AppSettings.novelReaderLineSpacing.value = spacing;
    LocalStorageService.instance
        .setValue(LocalStorage.kNovelReaderLineSpacing, spacing);
  }

  void setNovelReaderTheme(int theme) {
    AppSettings.novelReaderTheme.value = theme;
    LocalStorageService.instance
        .setValue(LocalStorage.kNovelReaderTheme, theme);
  }

  void setNovelReaderFullScreen(bool value) {
    AppSettings.novelReaderFullScreen.value = value;
    LocalStorageService.instance
        .setValue(LocalStorage.kNovelReaderFullScreen, value);
  }

  void setNovelReaderShowStatus(bool value) {
    AppSettings.novelReaderShowStatus.value = value;
    LocalStorageService.instance
        .setValue(LocalStorage.kNovelReaderShowStatus, value);
  }

  void setDownloadAllowCellular(bool value) {
    AppSettings.downloadAllowCellular.value = value;
    LocalStorageService.instance
        .setValue(LocalStorage.kDownloadAllowCellular, value);
  }

  void setDownloadComicTaskCount(int task) {
    AppSettings.downloadTaskCount.value = task;
    LocalStorageService.instance
        .setValue(LocalStorage.kDownloadTaskCount, task);
  }

  void setComicReaderLeftHandMode(bool value) {
    AppSettings.comicReaderLeftHandMode.value = value;
    LocalStorageService.instance
        .setValue(LocalStorage.kComicReaderLeftHandMode, value);
  }

  void setNovelReaderLeftHandMode(bool value) {
    AppSettings.novelReaderLeftHandMode.value = value;
    LocalStorageService.instance
        .setValue(LocalStorage.kNovelReaderLeftHandMode, value);
  }

  void setComicReaderPageAnimation(bool value) {
    AppSettings.comicReaderPageAnimation.value = value;
    LocalStorageService.instance
        .setValue(LocalStorage.kComicReaderPageAnimation, value);
  }

  void setNovelReaderPageAnimation(bool value) {
    AppSettings.novelReaderPageAnimation.value = value;
    LocalStorageService.instance
        .setValue(LocalStorage.kNovelReaderPageAnimation, value);
  }

  void setNoFirstRun() {
    LocalStorageService.instance.setValue(LocalStorage.kFirstRun, false);
  }

  Future<double> getCurrentBrightness() async {
    var screenBrightness = ScreenBrightness();
    //获取系统当前亮度
    return await screenBrightness.current;
  }

  void setScreenBrightness(double value) async {
    var screenBrightness = ScreenBrightness();
    AppSettings.screenBrightness.value = value;
    LocalStorageService.instance
        .setValue(LocalStorage.kScreenBrightness, value);
    try {
      await screenBrightness.setScreenBrightness(value);
    } catch (error, stackTrace) {
      Log.e(error.toString(), stackTrace);
      rethrow;
    }
  }

  void setScreenDirection(int value) {
    AppSettings.screenDirection.value = value;
    LocalStorageService.instance.setValue(LocalStorage.kScreenDirection, value);
    if (value == ScreenDirectionEnum.vertical.index) {
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    } else if (value == ScreenDirectionEnum.horizontal.index) {
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    }
  }
}
