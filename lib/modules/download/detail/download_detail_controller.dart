import 'package:get/get.dart';
import 'package:liaz/app/constants/app_event.dart';
import 'package:liaz/app/enums/asset_type_enum.dart';
import 'package:liaz/app/enums/reader_direction_enum.dart';
import 'package:liaz/app/events/event_bus.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/models/comic/comic_chapter_model.dart';
import 'package:liaz/models/db/task.dart';
import 'package:liaz/models/novel/novel_chapter_model.dart';
import 'package:liaz/modules/download/detail/download_delete_listener.dart';
import 'package:liaz/modules/download/detail/download_detail_listener.dart';
import 'package:liaz/routes/app_navigator.dart';
import 'package:liaz/services/comic_chapter_service.dart';
import 'package:liaz/services/comic_service.dart';
import 'package:liaz/services/novel_chapter_service.dart';
import 'package:liaz/services/novel_service.dart';
import 'package:liaz/services/task_service.dart';

import 'package:path/path.dart' as path;

class DownloadDetailController extends GetxController {
  String title;
  List<String> taskIds;

  var tasks = RxList<Task>([]);

  var checkIds = RxList<String>([]);

  DownloadDetailController({required this.title, required this.taskIds});

  @override
  void onInit() async {
    EventBus.instance
        .subscribe(AppEvent.kDownloadUpdateTopic, DownloadDetailListener());
    EventBus.instance
        .subscribe(AppEvent.kDownloadDeleteTopic, DownloadDeleteListener());
    tasks.addAll(await TaskService.instance.getTasks(taskIds));
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

  void onReadChapter(String taskId) {
    var task = tasks.where((element) => element.taskId == taskId).first;
    var taskIdArray = task.taskId.split(StrUtil.underline);
    var objId = int.parse(taskIdArray[0]);
    var chapterId = int.parse(taskIdArray[1]);
    var assetType = int.parse(taskIdArray[2]);
    if (assetType == AssetTypeEnum.comic.index) {
      toComicChapter(objId, chapterId, task);
    } else if (assetType == AssetTypeEnum.novel.index) {
      toNovelChapter(objId, chapterId, task);
    }
  }

  void toComicChapter(int comicId, int comicChapterId, Task task) {
    List<ComicChapterModel> comicChapters = <ComicChapterModel>[];
    var comic = ComicService.instance.get(comicId);
    for (var task in tasks) {
      var taskIdArray = task.taskId.split(StrUtil.underline);
      var objId = int.parse(taskIdArray[0]);
      var chapterId = int.parse(taskIdArray[1]);
      var comicChapter = ComicChapterService.instance.get(chapterId);
      for (int i = 0; i < task.files.length; i++) {
        task.files[i] = path.join(task.taskId, task.files[i]);
      }
      comicChapters.add(
        ComicChapterModel(
          comicChapterId: chapterId,
          comicId: objId,
          flag: comic.flag,
          chapterName: comicChapter.chapterName,
          chapterType: 0,
          pageNum: task.total,
          seqNo: task.seqNo,
          direction: ReaderDirectionEnum.leftToRight.index,
          updatedAt: 0,
          paths: task.files,
          currentIndex: comicChapter.currentIndex,
          isLocal: true,
        ),
      );
    }
    comicChapters.sort((a, b) => a.seqNo.compareTo(b.seqNo));
    AppNavigator.toComicReader(
      comicChapterId: comicChapterId,
      chapters: comicChapters,
    );
  }

  void toNovelChapter(int novelId, int novelChapterId, Task task) {
    List<NovelChapterModel> novelChapters = <NovelChapterModel>[];
    var comic = NovelService.instance.get(novelId);
    for (var task in tasks) {
      var taskIdArray = task.taskId.split(StrUtil.underline);
      var objId = int.parse(taskIdArray[0]);
      var chapterId = int.parse(taskIdArray[1]);
      var novelChapter = NovelChapterService.instance.get(chapterId);
      for (int i = 0; i < task.files.length; i++) {
        task.files[i] = path.join(task.taskId, task.files[i]);
      }
      novelChapters.add(
        NovelChapterModel(
          novelChapterId: chapterId,
          novelId: objId,
          flag: comic.flag,
          chapterName: novelChapter.chapterName,
          chapterType: 0,
          pageNum: task.total,
          seqNo: task.seqNo,
          direction: ReaderDirectionEnum.leftToRight.index,
          updatedAt: 0,
          paths: task.files,
          currentIndex: novelChapter.currentIndex,
          isLocal: true,
          types: task.types,
        ),
      );
    }
    novelChapters.sort((a, b) => a.seqNo.compareTo(b.seqNo));
    AppNavigator.toNovelReader(
      novelChapterId: novelChapterId,
      chapters: novelChapters,
    );
  }
}
