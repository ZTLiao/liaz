import 'package:flutter/material.dart';
import 'package:liaz/app/constants/app_color.dart';
import 'package:liaz/app/utils/str_util.dart';

class SearchAppBar extends StatelessWidget {
  final String hintText;
  final bool readOnly;
  final bool autofocus;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Function()? onTap;
  final ValueChanged<String>? onSubmitted;

  const SearchAppBar(
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
      height: 32, //搜索框高度
      decoration: BoxDecoration(
        color: AppColor.greyf0,
        borderRadius: BorderRadius.circular(16), // 设置搜索框圆角
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 32,
            height: 24,
            child: Icon(
              Icons.search,
              size: 16,
              color: AppColor.grey99,
            ), //搜索框图标
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
                hintStyle: const TextStyle(
                  fontSize: 13,
                  color: AppColor.grey99,
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
