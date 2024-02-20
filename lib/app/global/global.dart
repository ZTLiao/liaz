import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/models/db/app_config.dart';
import 'package:package_info_plus/package_info_plus.dart';

class Global {
  static const String configUrl =
      'https://gitee.com/liaz-app/liaz-android/raw/master/config.json';

  static late String baseUrl;

  static late PackageInfo packageInfo;

  static late AppConfig appConfig;

  static String netType = StrUtil.empty;

  static String signKey = StrUtil.empty;

  static String publicKey = StrUtil.empty;

  static bool isUserLogin = false;
}
