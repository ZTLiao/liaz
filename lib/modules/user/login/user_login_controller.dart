import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';

class UserLoginController extends GetxController {
  late String email, password;
  bool isObscure = true;
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
}
