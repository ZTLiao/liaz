import 'dart:async';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:liaz/app/constants/db.dart';
import 'package:liaz/app/enums/download_status_enum.dart';
import 'package:liaz/models/db/task.dart';
import 'package:path_provider/path_provider.dart';

class TaskService {
  static TaskService get instance => Get.find<TaskService>();
  late Box<Task> box;

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
    await box.delete(key);
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

  List<Task> getTasks(List<String> taskIds) {
    var tasks = box.values
        .where((element) => taskIds.contains(element.taskId))
        .toList();
    tasks.sort((a, b) => b.seqNo.compareTo(a.seqNo));
    return tasks;
  }
}
