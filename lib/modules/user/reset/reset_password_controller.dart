import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/requests/verify_code_request.dart';

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

  RxInt countdown = RxInt(90);

  var verifyCodeRequest = VerifyCodeRequest();

  void sendVerifyCode() {
    isWaitVerify.value = true;
    decrement();
    verifyCodeRequest.sendVerifyCodeForEmail(email.text);
  }

  void confirmVerifyCode() {}

  void decrement() async {
    while (countdown.value > 0) {
      await Future.delayed(const Duration(seconds: 1), () {
        countdown.value--;
      });
    }
    isWaitVerify.value = false;
    countdown.value = 60;
  }

  void resetPassword() {}
}
