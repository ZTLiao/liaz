import 'package:flutter/material.dart';
import 'package:liaz/app/constants/app_color.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:remixicon/remixicon.dart';

class SearchAppBar extends StatelessWidget {
  final String hintText;
  final bool readOnly;
  final bool autofocus;
  final TextEditingController? controller;
  final Function()? onTap;

  const SearchAppBar(
      {this.hintText = StrUtil.empty,
      this.readOnly = true,
      this.autofocus = false,
      this.controller,
      this.onTap,
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
              Remix.search_line,
              size: 16,
              color: Color(0xFF999999),
            ), //搜索框图标
          ),
          Expanded(
            child: TextField(
              readOnly: readOnly,
              //只读不可编辑，点击搜索框直接跳转搜索页
              controller: controller,
              autofocus: autofocus,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText, //搜索提示词
                hintStyle: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF999999),
                ), //搜索框文字样式
              ),
              onTap: onTap, //onTap
            ),
          ),
        ],
      ),
    );
  }
}
