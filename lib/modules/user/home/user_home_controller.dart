import 'package:get/get.dart';
import 'package:liaz/app/global/global.dart';
import 'package:liaz/models/db/user.dart';
import 'package:liaz/services/app_config_service.dart';
import 'package:liaz/services/user_service.dart';

class UserHomeController extends GetxController {
  /// 用户信息
  Rx<User> user = Rx<User>(User.empty());

  @override
  void onInit() async {
    var userCache = UserService.instance.get();
    if (userCache != null) {
      Global.isUserLogin = true;
      user.value = userCache;
      user.value.avatar =
          await AppConfigService.instance.getObject(userCache.avatar!);
    }
    super.onInit();
  }
}
