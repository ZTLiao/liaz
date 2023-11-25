import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_color.dart';
import 'package:liaz/modules/user/home/user_home_controller.dart';

class UserHomePage extends GetView<UserHomeController> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Text("user",
            style: TextStyle(color: AppColor.black33)),
      ),
    );
  }

}