import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_event.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/events/event_bus.dart';
import 'package:liaz/modules/user/login/user_login_listener.dart';
import 'package:liaz/routes/app_navigator.dart';
import 'package:liaz/services/user_service.dart';
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

  @override
  void onInit() {
    EventBus.instance.subscribe(AppEvent.userLoginTopic, UserLoginListener());
    super.onInit();
  }

  void signIn() async {
    if (password.text.isEmpty) {
      return;
    }
    var isLogin =
        await UserService.instance.signIn(username.text, password.text);
    if (isLogin) {
      Get.back();
    } else {
      SmartDialog.showToast(AppString.usernameOrPasswordError);
    }
  }

  void signUp() {
    AppNavigator.toUserRegister();
  }
}
