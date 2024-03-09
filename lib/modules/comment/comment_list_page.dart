import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/modules/comment/comment_list_controller.dart';
import 'package:liaz/routes/app_navigator.dart';
import 'package:liaz/widgets/keep_alive_wrapper.dart';
import 'package:liaz/widgets/toolbar/comment_item_widget.dart';
import 'package:liaz/widgets/view/page_list_view.dart';

class CommentListPage extends StatelessWidget {
  final int objId;
  final int objType;
  final CommentListController controller;

  CommentListPage(this.objId, this.objType, {super.key})
      : controller = Get.put(CommentListController(objId, objType));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          AppString.lastComments,
        ),
      ),
      body: KeepAliveWrapper(
        child: PageListView(
          pageController: controller,
          isFirstRefresh: true,
          separatorBuilder: (context, i) => Divider(
            endIndent: 12,
            indent: 12,
            color: Colors.grey.withOpacity(.2),
            height: 4,
          ),
          itemBuilder: (context, i) {
            var item = controller.list[i];
            return CommentItemWidget(
              item,
              onComment: (item) {
                AppNavigator.toPublishComment(
                  objId,
                  objType,
                  replyItem: item,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
