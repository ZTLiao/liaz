import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/modules/bookshelf/home/bookshelf_home_page.dart';
import 'package:liaz/modules/category/home/category_home_page.dart';
import 'package:liaz/modules/index/home/index_home_page.dart';
import 'package:liaz/modules/user/home/user_home_page.dart';

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
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home),
                  label: AppString.home,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.notifications_none),
                  activeIcon: Icon(Icons.notifications_active_rounded),
                  label: AppString.category,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.import_contacts),
                  activeIcon: Icon(Icons.menu_book),
                  label: AppString.bookshelf,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  activeIcon: Icon(Icons.person),
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
