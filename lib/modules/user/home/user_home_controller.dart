import 'package:get/get.dart';
import 'package:liaz/models/db/user.dart';
import 'package:liaz/services/user_service.dart';

class UserHomeController extends GetxController {
  /// 用户信息
  Rx<User> user = Rx<User>(User.empty());

  @override
  void onInit() {
    var userCache = UserService.instance.get();
    if (userCache != null) {
      user.value = userCache;
    }
    super.onInit();
  }
}
