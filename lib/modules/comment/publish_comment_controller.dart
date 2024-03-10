import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/controller/base_controller.dart';
import 'package:liaz/app/enums/res_type_enum.dart';
import 'package:liaz/app/utils/dialog_util.dart';
import 'package:liaz/models/comment/comment_item_model.dart';
import 'package:liaz/requests/comment_request.dart';
import 'package:liaz/routes/app_navigator.dart';

class PublishCommentController extends BaseController {
  final int objId;
  final int objType;
  final CommentItemModel? replyItem;
  final List<String> paths = [];

  final TextEditingController textEditingController = TextEditingController();

  final commentRequest = CommentRequest();

  PublishCommentController(
    this.objId,
    this.objType, {
    this.replyItem,
  });

  void onPublish() async {
    if (textEditingController.text.isEmpty) {
      DialogUtil.showAlertDialog(AppString.contentError);
      return;
    }
    try {
      var parentId = 0;
      if (replyItem != null) {
        parentId = replyItem!.discussId;
      }
      await commentRequest.discuss(
        objId,
        objType,
        textEditingController.text,
        ResTypeEnum.image.index,
        paths,
        parentId: parentId,
      );
      SmartDialog.showToast(AppString.publishSuccess);
      AppNavigator.closePage();
    } catch (e) {
      SmartDialog.showToast(e.toString());
    }
  }
}
