class StrUtil {
  static const dashed = '-';
  static const comma = ',';
  static const dot = '.';
  static const empty = '';
  static const space = ' ';
  static const slash = '/';

  static String listToStr(List<String> list, String separator) {
    String str = empty;
    for (var i = 0, len = list.length; i < len; i++) {
      var type = list[i];
      str = str + type;
      if (i != len - 1) {
        str += separator;
      }
    }
    return str;
  }
}
