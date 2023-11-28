import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_color.dart';
import 'package:liaz/modules/bookshelf/home/bookshelf_home_controller.dart';

class BookshelfHomePage extends GetView<BookshelfHomeController> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Text("bookshelf", style: TextStyle(color: AppColor.black33)),
      ),
    );
  }
}
