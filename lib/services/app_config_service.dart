import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/global/global.dart';
import 'package:liaz/models/db/app_config.dart';
import 'package:liaz/requests/app_request.dart';
import 'package:path_provider/path_provider.dart';

class AppConfigService extends GetxService {
  static AppConfigService get instance => Get.find<AppConfigService>();
  late Box<AppConfig> box;

  Future<void> init() async {
    var appDir = await getApplicationSupportDirectory();
    box = await Hive.openBox(
      "appConfig",
      path: appDir.path,
    );
    var request = AppRequest();
    //初始化APP配置
    var appConfig = getAppConfig();
    if (appConfig == null) {
      var value = await request.clientInit();
      if (value.app != null) {
        Global.appConfig = value.app!;
        putAppConfig(Global.appConfig);
      }
    } else {
      Global.appConfig = appConfig;
      request.clientInit().then((value) {
        if (value.app != null) {
          Global.appConfig = value.app!;
          putAppConfig(Global.appConfig);
        }
      });
    }
  }

  Future<void> putAppConfig(AppConfig appConfig) async {
    await box.put(AppString.appName, appConfig);
  }

  AppConfig? getAppConfig() {
    return box.values.firstOrNull;
  }
}
