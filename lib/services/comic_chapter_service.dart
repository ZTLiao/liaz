import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:liaz/app/constants/db.dart';
import 'package:liaz/models/db/comic_chapter.dart';
import 'package:path_provider/path_provider.dart';

class ComicChapterService {
  static ComicChapterService get instance => Get.find<ComicChapterService>();
  late Box<ComicChapter> box;

  Future<void> init() async {
    var appDir = await getApplicationSupportDirectory();
    box = await Hive.openBox(
      Db.comicChapter,
      path: appDir.path,
    );
  }

  void put(ComicChapter comicChapter) {
    box.put(comicChapter.chapterId, comicChapter);
  }

  void delete(int chapterId) {
    box.delete(chapterId);
  }
}
