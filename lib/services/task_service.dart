import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:liaz/app/constants/db.dart';
import 'package:liaz/app/enums/download_status_enum.dart';
import 'package:liaz/models/db/task.dart';
import 'package:liaz/models/dto/download_task.dart';
import 'package:path_provider/path_provider.dart';

class TaskService {
  static TaskService get instance {
    if (Get.isRegistered<TaskService>()) {
      return Get.find<TaskService>();
    }
    return Get.put(TaskService());
  }

  late Box<Task> box;

  /// 任务列表
  RxList<DownloadTask> taskQueues = RxList<DownloadTask>();

  /// 已下载、下载中的ID
  RxSet<String> downloadIds = RxSet<String>();

  Future<void> init() async {
    var appDir = await getApplicationSupportDirectory();
    box = await Hive.openBox(
      Db.task,
      path: appDir.path,
    );
  }

  Future<void> put(Task task) async {
    await box.put(task.taskId, task);
  }

  Future<void> delete(String key) async {
    var task = get(key);
    if (task == null) {
      return;
    }
    await box.delete(key);
    var path = task.path;
    await Directory(path).delete(
      recursive: true,
    );
    if (taskQueues.isNotEmpty) {
      taskQueues.removeWhere((element) => element.task.value.taskId == key);
    }
    if (downloadIds.isNotEmpty) {
      downloadIds.removeWhere((element) => element == key);
    }
  }

  List<Task> getDownloadingTask(String savePath) {
    return box.values
        .toList()
        .where((x) => x.path.contains(savePath))
        .where((x) => x.status != DownloadStatusEnum.complete.index)
        .toList();
  }

  List<String> getTaskIds() {
    return box.keys.map((e) => e.toString()).toList();
  }

  Task? get(String taskId) {
    return box.get(taskId);
  }

  List<Task> list() {
    return box.values.toList();
  }

  Future<List<Task>> getTasks(List<String> taskIds) async {
    await init();
    var tasks = box.values
        .where((element) => taskIds.contains(element.taskId))
        .toList();
    tasks.sort((a, b) => b.seqNo.compareTo(a.seqNo));
    return tasks;
  }
}
