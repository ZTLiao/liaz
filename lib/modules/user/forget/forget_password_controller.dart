import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController verifyCode = TextEditingController();
  TextEditingController newPassword = TextEditingController();

  /// 是否展示新密码
  RxBool isShowNewPassword = RxBool(true);

  void resetPassword() {}
}
