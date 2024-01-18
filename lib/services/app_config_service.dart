import 'dart:async';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/constants/db.dart';
import 'package:liaz/app/global/global.dart';
import 'package:liaz/app/utils/decrypt_util.dart';
import 'package:liaz/models/db/app_config.dart';
import 'package:liaz/requests/app_request.dart';
import 'package:liaz/requests/file_request.dart';
import 'package:path_provider/path_provider.dart';

class AppConfigService extends GetxService {
  static AppConfigService get instance {
    if (Get.isRegistered<AppConfigService>()) {
      return Get.find<AppConfigService>();
    }
    return Get.put(AppConfigService());
  }

  late Box<AppConfig> box;

  final _fileRequest = FileRequest();

  final _appRequest = AppRequest();

  Future<void> init() async {
    var appDir = await getApplicationSupportDirectory();
    box = await Hive.openBox(
      Db.appConfig,
      path: appDir.path,
    );
    //初始化APP配置
    if (isExist()) {
      _appRequest.clientInit().then((value) {
        if (value.app != null) {
          put(value.app!);
        }
      });
    } else {
      var result = await _appRequest.clientInit();
      if (result.app != null) {
        put(result.app!);
      }
    }
  }

  void put(AppConfig appConfig) {
    initConfig(appConfig);
    box.put(AppString.appName, appConfig);
  }

  bool isExist() {
    var values = box.values;
    var isExist = values.isNotEmpty;
    if (isExist) {
      initConfig(values.first);
    }
    return isExist;
  }

  void initConfig(AppConfig appConfig) {
    Global.appConfig = appConfig;
    Global.signKey = DecryptUtil.decryptKey(appConfig.signKey);
    Global.publicKey = DecryptUtil.decryptKey(appConfig.publicKey);
  }

  Future<String> getObject(String path) async {
    return await _fileRequest.getObject(path);
  }
}
