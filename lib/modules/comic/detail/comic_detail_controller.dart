import 'package:get/get.dart';
import 'package:liaz/app/constants/yes_or_no.dart';
import 'package:liaz/app/controller/base_controller.dart';
import 'package:liaz/app/utils/share_util.dart';
import 'package:liaz/models/comic/comic_chapter_model.dart';
import 'package:liaz/models/comic/comic_detail_model.dart';
import 'package:liaz/routes/app_navigator.dart';
import 'package:liaz/services/user_service.dart';

class ComicDetailController extends BaseController {
  final ComicDetailModel detail;

  var isExpandDescription = RxBool(false);
  var isRelateRecommend = RxBool(false);
  var isSubscribe = RxBool(false);

  var browseChapterId = RxInt(0);

  ComicDetailController({required this.detail}) {
    isSubscribe.value = detail.isSubscribe;
    browseChapterId.value = detail.browseChapterId;
  }

  void onReadChapter(ComicChapterModel chapter) {
    browseChapterId.value = chapter.comicChapterId;
    var chapterTypes = detail.chapterTypes;
    var chapterType = chapterTypes
        .firstWhere((element) => element.chapterType == chapter.chapterType);
    var chapters = chapterType.chapters;
    if (chapters.isNotEmpty &&
        chapter.comicChapterId == detail.browseChapterId) {
      for (var chapter in chapters) {
        if (chapter.comicChapterId == detail.browseChapterId) {
          chapter.currentIndex = detail.currentIndex;
          break;
        }
      }
    }
    AppNavigator.toComicReader(
      comicChapterId: chapter.comicChapterId,
      chapters: chapters,
    );
  }

  void subscribe() {
    UserService.instance.comicSubscribe(
        detail.comicId, isSubscribe.value ? YesOrNo.no : YesOrNo.yes);
    isSubscribe.value = !isSubscribe.value;
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
