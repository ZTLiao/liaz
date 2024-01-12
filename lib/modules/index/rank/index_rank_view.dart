import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/enums/asset_type_enum.dart';
import 'package:liaz/app/enums/time_type_enum.dart';
import 'package:liaz/modules/index/rank/index_rank_controller.dart';
import 'package:liaz/widgets/keep_alive_wrapper.dart';
import 'package:liaz/widgets/toolbar/card_item_widget.dart';
import 'package:liaz/widgets/toolbar/rank_item_widget.dart';
import 'package:liaz/widgets/toolbar/select_app_bar.dart';
import 'package:liaz/widgets/toolbar/tab_app_bar.dart';
import 'package:liaz/widgets/view/page_list_view.dart';

class IndexRankView extends StatelessWidget {
  final IndexRankController controller;

  IndexRankView({super.key}) : controller = Get.put(IndexRankController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: TabAppBar(
          isScrollable: true,
          tabs: controller.tabs
              .map(
                (e) => Tab(
                  text: e,
                ),
              )
              .toList(),
          onTap: (v) {
            controller.onRefresh();
          },
          controller: controller.tabController,
          action: Column(
            children: [
              Expanded(
                child: SelectAppBar(
                  types: {
                    AssetTypeEnum.comic.index: AppString.comic,
                    AssetTypeEnum.novel.index: AppString.novel,
                  },
                  value: controller.assetType.value,
                  onSelected: (v) {
                    controller.assetType.value = v;
                    controller.onRefresh();
                  },
                ),
              ),
              Expanded(
                child: SelectAppBar(
                  types: {
                    TimeTypeEnum.day.index: AppString.dayRank,
                    TimeTypeEnum.week.index: AppString.weekRank,
                    TimeTypeEnum.month.index: AppString.monthRank,
                    TimeTypeEnum.total.index: AppString.totalRank,
                  },
                  value: controller.timeType.value,
                  onSelected: (v) {
                    controller.timeType.value = v;
                    controller.onRefresh();
                  },
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: controller.tabController,
          children: [
            buildListView(),
            buildListView(),
            buildListView(),
          ],
        ),
      ),
    );
  }

  /// 榜单
  Widget buildListView() {
    return KeepAliveWrapper(
      child: PageListView(
          pageController: controller,
          separatorBuilder: (context, i) => Divider(
                endIndent: 12,
                indent: 12,
                color: Colors.grey.withOpacity(.2),
                height: 1,
              ),
          itemBuilder: (context, i) {
            var card = controller.list[i];
            return RankItemWidget(
              index: (i + 1),
              child: Expanded(
                child: CardItemWidget(
                  card: card,
                ),
              ),
            );
          }),
    );
  }
}
