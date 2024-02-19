import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_color.dart';
import 'package:liaz/app/constants/app_style.dart';
import 'package:liaz/app/enums/asset_type_enum.dart';
import 'package:liaz/app/logger/log.dart';
import 'package:liaz/models/dto/item_model.dart';
import 'package:liaz/modules/category/home/category_home_controller.dart';
import 'package:liaz/routes/app_navigator.dart';
import 'package:liaz/widgets/keep_alive_wrapper.dart';
import 'package:liaz/widgets/toolbar/search_app_bar.dart';
import 'package:liaz/widgets/toolbar/tab_app_bar.dart';
import 'package:liaz/widgets/toolbar/three_box_grid_widget.dart';
import 'package:liaz/widgets/view/page_list_view.dart';

class CategoryHomePage extends StatelessWidget {
  final CategoryHomeController controller;

  CategoryHomePage({super.key})
      : controller = Get.put(CategoryHomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SearchAppBar(
          readOnly: true,
          onTap: () {
            AppNavigator.toSearch();
          },
        ),
      ),
      body: Scaffold(
        appBar: TabAppBar(
          selectedSize: 20,
          tabAlignment: TabAlignment.start,
          tabs: AssetTypeEnum.values
              .map((e) => Tab(
                    text: e.value,
                  ))
              .toList(),
          controller: controller.tabController,
          onTap: controller.setIndex,
        ),
        body: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 5,
              child: Obx(
                () => ListView.separated(
                  separatorBuilder: (context, i) {
                    return Divider(
                      endIndent: 12,
                      indent: 12,
                      color: Colors.grey.withOpacity(0),
                      height: 1,
                    );
                  },
                  itemCount: controller.categories.value.length,
                  itemBuilder: (context, i) {
                    var item = controller.categories.value[i];
                    return Container(
                      decoration: BoxDecoration(
                        color:
                            Get.isDarkMode ? Colors.white12 : AppColor.greyf0,
                      ),
                      child: Center(
                        child: TextButton(
                          onPressed: () {
                            controller.categoryId.value = item.categoryId;
                            Log.i(
                                "category index : ${i + 1}, categoryId : ${controller.categoryId.value}");
                            controller.onRefresh();
                          },
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(Size(
                                MediaQuery.of(context).size.width / 5, 40)),
                            shape: MaterialStateProperty.all(
                              const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                          ),
                          child: Obx(
                            () => Text(
                              item.categoryName,
                              maxLines:
                                  controller.categoryId.value == item.categoryId
                                      ? null
                                      : 1,
                              style: TextStyle(
                                color: controller.categoryId.value ==
                                        item.categoryId
                                    ? Colors.cyan
                                    : Get.isDarkMode
                                        ? Colors.white70
                                        : Colors.black54,
                                overflow: controller.categoryId.value ==
                                        item.categoryId
                                    ? null
                                    : TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: controller.tabController,
                children: AssetTypeEnum.values
                    .map(
                      (e) => buildListView(),
                    )
                    .toList(),
              ),
            ),
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
          padding: AppStyle.edgeInsetsH12.copyWith(bottom: 12),
          itemBuilder: (context, i) {
            var list = controller.list[i];
            List<ItemModel> items = [];
            for (var i = 0, len = list.length; i < len; i++) {
              var item = list[i];
              items.add(
                ItemModel(
                  itemId: item.categoryId,
                  title: item.title,
                  subTitle: item.upgradeChapter,
                  showValue: item.cover,
                  skipType: item.assetType,
                  skipValue: item.chapterId.toString(),
                  objId: item.objId,
                ),
              );
            }
            return ThreeBoxGridWidget(
              items: items,
              onTap: controller.onReadChapter,
            );
          }),
    );
  }
}
