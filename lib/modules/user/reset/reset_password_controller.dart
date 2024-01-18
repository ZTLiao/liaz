import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/requests/verify_code_request.dart';
import 'package:liaz/routes/app_navigator.dart';
import 'package:liaz/services/user_service.dart';

class ResetPasswordController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController verifyCode = TextEditingController();
  TextEditingController newPassword = TextEditingController();

  /// 是否展示新密码
  RxBool isShowNewPassword = RxBool(true);

  /// 是否有验证码
  RxBool hasVerifyCode = RxBool(false);

  /// 是否等待验证
  RxBool isWaitVerify = RxBool(false);

  RxInt countdown = RxInt(60);

  var verifyCodeRequest = VerifyCodeRequest();

  void sendVerifyCode() {
    isWaitVerify.value = true;
    decrement();
    verifyCodeRequest
        .sendVerifyCodeForEmail(email.text)
        .then((value) => SmartDialog.showToast(AppString.sendSuccess));
  }

  void confirmVerifyCode() async {
    var isVerify =
        await verifyCodeRequest.checkVerifyCode(email.text, verifyCode.text);
    if (isVerify) {
      hasVerifyCode.value = true;
    } else {
      SmartDialog.showToast(AppString.verifyCodeFail);
    }
  }

  void decrement() async {
    while (countdown.value > 0) {
      await Future.delayed(const Duration(seconds: 1), () {
        countdown.value--;
      });
    }
    isWaitVerify.value = false;
    countdown.value = 60;
  }

  void resetPassword() async {
    if (newPassword.text.isEmpty) {
      return;
    }
    var isSuccess = await UserService.instance
        .resetPassword(email.text, verifyCode.text, newPassword.text);
    if (isSuccess) {
      SmartDialog.showToast(AppString.resetPasswordForSuccess);
      AppNavigator.closePage();
    } else {
      SmartDialog.showToast(AppString.resetPasswordForFail);
    }
  }
}
