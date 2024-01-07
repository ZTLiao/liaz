import 'package:get/get.dart';
import 'package:liaz/app/constants/app_event.dart';
import 'package:liaz/app/constants/yes_or_no.dart';
import 'package:liaz/app/controller/base_controller.dart';
import 'package:liaz/app/enums/recommend_position_enum.dart';
import 'package:liaz/app/enums/recommend_type_enum.dart';
import 'package:liaz/app/events/event_bus.dart';
import 'package:liaz/app/utils/share_util.dart';
import 'package:liaz/models/comic/comic_chapter_model.dart';
import 'package:liaz/models/comic/comic_detail_model.dart';
import 'package:liaz/models/recommend/recommend_model.dart';
import 'package:liaz/modules/comic/detail/comic_history_listener.dart';
import 'package:liaz/requests/recommend_request.dart';
import 'package:liaz/routes/app_navigator.dart';
import 'package:liaz/services/user_service.dart';

class ComicDetailController extends BaseController {
  final ComicDetailModel detail;

  var recommends = RxList<RecommendModel>([]);

  var isExpandDescription = RxBool(false);
  var isRelateRecommend = RxBool(false);
  var isSubscribe = RxBool(false);

  var browseChapterId = RxInt(0);

  var recommendRequest = RecommendRequest();

  ComicDetailController({required this.detail}) {
    isSubscribe.value = detail.isSubscribe;
    browseChapterId.value = detail.browseChapterId;
  }

  @override
  void onInit() async {
    var relateRecommends = await recommendRequest
        .recommendByPosition(RecommendPositionEnum.relate.index);
    if (relateRecommends.isNotEmpty) {
      recommends.addAll(relateRecommends
          .where((element) =>
              element.recommendType == RecommendTypeEnum.custom.index)
          .toList());
    }
    EventBus.instance
        .subscribe(AppEvent.kUploadComicHistory, ComicHistoryListener());
    super.onInit();
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

  void startReading() {
    isRelateRecommend.value = false;
    if (browseChapterId.value != 0) {
      for (var chapterType in detail.chapterTypes) {
        for (var chapter in chapterType.chapters) {
          if (chapter.comicChapterId == browseChapterId.value) {
            onReadChapter(chapter);
            break;
          }
        }
      }
    }
  }

  @override
  void onClose() {
    EventBus.instance.unSubscribe(AppEvent.kUploadComicHistory);
    super.onClose();
  }
}
