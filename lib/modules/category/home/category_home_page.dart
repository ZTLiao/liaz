import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_color.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/constants/app_style.dart';
import 'package:liaz/app/enums/skip_type_enum.dart';
import 'package:liaz/app/logger/log.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/models/dto/item_model.dart';
import 'package:liaz/modules/category/home/category_home_controller.dart';
import 'package:liaz/routes/app_navigator.dart';
import 'package:liaz/widgets/keep_alive_wrapper.dart';
import 'package:liaz/widgets/toolbar/search_app_bar.dart';
import 'package:liaz/widgets/toolbar/tab_app_bar.dart';
import 'package:liaz/widgets/toolbar/three_box_grid_widget.dart';
import 'package:liaz/widgets/view/page_list_view.dart';

class CategoryHomePage extends GetView<CategoryHomeController> {
  const CategoryHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SearchAppBar(
          onTap: () {
            AppNavigator.toSearch();
          },
        ),
      ),
      body: Scaffold(
        appBar: TabAppBar(
          selectedSize: 20,
          tabAlignment: TabAlignment.start,
          tabs: controller.assetTypes
              .map((e) => Tab(
                    text: e,
                  ))
              .toList(),
          controller: controller.tabController,
        ),
        body: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 5,
              child: ListView.separated(
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
                    height: 40,
                    decoration: BoxDecoration(
                      color: Get.isDarkMode ? Colors.white12 : AppColor.greyf0,
                    ),
                    child: Center(
                      child: TextButton(
                        onPressed: () {
                          controller.categoryId.value = item.categoryId;
                          Log.i("category index : ${i + 1}");
                          SmartDialog.showToast(AppString.skipError);
                        },
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(
                              Size(MediaQuery.of(context).size.width / 5, 40)),
                          shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                        ),
                        child: Obx(
                          () => Text(
                            item.categoryName,
                            style: TextStyle(
                              color:
                                  controller.categoryId.value == item.categoryId
                                      ? Colors.cyan
                                      : Get.isDarkMode
                                          ? Colors.white70
                                          : Colors.black54,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: controller.tabController,
                children:
                    controller.assetTypes.map((e) => buildListView()).toList(),
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
              var authors = StrUtil.listToStr(item.authors, StrUtil.slash);
              items.add(
                ItemModel(
                  itemId: item.categoryId,
                  title: item.title,
                  subTitle: authors,
                  showValue: item.cover,
                  skipType: SkipTypeEnum.h5.index,
                  skipValue: item.objId.toString(),
                  objId: item.objId,
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
