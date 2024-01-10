import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:liaz/app/logger/log.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:screen_brightness/screen_brightness.dart';

class BaseController extends GetxController {
  /// 加载中(更新页面)
  var isPageLoading = RxBool(false);

  /// 加载中(不更新页面)
  var isLoading = false;

  /// 空白页面
  var isPageEmpty = RxBool(false);

  /// 页面异常
  var isPageError = RxBool(false);

  /// 未登录
  var isNotLogin = RxBool(false);

  /// 错误信息
  var errorMsg = RxString(StrUtil.empty);

  /// 异常
  Error? error;

  void except(Object exception, {bool isShowPageError = false}) {
    Log.logPrint(exception);
    if (exception is Error) {
      error = exception;
    }
    isPageError.value = isShowPageError;
    errorMsg.value =
        exception.toString().replaceAll("Exception:", StrUtil.empty);
    if (!isShowPageError) {
      SmartDialog.showToast(errorMsg.value);
    }
  }

  Future<double> get systemBrightness async {
    try {
      return await ScreenBrightness().system;
    } catch (error, stackTrace) {
      Log.e(error.toString(), stackTrace);
      rethrow;
    }
  }

  Future<double> get currentBrightness async {
    try {
      return await ScreenBrightness().current;
    } catch (error, stackTrace) {
      Log.e(error.toString(), stackTrace);
      rethrow;
    }
  }

  Future<void> setBrightness(double brightness) async {
    try {
      await ScreenBrightness().setScreenBrightness(brightness);
    } catch (error, stackTrace) {
      Log.e(error.toString(), stackTrace);
      rethrow;
    }
  }
}
