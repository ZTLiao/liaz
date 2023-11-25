import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_color.dart';
import 'package:liaz/modules/comic/home/comic_home_controller.dart';

class ComicHomePage extends GetView<ComicHomeController> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Text("comic",
            style: TextStyle(color: AppColor.black33)),
      ),
    );
  }

}