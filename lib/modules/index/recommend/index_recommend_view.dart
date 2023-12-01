import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_style.dart';
import 'package:liaz/app/enums/show_type_enum.dart';
import 'package:liaz/models/dto/item_model.dart';
import 'package:liaz/models/dto/title_model.dart';
import 'package:liaz/modules/index/recommend/index_recommend_controller.dart';
import 'package:liaz/routes/app_navigator.dart';
import 'package:liaz/widgets/keep_alive_wrapper.dart';
import 'package:liaz/widgets/toolbar/swiper_widget.dart';
import 'package:liaz/widgets/toolbar/title_widget.dart';
import 'package:liaz/widgets/toolbar/three_box_grid_widget.dart';
import 'package:liaz/widgets/toolbar/two_box_grid_widget.dart';
import 'package:liaz/widgets/toolbar/cross_list_widget.dart';
import 'package:liaz/widgets/view/page_list_view.dart';

class IndexRecommendView extends StatelessWidget {
  final IndexRecommendController controller;

  IndexRecommendView({super.key})
      : controller = Get.put(IndexRecommendController());

  @override
  Widget build(BuildContext context) {
    return KeepAliveWrapper(
      child: PageListView(
        pageController: controller,
        padding: AppStyle.edgeInsetsH12,
        itemBuilder: (context, i) {
          var recommend = controller.list[i];
          var showType = recommend.showType;
          var title = TitleModel(
            titleId: recommend.recommendId,
            title: recommend.title,
            showType: recommend.showType,
            showTitle: recommend.showTitle,
            optType: recommend.optType,
            optValue: recommend.optValue,
          );
          var items = <ItemModel>[];
          for (var i = 0; i < recommend.items.length; i++) {
            var item = recommend.items[i];
            items.add(ItemModel(
              itemId: item.recommendItemId,
              title: item.title,
              subTitle: item.subTitle,
              showValue: item.showValue,
              skipType: item.skipType,
              skipValue: item.skipValue,
              objId: item.objId,
            ));
          }
          if (showType == ShowTypeEnum.banner.index) {
            return TitleWidget(
              item: title,
              child: SwiperWidget(
                items: items,
                onTop: (item) => AppNavigator.toComicDetail(1),
              ),
            );
          } else if (showType == ShowTypeEnum.twoGrid.index) {
            return TitleWidget(
              item: title,
              child: TwoBoxGridWidget(
                items: items,
                onTop: (item) => AppNavigator.toComicDetail(1),
              ),
            );
          } else if (showType == ShowTypeEnum.threeGrid.index) {
            return TitleWidget(
              item: title,
              child: ThreeBoxGridWidget(
                items: items,
                onTop: (item) => AppNavigator.toComicDetail(1),
              ),
            );
          }
          return TitleWidget(
            item: title,
            child: CrossListWidget(
              items: items,
              onTop: (item) => AppNavigator.toComicDetail(1),
            ),
          );
        },
      ),
    );
  }
}
