import 'dart:async';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/global/global.dart';
import 'package:liaz/models/db/app_config.dart';
import 'package:liaz/requests/app_request.dart';
import 'package:liaz/requests/file_request.dart';
import 'package:path_provider/path_provider.dart';

class AppConfigService extends GetxService {
  static AppConfigService get instance => Get.find<AppConfigService>();
  late Box<AppConfig> box;

  final _fileRequest = FileRequest();

  Future<void> init() async {
    var appDir = await getApplicationSupportDirectory();
    box = await Hive.openBox(
      "appConfig",
      path: appDir.path,
    );
    var request = AppRequest();
    //初始化APP配置
    var result = await request.clientInit();
    if (result.app != null) {
      Global.appConfig = result.app!;
      put(Global.appConfig);
    }
  }

  Future<void> put(AppConfig appConfig) async {
    await box.put(AppString.appName, appConfig);
  }

  AppConfig? get() {
    return box.values.firstOrNull;
  }

  Future<String> getObject(String path) async {
    return await _fileRequest.getObject(path);
  }
}
