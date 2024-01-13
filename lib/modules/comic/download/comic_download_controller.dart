import 'package:get/get.dart';
import 'package:liaz/app/controller/base_controller.dart';
import 'package:liaz/models/comic/comic_detail_model.dart';

class ComicDownloadController extends BaseController {
  final RxSet<int> chapterIds = RxSet();

  final ComicDetailModel comicDetail;

  ComicDownloadController({
    required this.comicDetail,
  });

  void selectAll() {
    var chapterTypes = comicDetail.chapterTypes;
    if (chapterTypes.isEmpty) {
      return;
    }
    for (var chapterType in chapterTypes) {
      for (var chapter in chapterType.chapters) {
        chapterIds.add(chapter.comicChapterId);
      }
    }
  }

  void onSelect(int chapterId) {
    if (chapterIds.contains(chapterId)) {
      chapterIds.remove(chapterId);
    } else {
      chapterIds.add(chapterId);
    }
  }

  void uncheck() {
    chapterIds.clear();
  }

  void onDownload() {}
}
