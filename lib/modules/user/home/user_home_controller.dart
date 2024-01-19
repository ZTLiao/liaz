import 'package:get/get.dart';
import 'package:liaz/app/global/global.dart';
import 'package:liaz/app/logger/log.dart';
import 'package:liaz/models/db/user.dart';
import 'package:liaz/routes/app_navigator.dart';
import 'package:liaz/services/app_config_service.dart';
import 'package:liaz/services/user_service.dart';

class UserHomeController extends GetxController {
  /// 用户信息
  Rx<User> user = Rx<User>(User.empty());

  @override
  void onInit() {
    updateUser();
    super.onInit();
  }

  void updateUser() async {
    UserService.instance.get().then((value) async {
      if (value != null) {
        Global.isUserLogin = true;
        user.value = value;
      }
      Log.i("avatar : ${user.value.avatar}");
    });
  }

  void onUserDetail() {
    if (Global.isUserLogin) {
      AppNavigator.toUserDetail();
    } else {
      UserService.instance.check();
    }
  }
}
