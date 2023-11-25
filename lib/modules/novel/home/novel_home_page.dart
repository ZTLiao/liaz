import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_color.dart';
import 'package:liaz/modules/novel/home/novel_home_controller.dart';

class NovelHomePage extends GetView<NovelHomeController> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Text("novel",
            style: TextStyle(color: AppColor.black33)),
      ),
    );
  }

}