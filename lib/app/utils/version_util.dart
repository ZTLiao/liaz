import 'package:liaz/app/utils/str_util.dart';

class VersionUtil {

  static int parseVersion(String version) {
    if (version.isEmpty) {
      return 0;
    }
    return int.parse(version.replaceAll(StrUtil.dot, String.fromCharCode(0)));
  }

}