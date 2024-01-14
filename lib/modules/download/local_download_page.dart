import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_constant.dart';
import 'package:liaz/app/constants/app_style.dart';
import 'package:liaz/app/utils/date_util.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/models/dto/item_model.dart';
import 'package:liaz/modules/download/local_download_controller.dart';
import 'package:liaz/widgets/keep_alive_wrapper.dart';
import 'package:liaz/widgets/toolbar/three_box_grid_widget.dart';
import 'package:liaz/widgets/view/page_list_view.dart';

class LocalDownloadPage extends StatelessWidget {
  final LocalDownloadController controller;

  LocalDownloadPage({super.key})
      : controller = Get.put(LocalDownloadController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: controller.tabs.length,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: TabBar(
            controller: controller.tabController,
            indicator: const BoxDecoration(),
            tabs: controller.tabs.map((e) => Tab(text: e.value)).toList(),
            onTap: (index) {
              controller.onRefresh();
            },
          ),
        ),
        body: TabBarView(
          controller: controller.tabController,
          children: [
            buildListView(),
            buildListView(),
          ],
        ),
      ),
    );
  }

  Widget buildListView() {
    return KeepAliveWrapper(
      child: PageListView(
          pageController: controller,
          isLoadMore: true,
          isFirstRefresh: true,
          padding: AppStyle.edgeInsetsH12.copyWith(bottom: 12),
          itemBuilder: (context, i) {
            var list = controller.list[i];
            List<ItemModel> items = [];
            for (var i = 0, len = list.length; i < len; i++) {
              var item = list[i];
              String subTitle = StrUtil.empty;
              var upgradeChapter = item.upgradeChapter;
              if (upgradeChapter.isEmpty && item.updatedAt != 0) {
                subTitle = DateUtil.formatDate(item.updatedAt);
              } else {
                subTitle = upgradeChapter;
              }
              items.add(
                ItemModel(
                  itemId: item.categoryId,
                  title: item.title,
                  subTitle: subTitle,
                  showValue: item.cover,
                  skipType: item.assetType,
                  skipValue: item.objId.toString(),
                  objId: item.objId,
                  isUpgrade: item.isUpgrade,
                ),
              );
            }
            return ThreeBoxGridWidget(
              items: items,
            );
          }),
    );
  }
}
