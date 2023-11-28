import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_color.dart';
import 'package:liaz/modules/category/home/category_home_controller.dart';
import 'package:liaz/routes/app_navigator.dart';
import 'package:liaz/widgets/toolbar/search_app_bar.dart';
import 'package:liaz/widgets/toolbar/tab_app_bar.dart';

class CategoryHomePage extends GetView<CategoryHomeController> {
  const CategoryHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SearchAppBar(
          onTap: () {
            AppNavigator.toComicSearch(keyword: 'test....');
          },
        ),
      ),
      body: Scaffold(
        appBar: TabAppBar(
          selectedSize: 20,
          tabAlignment: TabAlignment.start,
          tabs: controller.categories
              .map((e) => Tab(
                    text: e,
                  ))
              .toList(),
          controller: controller.tabController,
        ),
        body: TabBarView(
          controller: controller.tabController,
          children: controller.categories
              .map((e) => Center(
                    child: Text(e,
                        style: const TextStyle(color: AppColor.black33)),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
