import 'package:get/get.dart';
import 'package:liaz/app/controller/base_controller.dart';
import 'package:liaz/app/utils/share_util.dart';
import 'package:liaz/models/novel/novel_chapter_model.dart';
import 'package:liaz/models/novel/novel_detail_model.dart';
import 'package:liaz/routes/app_navigator.dart';

class NovelDetailController extends BaseController {
  final NovelDetailModel detail;
  var isExpandDescription = RxBool(false);
  var isRelateRecommend = RxBool(false);

  NovelDetailController({required this.detail});

  void onReadChapter(NovelChapterModel chapter) {
    // var chapterTypes = detail.chapters;
    // if (chapterTypes == null) {
    //   return;
    // }
    // var chapterType = chapterTypes
    //     .firstWhere((element) => element.chapterType == chapter.chapterType);
    // AppNavigator.toNovelReader(
    //   novelChapterId: chapter.novelChapterId,
    //   chapters: chapterType.chapters,
    // );
  }

  void share() {
    if (detail.novelId == 0) {
      return;
    }
    ShareUtil.share(
      'https://www.baidu.com',
      content: detail.title,
    );
  }
}
