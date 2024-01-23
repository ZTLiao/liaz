import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_event.dart';
import 'package:liaz/app/constants/save_path.dart';
import 'package:liaz/app/enums/asset_type_enum.dart';
import 'package:liaz/app/enums/download_status_enum.dart';
import 'package:liaz/app/events/event_bus.dart';
import 'package:liaz/models/db/comic.dart';
import 'package:liaz/models/db/comic_chapter.dart';
import 'package:liaz/models/db/task.dart';
import 'package:liaz/models/dto/download_task.dart';
import 'package:liaz/services/comic_chapter_service.dart';
import 'package:liaz/services/comic_service.dart';
import 'package:liaz/services/download_service.dart';
import 'package:liaz/services/file_item_service.dart';
import 'package:liaz/services/task_service.dart';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class ComicDownloadService extends DownloadService {
  static ComicDownloadService get instance {
    if (Get.isRegistered<ComicDownloadService>()) {
      return Get.find<ComicDownloadService>();
    }
    return Get.put(ComicDownloadService());
  }

  @override
  Future<File?> getCached(String url) async {
    return await getCachedImageFile(url);
  }

  @override
  void updateDownloaded() {
    EventBus.instance.publish(AppEvent.kDownloadComicTopic);
  }

  @override
  Future<String> getSavePath() async {
    var dir = await getApplicationSupportDirectory();
    var directory = Directory(
      path.join(
        dir.path,
        SavePath.comic,
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
    required int comicId,
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
  }) async {
    String taskId = '${comicId}_${chapterId}_${AssetTypeEnum.comic.index}';
    if (!ComicService.instance.exist(comicId)) {
      ComicService.instance.put(Comic(
        comicId: comicId,
        title: title,
        cover: cover,
        categories: categories,
        authors: authors,
        flag: flag,
        browseChapterId: browseChapterId,
      ));
    }
    ComicChapterService.instance.put(ComicChapter(
      chapterId: chapterId,
      chapterName: chapterName,
      seqNo: seqNo,
      taskId: taskId,
      currentIndex: currentIndex,
      comicId: comicId,
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
      types: [],
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
  void deleteChapter(int comicId, int chapterId) async {
    var taskId = '${comicId}_${chapterId}_${AssetTypeEnum.comic.index}';
    var task = TaskService.instance.get(taskId);
    if (task != null) {
      this.delete(task);
    }
    ComicChapterService.instance.delete(chapterId);
  }
}
