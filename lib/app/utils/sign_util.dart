import 'dart:collection';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:liaz/app/logger/log.dart';
import 'package:liaz/app/utils/str_util.dart';

class SignUtil {
  static String generateSign(
      Map<String, List<String>> params, int timestamp, String key) {
    if (timestamp > 0) {
      params.putIfAbsent('timestamp', () => [timestamp.toString()]);
    }
    var sb = StringBuffer();
    try {
      if (params.isNotEmpty) {
        var map = SplayTreeMap<String, List<String>>.from(params);
        int index = 0, length = params.length;
        map.forEach((key, value) {
          if (value.isEmpty) {
            index++;
            return;
          }
          value.sort();
          sb
            ..write(key)
            ..write('=')
            ..write(StrUtil.listToStr(value, ','));
          if (index != length - 1) {
            sb.write('&');
          }
          index++;
        });
      }
      sb
        ..write('&key=')
        ..write(key);
    } catch (e) {
      Log.logPrint(e);
    }
    var sign = md5.convert(utf8.encode(sb.toString())).toString().toUpperCase();
    Log.d('params : ${sb.toString()}, sign : $sign');
    return sign;
  }
}
