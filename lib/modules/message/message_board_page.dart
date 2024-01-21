import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/constants/app_style.dart';
import 'package:liaz/modules/message/message_board_controller.dart';

class MessageBoardPage extends GetView<MessageBoardController> {
  const MessageBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(AppString.messageBoardWelcome),
      ),
      body: ListView(
        children: [
          TextField(
            controller: controller.content,
            decoration: const InputDecoration(
              hintText: AppString.messageBoardRemark,
              border: OutlineInputBorder(),
            ),
            onSubmitted: (e) {},
            minLines: 4,
            maxLines: 6,
            maxLength: 1000,
          ),
          AppStyle.vGap32,
          buildSubmitButton(),
        ],
      ),
    );
  }

  Widget buildSubmitButton() {
    return Align(
      child: SizedBox(
        height: 45,
        width: 270,
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              const StadiumBorder(
                side: BorderSide(
                  style: BorderStyle.none,
                ),
              ),
            ),
            backgroundColor: MaterialStateProperty.resolveWith(
              (states) {
                if (states.contains(MaterialState.pressed)) {
                  return Colors.black;
                }
                return Colors.cyan;
              },
            ),
          ),
          onPressed: controller.welcome,
          child: const Text(
            AppString.submit,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
