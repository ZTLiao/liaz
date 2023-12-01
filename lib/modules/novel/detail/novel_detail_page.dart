import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/modules/novel/detail/novel_detail_controller.dart';

class NovelDetailPage extends StatelessWidget {
  final int id;
  final NovelDetailController controller;

  NovelDetailPage(this.id, {super.key})
      : controller = Get.put(NovelDetailController());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
