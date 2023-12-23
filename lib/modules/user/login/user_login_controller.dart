import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/enums/grant_type_enum.dart';
import 'package:liaz/app/logger/log.dart';
import 'package:liaz/requests/user_request.dart';
import 'package:liaz/routes/app_navigator.dart';
import 'package:remixicon/remixicon.dart';

class UserLoginController extends GetxController {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  /// 是否显示明文
  RxBool isShowPassword = RxBool(true);
  final List thirdLogin = [
    {
      "title": "apple",
      "icon": Remix.apple_line,
    },
    {
      "title": "google",
      "icon": Remix.google_line,
    },
  ];

  var userRequest = UserRequest();

  void signIn() async {
    if (password.text.isEmpty) {
      return;
    }
    var encryptPassword = md5.convert(utf8.encode(password.text)).toString();
    Log.i("password : ${password.text}, encryptPassword : $encryptPassword");
    var token = await userRequest.signIn(
        username.text, encryptPassword, GrantTypeEnum.password.name);
    if (token.accessToken.isNotEmpty) {
      Get.back();
    } else {
      SmartDialog.showToast(AppString.usernameOrPasswordError);
    }
  }
}
