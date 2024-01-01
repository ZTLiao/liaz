import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/modules/bookshelf/home/bookshelf_home_page.dart';
import 'package:liaz/modules/category/home/category_home_page.dart';
import 'package:liaz/modules/index/home/index_home_page.dart';
import 'package:liaz/modules/user/home/user_home_page.dart';
import 'package:remixicon/remixicon.dart';

import 'index_controller.dart';

class IndexPage extends GetView<IndexController> {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Obx(
          () => Scaffold(
            body: IndexedStack(
              key: controller.indexKey,
              index: controller.index.value,
              children: [
                IndexHomePage(controller.index.value),
                CategoryHomePage(controller.index.value),
                BookshelfHomePage(controller.index.value),
                UserHomePage(controller.index.value),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: controller.index.value,
              onTap: controller.setIndex,
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Remix.home_2_line),
                  activeIcon: Icon(Remix.home_7_fill),
                  label: AppString.home,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Remix.bell_line),
                  activeIcon: Icon(Remix.bell_fill),
                  label: AppString.comic,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Remix.book_line),
                  activeIcon: Icon(Remix.book_open_fill),
                  label: AppString.novel,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Remix.outlet_line),
                  activeIcon: Icon(Remix.emotion_2_fill),
                  label: AppString.mine,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
