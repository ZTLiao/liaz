import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/requests/message_board_request.dart';

class MessageBoardController extends GetxController {
  var messageBoardRequest = MessageBoardRequest();

  TextEditingController content = TextEditingController();

  void welcome() {
    if (content.text.isEmpty) {
      return;
    }
    messageBoardRequest.welcome(content.text);
    SmartDialog.showToast(AppString.thankYou);
  }
}
