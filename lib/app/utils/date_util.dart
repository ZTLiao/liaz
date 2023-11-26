import 'package:intl/intl.dart';

class DateUtil {
  static const String normDatePattern = 'yyyy-MM-dd';
  static DateFormat normDateFormat = DateFormat(normDatePattern);

  static const String normDatetimePattern = "yyyy-MM-dd HH:mm:ss";
  static DateFormat normDatetimeFormat = DateFormat(normDatetimePattern);

  static String formatDate(int timestamp) {
    return normDateFormat
        .format(DateTime.fromMillisecondsSinceEpoch(timestamp));
  }
}
