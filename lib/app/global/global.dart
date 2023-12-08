import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/models/db/app_config.dart';
import 'package:package_info_plus/package_info_plus.dart';

class Global {
  // static const String baseUrl = 'http://192.168.2.35:8081';
  static const String baseUrl = 'http://192.168.19.49:8081';

  static late PackageInfo packageInfo;

  static late AppConfig appConfig;

  static String netType = StrUtil.empty;

  static String signKey = StrUtil.empty;

  static String publicKey = StrUtil.empty;
}
