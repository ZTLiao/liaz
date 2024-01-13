import 'package:get/get.dart';
import 'package:liaz/app/controller/base_controller.dart';
import 'package:liaz/models/novel/novel_detail_model.dart';

class NovelDownloadController extends BaseController {
  final RxSet<int> chapterIds = RxSet();

  final NovelDetailModel novelDetail;

  NovelDownloadController({
    required this.novelDetail,
  });

  void selectAll() {
    var volumes = novelDetail.volumes;
    if (volumes.isEmpty) {
      return;
    }
    for (var volume in volumes) {
      for (var chapter in volume.chapters) {
        chapterIds.add(chapter.novelChapterId);
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
