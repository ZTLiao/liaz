import 'package:get/get.dart';
import 'package:liaz/app/global/global.dart';
import 'package:liaz/app/logger/log.dart';
import 'package:liaz/models/db/user.dart';
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
    var userCache = UserService.instance.get();
    if (userCache != null) {
      Global.isUserLogin = true;
      userCache.avatar =
          await AppConfigService.instance.getObject(userCache.avatar!);
      user.value = userCache;
      Log.i("avatar : ${user.value.avatar}");
    }
  }
}
