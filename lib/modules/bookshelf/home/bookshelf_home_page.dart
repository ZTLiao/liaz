import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/constants/app_style.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/models/dto/item_model.dart';
import 'package:liaz/modules/bookshelf/home/bookshelf_home_controller.dart';
import 'package:liaz/services/user_service.dart';
import 'package:liaz/widgets/keep_alive_wrapper.dart';
import 'package:liaz/widgets/toolbar/three_box_grid_widget.dart';
import 'package:liaz/widgets/view/page_list_view.dart';

class BookshelfHomePage extends GetView<BookshelfHomeController> {
  final int index;

  const BookshelfHomePage(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    Map<int, String> sortTypes = {
      0: AppString.updateSort,
      1: AppString.subscribeSort,
      2: AppString.readSort,
    };
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              AppString.myBookshelf,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            PopupMenuButton(
              onSelected: (e) {
                UserService.instance.check();
                controller.sortType.value = e;
                controller.onRefresh();
              },
              itemBuilder: (c) => sortTypes.keys
                  .map(
                    (k) => CheckedPopupMenuItem(
                      value: k,
                      checked: controller.sortType.value == k,
                      child: Text(sortTypes[k] ?? StrUtil.empty),
                    ),
                  )
                  .toList(),
              child: const SizedBox(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      AppString.operate,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          TabBar(
            controller: controller.tabController,
            labelPadding: AppStyle.edgeInsetsH24,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Theme.of(context).colorScheme.primary,
            labelColor: Theme.of(context).colorScheme.primary,
            unselectedLabelColor:
                Get.isDarkMode ? Colors.white70 : Colors.black87,
            tabs: controller.bookshelfs.map((e) => Tab(text: e.value)).toList(),
            onTap: (index) {
              UserService.instance.check();
              controller.onRefresh();
            },
          ),
          Expanded(
            child: IndexedStack(
              index: controller.tabController.index,
              children: [
                buildListView(),
                buildListView(),
              ],
            ),
          ),
        ],
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
              items.add(
                ItemModel(
                  itemId: item.categoryId,
                  title: item.title,
                  subTitle: item.upgradeChapter,
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
              onTap: controller.onReadChapter,
            );
          }),
    );
  }
}
