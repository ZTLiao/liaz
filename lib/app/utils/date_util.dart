import 'package:intl/intl.dart';

class DateUtil {
  static const String normDatePattern = 'yyyy-MM-dd';
  static DateFormat normDateFormat = DateFormat(normDatePattern);

  static const String normDatetimeMinutePattern = "yyyy-MM-dd HH:mm";
  static DateFormat nnormDatetimeMinuteFormat =
      DateFormat(normDatetimeMinutePattern);

  static const String normDatetimePattern = "yyyy-MM-dd HH:mm:ss";
  static DateFormat normDatetimeFormat = DateFormat(normDatetimePattern);

  static String formatDate(int timestamp) {
    return normDateFormat
        .format(DateTime.fromMillisecondsSinceEpoch(timestamp));
  }

  static String formatDateTimeMinute(int timestamp) {
    return nnormDatetimeMinuteFormat
        .format(DateTime.fromMillisecondsSinceEpoch(timestamp));
  }
}
