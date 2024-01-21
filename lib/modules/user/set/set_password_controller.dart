import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/services/user_service.dart';

class SetPasswordController extends GetxController {
  /// 是否显示明文
  RxBool isShowPassword = RxBool(true);

  /// 是否显示明文
  RxBool isShowConfirmPassword = RxBool(true);

  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  void setPassword() async {
    if (password.text.isEmpty) {
      return;
    }
    if (password.text.isNotEmpty && password.text.length < 6) {
      SmartDialog.showToast(AppString.passwordShortError);
      return;
    }
    if (password.text != confirmPassword.text) {
      SmartDialog.showToast(AppString.passwordAndConfirmPasswordNoSameError);
      return;
    }
    if (await UserService.instance.setPassword(password.text)) {
      SmartDialog.showToast(AppString.setSuccess);
    }
  }
}
