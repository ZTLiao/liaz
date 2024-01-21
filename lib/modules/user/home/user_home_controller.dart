import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/global/global.dart';
import 'package:liaz/app/logger/log.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/models/db/user.dart';
import 'package:liaz/routes/app_navigator.dart';
import 'package:liaz/services/user_service.dart';

class UserHomeController extends GetxController {
  /// 用户信息
  Rx<User> user = Rx<User>(User.empty());

  RxString avatar = RxString(StrUtil.empty);

  RxString nickname = RxString(StrUtil.empty);

  @override
  void onInit() {
    updateUser();
    super.onInit();
  }

  void updateUser() async {
    user.value = User.empty();
    avatar.value = StrUtil.empty;
    nickname.value = StrUtil.empty;
    UserService.instance.get().then((value) async {
      if (value != null) {
        Global.isUserLogin = true;
        user.value = value;
        avatar.value = value.avatar;
        nickname.value = value.nickname;
      }
      Log.i("avatar : ${avatar.value},  nickname : ${nickname.value}");
    });
  }

  void onUserDetail() async {
    if (Global.isUserLogin) {
      await AppNavigator.toUserDetail();
      updateUser();
    } else {
      UserService.instance.check();
    }
  }

  void shareApp() {
    var downloadApp = Global.appConfig.downloadApp;
    if (downloadApp.isEmpty) {
      SmartDialog.showToast(AppString.notYetOpen);
      return;
    }
    AppNavigator.toWebView(downloadApp);
  }
}
