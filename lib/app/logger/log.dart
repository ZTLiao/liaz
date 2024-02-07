import 'package:flutter/foundation.dart';
import 'package:liaz/requests/crash_request.dart';
import 'package:logger/logger.dart';

class Log {
  static final _crashRequest = CrashRequest();

  static Logger logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: false,
    ),
  );

  static d(String message) {
    logger.d("${DateTime.now().toString()}\n$message", time: DateTime.now());
  }

  static i(String message) {
    logger.i("${DateTime.now().toString()}\n$message", time: DateTime.now());
  }

  static e(String message, StackTrace stackTrace) {
    logger.e("${DateTime.now().toString()}\n$message",
        time: DateTime.now(), error: null, stackTrace: stackTrace);
    //上报崩溃日志
    _crashRequest.report(message, stackTrace);
  }

  static w(String message) {
    logger.w("${DateTime.now().toString()}\n$message", time: DateTime.now());
  }

  static void logPrint(dynamic obj) {
    if (obj is Error) {
      Log.e(obj.toString(), obj.stackTrace ?? StackTrace.current);
    } else if (kDebugMode) {
      print(obj);
    }
  }
}
