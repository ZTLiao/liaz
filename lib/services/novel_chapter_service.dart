import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:liaz/app/constants/db.dart';
import 'package:liaz/models/db/novel_chapter.dart';
import 'package:path_provider/path_provider.dart';

class NovelChapterService {
  static NovelChapterService get instance {
    if (Get.isRegistered<NovelChapterService>()) {
      return Get.find<NovelChapterService>();
    }
    return Get.put(NovelChapterService());
  }

  late Box<NovelChapter> box;

  Future<void> init() async {
    var appDir = await getApplicationSupportDirectory();
    box = await Hive.openBox(
      Db.novelChapter,
      path: appDir.path,
    );
  }

  void put(NovelChapter novelChapter) {
    box.put(novelChapter.chapterId, novelChapter);
  }

  void delete(int key) {
    box.delete(key);
  }

  List<String> getTaskId(int novelId) {
    return box.values
        .where((element) => element.novelId == novelId)
        .map((e) => e.taskId)
        .toList();
  }

  List<int> getChapterIds(int novelId) {
    return box.values
        .where((element) => element.novelId == novelId)
        .map((e) => e.chapterId)
        .toList();
  }

  NovelChapter get(int key) {
    return box.values.where((element) => element.chapterId == key).first;
  }
}
