import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_style.dart';
import 'package:liaz/models/banner/banner_model.dart';
import 'package:liaz/modules/index/recommend/index_recommend_controller.dart';
import 'package:liaz/widgets/keep_alive_wrapper.dart';
import 'package:liaz/widgets/toolbar/banner_widget.dart';
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
        isFirstRefresh: true,
        isLoadMore: false,
        isShowPageLoading: true,
        itemBuilder: (context, i) {
          var banners = <BannerModel>[];
          var items = controller.list[i].items;
          for (var i = 0; i < items.length; i++) {
            var item = items[i];
            banners.add(BannerModel(
              bannerId: item.objId,
              title: item.title,
              url: item.showValue,
              skipType: item.skipType,
              skipValue: item.skipValue,
            ));
          }
          return BannerWidget(
            banners: banners,
          );
        },
      ),
    );
  }
}
