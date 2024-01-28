import 'package:flutter/services.dart';
import 'package:sim_card_info/sim_card_info.dart';
import 'package:sim_card_info/sim_info.dart';

class SimInfoUtil {
  static final _simCardInfoPlugin = SimCardInfo();

  static List<SimInfo>? simCardInfo;

  static Future<List<SimInfo>> getSimInfo() async {
    if (simCardInfo == null) {
      try {
        simCardInfo = await _simCardInfoPlugin.getSimInfo() ?? [];
      } on PlatformException {
        simCardInfo = [];
      }
    }
    return simCardInfo!;
  }
}
