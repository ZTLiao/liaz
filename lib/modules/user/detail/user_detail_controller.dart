import 'package:get/get.dart';
import 'package:liaz/models/db/user.dart';
import 'package:liaz/services/user_service.dart';

class UserDetailController extends GetxController {
  Rx<User> user = Rx<User>(User.empty());

  UserDetailController() {
    UserService.instance.get().then((value) {
      if (value != null) {
        user.value = value;
      }
    });
  }
}
