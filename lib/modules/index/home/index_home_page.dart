import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_constant.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/modules/index/home/index_home_controller.dart';
import 'package:liaz/modules/index/rank/index_rank_view.dart';
import 'package:liaz/modules/index/recommend/index_recommend_view.dart';
import 'package:liaz/modules/index/upgrade/index_upgrade_view.dart';

class IndexHomePage extends StatelessWidget {
  final IndexHomeController controller;

  IndexHomePage({super.key}) : controller = Get.put(IndexHomeController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: AppConstant.kTabSize,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const TabBar(
            indicator: BoxDecoration(),
            tabs: [
              Tab(text: AppString.recommend),
              Tab(text: AppString.upgrade),
              Tab(text: AppString.rank),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            IndexRecommendView(),
            IndexUpgradeView(),
            IndexRankView(),
          ],
        ),
      ),
    );
  }
}
