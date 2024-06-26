import 'dart:io';

import 'package:get/get.dart';
import 'package:liaz/app/constants/app_event.dart';
import 'package:liaz/app/constants/save_path.dart';
import 'package:liaz/app/enums/asset_type_enum.dart';
import 'package:liaz/app/enums/download_status_enum.dart';
import 'package:liaz/app/events/event_bus.dart';
import 'package:liaz/models/db/novel.dart';
import 'package:liaz/models/db/novel_chapter.dart';
import 'package:liaz/models/db/task.dart';
import 'package:liaz/models/dto/download_task.dart';
import 'package:liaz/services/download_service.dart';
import 'package:liaz/services/file_item_service.dart';
import 'package:liaz/services/novel_chapter_service.dart';
import 'package:liaz/services/novel_service.dart';
import 'package:liaz/services/task_service.dart';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class NovelDownloadService extends DownloadService {
  static NovelDownloadService get instance {
    if (Get.isRegistered<NovelDownloadService>()) {
      return Get.find<NovelDownloadService>();
    }
    return Get.put(NovelDownloadService());
  }

  @override
  Future<File?> getCached(String url) async {
    return null;
  }

  @override
  void updateDownloaded() {
    EventBus.instance.publish(AppEvent.kDownloadNovelTopic);
  }

  @override
  Future<String> getSavePath() async {
    var dir = await getApplicationSupportDirectory();
    var directory = Directory(
      path.join(
        dir.path,
        SavePath.novel,
      ),
    );
    if (!await directory.exists()) {
      directory = await directory.create(
        recursive: true,
      );
    }
    return directory.path;
  }

  void addTask({
    required int novelId,
    required String title,
    required String cover,
    required String categories,
    required String authors,
    required int flag,
    required int browseChapterId,
    required int chapterId,
    required String chapterName,
    required int seqNo,
    required int currentIndex,
    required List<String> urls,
    required List<String> types,
  }) async {
    String taskId = '${novelId}_${chapterId}_${AssetTypeEnum.novel.index}';
    if (!NovelService.instance.exist(novelId)) {
      NovelService.instance.put(
        Novel(
          novelId: novelId,
          title: title,
          cover: cover,
          categories: categories,
          authors: authors,
          flag: flag,
          browseChapterId: browseChapterId,
        ),
      );
    }
    NovelChapterService.instance.put(NovelChapter(
      chapterId: chapterId,
      chapterName: chapterName,
      seqNo: seqNo,
      taskId: taskId,
      currentIndex: currentIndex,
      novelId: novelId,
    ));
    for (int i = 0; i < urls.length; i++) {
      urls[i] = await FileItemService.instance.getObject(urls[i]);
    }
    var task = Task(
      taskId: taskId,
      taskName: chapterName,
      path: path.join(savePath, taskId),
      files: [],
      urls: urls,
      index: 0,
      total: urls.length,
      status: DownloadStatusEnum.wait.index,
      createdAt: DateTime.now().millisecond,
      seqNo: seqNo,
      types: types,
    );
    TaskService.instance.put(task);
    TaskService.instance.taskQueues.add(DownloadTask(
      task,
      onUpdate: updateQueue,
      getCached: getCached,
    ));
    updateQueue();
  }

  ///删除
  void deleteChapter(int novelId, int chapterId) async {
    var taskId = '${novelId}_${chapterId}_${AssetTypeEnum.novel.index}';
    var task = TaskService.instance.get(taskId);
    if (task != null) {
      delete(task);
    }
    NovelChapterService.instance.delete(chapterId);
  }
}
