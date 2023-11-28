import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_color.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/modules/search/home/search_home_controller.dart';
import 'package:liaz/widgets/toolbar/search_app_bar.dart';

class SearchHomePage extends StatelessWidget {
  final SearchHomeController controller;

  SearchHomePage({super.key}) : controller = Get.put(SearchHomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SearchAppBar(
          readOnly: false,
          autofocus: true,
          hintText: AppString.searchAlert,
          controller: controller.searchController,
          onTap: () {},
        ),
      ),
      body: const Center(
        child: Text(
          "search",
          style: TextStyle(color: AppColor.black33),
        ),
      ),
    );
  }
}
