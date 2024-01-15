import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/models/db/task.dart';
import 'package:liaz/services/task_service.dart';

class DownloadDetailController extends GetxController {
  List<String> taskIds;

  var tasks = RxList<Task>([]);

  DownloadDetailController({required this.taskIds});

  @override
  void onInit() {
    tasks.addAll(TaskService.instance.getTasks(taskIds));
    super.onInit();
  }

  void doNothing(BuildContext context) {}

  void dismiss(String taskId) {
    taskIds.contains(taskId);
    tasks.removeWhere((element) => element.taskId == taskId);
  }
}
