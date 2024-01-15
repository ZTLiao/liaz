import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/modules/download/detail/download_detail_controller.dart';

class DownloadDetailPage extends StatelessWidget {
  final List<String> taskIds;
  final DownloadDetailController controller;

  DownloadDetailPage(this.taskIds, {super.key})
      : controller = Get.put(
          DownloadDetailController(
            taskIds: taskIds,
          ),
          tag: DateTime.now().millisecondsSinceEpoch.toString(),
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Text('download detail'),
      ),
    );
  }
}
