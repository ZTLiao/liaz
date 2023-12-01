import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/modules/comic/detail/comic_detail_controller.dart';
import 'package:remixicon/remixicon.dart';

class ComicDetailPage extends StatelessWidget {
  final int id;
  final ComicDetailController controller;

  ComicDetailPage(this.id, {super.key})
      : controller = Get.put(ComicDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "漫画详情",
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Remix.star_line),
          ),
          IconButton(
            onPressed: (){},
            icon: const Icon(Icons.share),
          ),
        ],
      ),
    );
  }
}
