import 'package:liaz/models/db/device_info.dart';
import 'package:package_info_plus/package_info_plus.dart';

class Global {
  static const String baseUrl = 'http://127.0.0.1:8081';

  static late PackageInfo packageInfo;

  static String? netType;
}
