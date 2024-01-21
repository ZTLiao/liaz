import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/modules/browse/browse_history_controller.dart';
import 'package:liaz/widgets/toolbar/card_item_widget.dart';
import 'package:liaz/widgets/view/page_list_view.dart';

class BrowseHistoryPage extends GetView<BrowseHistoryController> {
  const BrowseHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(AppString.browse),
      ),
      body: PageListView(
        pageController: controller,
        isLoadMore: true,
        separatorBuilder: (context, i) => Divider(
          endIndent: 12,
          indent: 12,
          color: Colors.grey.withOpacity(.2),
          height: 1,
        ),
        itemBuilder: (context, i) {
          return CardItemWidget(
            card: controller.list[i],
            onTap: controller.onDetail,
            onOpen: (v) {
              controller.onReadChapter(controller.list[i]);
            },
          );
        },
      ),
    );
  }
}
