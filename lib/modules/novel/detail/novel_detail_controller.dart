import 'package:get/get.dart';
import 'package:liaz/app/constants/app_event.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/constants/yes_or_no.dart';
import 'package:liaz/app/controller/base_controller.dart';
import 'package:liaz/app/enums/recommend_position_enum.dart';
import 'package:liaz/app/enums/recommend_type_enum.dart';
import 'package:liaz/app/events/event_bus.dart';
import 'package:liaz/app/http/request.dart';
import 'package:liaz/app/utils/share_util.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/models/dto/item_model.dart';
import 'package:liaz/models/novel/novel_detail_model.dart';
import 'package:liaz/models/novel/novel_volume_model.dart';
import 'package:liaz/models/recommend/recommend_model.dart';
import 'package:liaz/modules/novel/detail/novel_history_listener.dart';
import 'package:liaz/requests/file_request.dart';
import 'package:liaz/requests/recommend_request.dart';
import 'package:liaz/routes/app_navigator.dart';
import 'package:liaz/services/recommend_service.dart';
import 'package:liaz/services/user_service.dart';

class NovelDetailController extends BaseController {
  final NovelDetailModel detail;

  var recommends = RxList<RecommendModel>([]);

  var isExpandDescription = RxBool(false);
  var isRelateRecommend = RxBool(false);
  var isSubscribe = RxBool(false);
  var isExpandPreview = RxBool(false);
  var chapterIndex = RxInt(0);
  var content = RxString(StrUtil.empty);

  var browseChapterId = RxInt(0);

  var recommendRequest = RecommendRequest();

  NovelDetailController({required this.detail}) {
    isSubscribe.value = detail.isSubscribe;
    browseChapterId.value = detail.browseChapterId;
  }

  @override
  void onInit() async {
    initRelateRecommend();
    EventBus.instance
        .subscribe(AppEvent.kUploadNovelHistory, NovelHistoryListener());
    super.onInit();
  }

  void initRelateRecommend() async {
    var relateRecommends = await recommendRequest
        .recommendByPosition(RecommendPositionEnum.relate.index);
    var novelRecommends = await recommendRequest.recommendNovel(detail.novelId);
    if (relateRecommends.isNotEmpty) {
      for (var relateRecommend in relateRecommends) {
        var recommendType = relateRecommend.recommendType;
        if (recommendType == RecommendTypeEnum.custom.index) {
          recommends.add(relateRecommend);
        } else if (recommendType == RecommendTypeEnum.author.index) {
          var authorRecommends = novelRecommends
              .where((element) => recommendType == element.recommendType)
              .toList();
          for (var authorRecommend in authorRecommends) {
            authorRecommend.recommendId = relateRecommend.recommendId;
            authorRecommend.title =
                authorRecommend.title + StrUtil.space + AppString.works;
            recommends.add(authorRecommend);
          }
        } else if (recommendType == RecommendTypeEnum.category.index) {
          var categoryRecommends = novelRecommends
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

  void subscribe() {
    UserService.instance.novelSubscribe(
        detail.novelId, isSubscribe.value ? YesOrNo.no : YesOrNo.yes);
    isSubscribe.value = !isSubscribe.value;
  }

  void onReadChapter(NovelVolumeModel volume) {
    var chapters = volume.chapters;
    browseChapterId.value = chapters[chapterIndex.value].novelChapterId;
    if (chapters.isNotEmpty &&
        chapters[chapterIndex.value].novelChapterId == detail.browseChapterId) {
      for (var chapter in chapters) {
        if (chapter.novelChapterId == detail.browseChapterId) {
          chapter.currentIndex = detail.currentIndex;
          break;
        }
      }
    }
    AppNavigator.toNovelReader(
      novelChapterId: chapters[chapterIndex.value].novelChapterId,
      chapters: chapters,
    );
  }

  void onPreview(int i, NovelVolumeModel volume) async {
    var index = chapterIndex.value;
    if (index != i) {
      isExpandPreview.value = true;
    } else {
      isExpandPreview.value = !isExpandPreview.value;
    }
    content.value = StrUtil.empty;
    chapterIndex.value = i;
    var path = volume.chapters[i].paths[0];
    path = await FileRequest().getObject(path);
    content.value = await Request.instance.getResource(path);
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

  void startReading() {
    isRelateRecommend.value = false;
    if (browseChapterId.value != 0) {
      for (var valume in detail.volumes) {
        for (var chapter in valume.chapters) {
          if (chapter.novelChapterId == browseChapterId.value) {
            onReadChapter(valume);
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
    EventBus.instance.unSubscribe(AppEvent.kUploadNovelHistory);
    super.onClose();
  }
}
