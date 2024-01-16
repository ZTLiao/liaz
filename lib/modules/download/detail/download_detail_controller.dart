import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_event.dart';
import 'package:liaz/app/events/event_bus.dart';
import 'package:liaz/models/db/task.dart';
import 'package:liaz/modules/download/detail/download_delete_listener.dart';
import 'package:liaz/modules/download/detail/download_detail_listener.dart';
import 'package:liaz/services/task_service.dart';

class DownloadDetailController extends GetxController {
  String title;
  List<String> taskIds;

  var tasks = RxList<Task>([]);

  var checkIds = RxList<String>([]);

  DownloadDetailController({required this.title, required this.taskIds});

  @override
  void onInit() {
    EventBus.instance
        .subscribe(AppEvent.kDownloadUpdateTopic, DownloadDetailListener());
    EventBus.instance
        .subscribe(AppEvent.kDownloadDeleteTopic, DownloadDeleteListener());
    tasks.addAll(TaskService.instance.getTasks(taskIds));
    super.onInit();
  }

  void doUpdate(String taskId) {
    if (!taskIds.contains(taskId)) {
      return;
    }
    for (int i = 0; i < tasks.length; i++) {
      var task = tasks[i];
      if (task.taskId == taskId) {
        tasks[i] = TaskService.instance.get(taskId)!;
        break;
      }
    }
  }

  void check(String taskId) {
    if (checkIds.contains(taskId)) {
      checkIds.remove(taskId);
    } else {
      checkIds.add(taskId);
    }
  }

  void dismiss(String taskId) {
    taskIds.contains(taskId);
    tasks.removeWhere((element) => element.taskId == taskId);
    TaskService.instance.delete(taskId);
    EventBus.instance.publish(AppEvent.kDownloadDeleteTopic, taskId);
  }

  @override
  void onClose() {
    EventBus.instance.unSubscribe(AppEvent.kDownloadUpdateTopic);
    EventBus.instance.unSubscribe(AppEvent.kDownloadDeleteTopic);
    super.onClose();
  }

  void pause() {
    var list = TaskService.instance.taskQueues
        .where((element) => checkIds.contains(element.task.value.taskId));
    if (list.isEmpty) {
      return;
    }
    for (var task in list) {
      task.pause();
    }
  }

  void resume() {
    var list = TaskService.instance.taskQueues
        .where((element) => checkIds.contains(element.task.value.taskId));
    if (list.isEmpty) {
      return;
    }
    for (var task in list) {
      task.resume();
    }
  }
}
