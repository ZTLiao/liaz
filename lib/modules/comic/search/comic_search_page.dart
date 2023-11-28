import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_color.dart';
import 'package:liaz/app/logger/log.dart';
import 'package:liaz/app/utils/str_util.dart';

class ComicSearchPage extends StatelessWidget {
  final String? keyword;

  const ComicSearchPage({this.keyword = StrUtil.empty, super.key});

  @override
  Widget build(BuildContext context) {
    var str = Get.arguments['keyword'];
    Log.i("keyword : $keyword, str : $str");
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Text("search",
            style: TextStyle(color: AppColor.black33)),
      ),
    );
  }
}
