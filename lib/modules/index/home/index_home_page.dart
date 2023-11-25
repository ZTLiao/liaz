import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_constant.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/modules/index/home/index_home_controller.dart';
import 'package:liaz/modules/index/recommend/index_recommend_view.dart';

class IndexHomePage extends GetView<IndexHomeController> {
  const IndexHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: DefaultTabController(
          length: AppConstant.kTabSize,
          child: Scaffold(
            appBar: AppBar(
              bottom: const TabBar(
                indicator: BoxDecoration(),
                tabs: [
                  Tab(text: AppString.recommend),
                  Tab(text: AppString.upgrade),
                  Tab(text: AppString.rank),
                ],
              ),
            ),
            body: TabBarView(
              //controller: controller.tabController,
              children: [
                IndexRecommendView(),
                Icon(Icons.directions_transit),
                Icon(Icons.directions_bike),
              ],
            ),
          ),
        ));
  }
}
