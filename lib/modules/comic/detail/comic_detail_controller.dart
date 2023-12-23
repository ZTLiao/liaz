import 'package:get/get.dart';
import 'package:liaz/app/controller/base_controller.dart';
import 'package:liaz/app/utils/share_util.dart';
import 'package:liaz/models/comic/comic_chapter_model.dart';
import 'package:liaz/models/comic/comic_detail_model.dart';
import 'package:liaz/routes/app_navigator.dart';

class ComicDetailController extends BaseController {
  final ComicDetailModel detail;

  var isExpandDescription = RxBool(false);
  var isRelateRecommend = RxBool(false);

  ComicDetailController({required this.detail});

  void onReadChapter(ComicChapterModel chapter) {
    var chapterTypes = detail.chapterTypes;
    if (chapterTypes == null) {
      return;
    }
    var chapterType = chapterTypes
        .firstWhere((element) => element.chapterType == chapter.chapterType);
    AppNavigator.toComicReader(
      comicChapterId: chapter.comicChapterId,
      chapters: chapterType.chapters,
    );
  }

  void share() {
    if (detail.comicId == 0) {
      return;
    }
    ShareUtil.share(
      'https://www.baidu.com',
      content: detail.title,
    );
  }
}
