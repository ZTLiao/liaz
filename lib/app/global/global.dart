import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/models/db/app_config.dart';
import 'package:package_info_plus/package_info_plus.dart';

class Global {
  static const String baseUrl = 'http://8.134.215.58:80';

  static late PackageInfo packageInfo;

  static late AppConfig appConfig;

  static String netType = StrUtil.empty;

  static String signKey = StrUtil.empty;

  static String publicKey = StrUtil.empty;

  static bool isUserLogin = false;
}
