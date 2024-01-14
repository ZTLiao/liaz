import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:liaz/app/constants/db.dart';
import 'package:liaz/models/db/novel_chapter.dart';
import 'package:path_provider/path_provider.dart';

class NovelChapterService {
  static NovelChapterService get instance => Get.find<NovelChapterService>();
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

  void delete(int chapterId) {
    box.delete(chapterId);
  }
}
