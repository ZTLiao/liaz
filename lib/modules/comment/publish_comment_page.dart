import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/constants/app_style.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/models/comment/comment_item_model.dart';
import 'package:liaz/modules/comment/publish_comment_controller.dart';
import 'package:liaz/widgets/toolbar/upload_image_widget.dart';

class PublishCommentPage extends StatelessWidget {
  final int objId;
  final int objType;
  final CommentItemModel? replyItem;
  final PublishCommentController controller;

  PublishCommentPage(this.objId, this.objType, {this.replyItem, super.key})
      : controller = Get.put(
          PublishCommentController(
            objId,
            objType,
            replyItem: replyItem,
          ),
          tag: DateTime.now().millisecondsSinceEpoch.toString(),
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppString.addComment),
      ),
      body: ListView(
        padding: AppStyle.edgeInsetsA12,
        children: [
          Visibility(
            visible: replyItem != null,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.2),
                borderRadius: AppStyle.radius4,
              ),
              margin: AppStyle.edgeInsetsB12,
              padding: AppStyle.edgeInsetsA8,
              child: Text(
                  "${replyItem?.nickname}${StrUtil.semicolon} ${replyItem?.content}"),
            ),
          ),
          TextField(
            controller: controller.textEditingController,
            decoration: const InputDecoration(
              hintText: AppString.commentHint,
              border: OutlineInputBorder(),
            ),
            onSubmitted: (e) {
              controller.onPublish();
            },
            minLines: 4,
            maxLines: 6,
            maxLength: 1000,
          ),
          AppStyle.vGap12,
          UploadImageWidget(
            paths: controller.paths,
          ),
          AppStyle.vGap12,
          ElevatedButton(
            onPressed: controller.onPublish,
            child: const Text(AppString.publish),
          ),
        ],
      ),
    );
  }
}
