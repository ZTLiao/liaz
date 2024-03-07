import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_color.dart';
import 'package:liaz/app/utils/str_util.dart';

class CommentNavigationBar extends StatelessWidget {
  final String hintText;
  final bool readOnly;
  final bool autofocus;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Function()? onTap;
  final ValueChanged<String>? onSubmitted;

  const CommentNavigationBar(
      {this.hintText = StrUtil.empty,
      this.readOnly = false,
      this.autofocus = false,
      this.controller,
      this.focusNode,
      this.onTap,
      this.onSubmitted,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      decoration: BoxDecoration(
        color: Colors.white54,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 32,
            height: 24,
            child: Icon(
              Icons.comment_outlined,
              size: 16,
              color: Get.isDarkMode ? Colors.white70 : AppColor.grey99,
            ),
          ),
          Expanded(
            child: TextField(
              focusNode: focusNode,
              readOnly: readOnly,
              controller: controller,
              autofocus: autofocus,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: TextStyle(
                  fontSize: 13,
                  color: Get.isDarkMode ? Colors.white70 : AppColor.grey99,
                ),
              ),
              onTap: onTap,
              onSubmitted: onSubmitted, // onTap
            ),
          ),
        ],
      ),
    );
  }
}
