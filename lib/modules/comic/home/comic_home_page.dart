import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_color.dart';
import 'package:liaz/modules/comic/home/comic_home_controller.dart';
import 'package:liaz/routes/app_navigator.dart';
import 'package:liaz/widgets/toolbar/search_app_bar.dart';

class ComicHomePage extends GetView<ComicHomeController> {
  const ComicHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SearchAppBar(
          hintText: '搜索漫画',
          onTap: () {
            AppNavigator.toComicSearch(keyword: 'test....');
          },
        ),
      ),
      body: const Column(
        children: [
          Center(
            child: Text("comic",
                style: TextStyle(color: AppColor.black33)),
          ),
        ],
      ),
    );
  }
}
