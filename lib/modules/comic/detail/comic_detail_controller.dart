import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_event.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/constants/yes_or_no.dart';
import 'package:liaz/app/controller/base_controller.dart';
import 'package:liaz/app/enums/asset_type_enum.dart';
import 'package:liaz/app/enums/recommend_position_enum.dart';
import 'package:liaz/app/enums/recommend_type_enum.dart';
import 'package:liaz/app/events/event_bus.dart';
import 'package:liaz/app/global/global.dart';
import 'package:liaz/app/utils/share_util.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/models/comic/comic_chapter_model.dart';
import 'package:liaz/models/comic/comic_detail_model.dart';
import 'package:liaz/models/comic/comic_volume_model.dart';
import 'package:liaz/models/dto/item_model.dart';
import 'package:liaz/models/recommend/recommend_model.dart';
import 'package:liaz/modules/comic/detail/comic_history_listener.dart';
import 'package:liaz/requests/recommend_request.dart';
import 'package:liaz/routes/app_navigator.dart';
import 'package:liaz/services/comic_service.dart';
import 'package:liaz/services/user_service.dart';

class ComicDetailController extends BaseController {
  final ComicDetailModel comicDetail;

  final detail = Rx<ComicDetailModel>(ComicDetailModel.empty());

  var recommends = RxList<RecommendModel>([]);

  var isExpandDescription = RxBool(false);
  var isRelateRecommend = RxBool(false);
  var isSubscribe = RxBool(false);
  var chapterIndex = RxInt(0);
  var browseChapterId = RxInt(0);

  var recommendRequest = RecommendRequest();

  ComicDetailController({required this.comicDetail}) {
    detail.value = comicDetail;
  }

  void initDetail() {
    recommends.clear();
    isSubscribe.value = detail.value.isSubscribe;
    browseChapterId.value = detail.value.browseChapterId;
    isRelateRecommend.value = false;
    isExpandDescription.value = false;
    initRelateRecommend();
  }

  @override
  void onInit() {
    initDetail();
    EventBus.instance.subscribe(
      AppEvent.kUploadComicHistoryTopic,
      ComicHistoryListener(
        (chapterId) {
          browseChapterId.value = chapterId;
        },
      ),
    );
    super.onInit();
  }

  void initRelateRecommend() async {
    var relateRecommends = await recommendRequest
        .recommendByPosition(RecommendPositionEnum.relate.index);
    var comicRecommends =
        await recommendRequest.recommendComic(detail.value.comicId);
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
            authorRecommend.optType = relateRecommend.optType;
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

  void onReadChapter(ComicVolumeModel volume) {
    var chapters = volume.chapters;
    browseChapterId.value = chapters[browseChapterId.value == 0
            ? chapters.length - 1
            : chapterIndex.value]
        .comicChapterId;
    if (chapters[chapterIndex.value].paths.isEmpty) {
      SmartDialog.showToast(AppString.resourceError);
      return;
    }
    var comicChapters = <ComicChapterModel>[];
    if (chapters.isNotEmpty) {
      for (var chapter in chapters) {
        if (chapter.comicChapterId == browseChapterId.value) {
          chapter.currentIndex = detail.value.currentIndex;
        }
        comicChapters.add(ComicChapterModel.fromJson(chapter.toJson()));
      }
    }
    comicChapters.sort((a, b) => a.seqNo.compareTo(b.seqNo));
    AppNavigator.toComicReader(
      comicChapterId: browseChapterId.value,
      chapters: comicChapters,
    );
  }

  void subscribe() {
    UserService.instance.comicSubscribe(
        detail.value.comicId, isSubscribe.value ? YesOrNo.no : YesOrNo.yes);
    isSubscribe.value = !isSubscribe.value;
  }

  void share() {
    if (detail.value.comicId == 0) {
      return;
    }
    var shareUrl = Global.appConfig.shareUrl;
    if (shareUrl.isEmpty) {
      SmartDialog.showToast(AppString.detourRoadUnderConstruction);
      return;
    }
    ShareUtil.share(
      '$shareUrl?objId=${detail.value.comicId}&assetType=${AssetTypeEnum.comic.index}',
      content: detail.value.title,
    );
  }

  void startReading() {
    isRelateRecommend.value = false;
    if (browseChapterId.value != 0) {
      for (var valume in detail.value.volumes) {
        for (var chapter in valume.chapters) {
          if (chapter.comicChapterId == browseChapterId.value) {
            onReadChapter(valume);
            break;
          }
        }
      }
    } else {
      var volumes = detail.value.volumes;
      if (volumes.isNotEmpty) {
        onReadChapter(volumes[0]);
      }
    }
  }

  void onDetail(ItemModel item) async {
    detail.value = await ComicService.instance.getComicDetail(item.objId!);
    initDetail();
  }

  @override
  void onClose() {
    EventBus.instance.unSubscribe(AppEvent.kUploadComicHistoryTopic);
    super.onClose();
  }

  void onDownload() {
    AppNavigator.toComicDownload(detail.value.toJson());
  }
}
