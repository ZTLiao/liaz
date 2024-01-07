import 'package:get/get.dart';
import 'package:liaz/app/constants/app_event.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/constants/yes_or_no.dart';
import 'package:liaz/app/controller/base_controller.dart';
import 'package:liaz/app/enums/recommend_position_enum.dart';
import 'package:liaz/app/enums/recommend_type_enum.dart';
import 'package:liaz/app/events/event_bus.dart';
import 'package:liaz/app/utils/share_util.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/models/comic/comic_chapter_model.dart';
import 'package:liaz/models/comic/comic_detail_model.dart';
import 'package:liaz/models/dto/item_model.dart';
import 'package:liaz/models/recommend/recommend_model.dart';
import 'package:liaz/modules/comic/detail/comic_history_listener.dart';
import 'package:liaz/requests/recommend_request.dart';
import 'package:liaz/routes/app_navigator.dart';
import 'package:liaz/services/recommend_service.dart';
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
  void onInit() {
    initRelateRecommend();
    EventBus.instance
        .subscribe(AppEvent.kUploadComicHistory, ComicHistoryListener());
    super.onInit();
  }

  void initRelateRecommend() async {
    var relateRecommends = await recommendRequest
        .recommendByPosition(RecommendPositionEnum.relate.index);
    var comicRecommends = await recommendRequest.recommendComic(detail.comicId);
    if (relateRecommends.isNotEmpty) {
      for (var relateRecommend in relateRecommends) {
        var recommendType = relateRecommend.recommendType;
        if (recommendType == RecommendTypeEnum.custom.index) {
          recommends.add(relateRecommend);
        } else if (recommendType == RecommendTypeEnum.author.index) {
          var authorRecommends = comicRecommends
              .where((element) => recommendType == element.recommendType)
              .toList();
          for (var authorRecommend in authorRecommends) {
            authorRecommend.recommendId = relateRecommend.recommendId;
            authorRecommend.title =
                authorRecommend.title + StrUtil.space + AppString.works;
            recommends.add(authorRecommend);
          }
        } else if (recommendType == RecommendTypeEnum.category.index) {
          relateRecommend.title =
              relateRecommend.title + StrUtil.space + AppString.works;
          var categoryRecommends = comicRecommends
              .where((element) => recommendType == element.recommendType)
              .toList();
          for (var categoryRecommend in categoryRecommends) {
            relateRecommend.items.addAll(categoryRecommend.items);
          }
          recommends.add(relateRecommend);
        }
      }
    }
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

  void onDetail(ItemModel item) {
    RecommendService.instance.onDetail(item);
  }

  @override
  void onClose() {
    EventBus.instance.unSubscribe(AppEvent.kUploadComicHistory);
    super.onClose();
  }
}
