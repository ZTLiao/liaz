import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class ToolUtil {
  /// 复制文本
  static void copyText(String text) async {
    try {
      await Clipboard.setData(ClipboardData(text: text));
      SmartDialog.showToast("已复制到剪切板");
    } catch (e) {
      SmartDialog.showToast(e.toString());
    }
  }
}
