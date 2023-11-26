import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/modules/comic/upgrade/comic_upgrade_view.dart';
import 'package:liaz/modules/index/upgrade/index_upgrade_controller.dart';
import 'package:liaz/modules/novel/upgrade/novel_upgrade_view.dart';
import 'package:liaz/widgets/toolbar/tab_app_bar.dart';

class IndexUpgradeView extends StatelessWidget {
  final IndexUpgradeController controller;

  IndexUpgradeView({super.key})
      : controller = Get.put(IndexUpgradeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabAppBar(
        isScrollable: false,
        tabs: const [
          Tab(text: AppString.comic),
          Tab(text: AppString.novel),
        ],
        controller: controller.tabController,
      ),
      body: TabBarView(
        controller: controller.tabController,
        children: [
          ComicUpgradeView(),
          NovelUpgradeView(),
        ],
      ),
    );
  }
}
