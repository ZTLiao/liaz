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
import 'package:liaz/app/http/dio_request.dart';
import 'package:liaz/app/utils/share_util.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/models/dto/item_model.dart';
import 'package:liaz/models/novel/novel_chapter_model.dart';
import 'package:liaz/models/novel/novel_detail_model.dart';
import 'package:liaz/models/novel/novel_volume_model.dart';
import 'package:liaz/models/recommend/recommend_model.dart';
import 'package:liaz/modules/novel/detail/novel_history_listener.dart';
import 'package:liaz/requests/recommend_request.dart';
import 'package:liaz/routes/app_navigator.dart';
import 'package:liaz/services/file_item_service.dart';
import 'package:liaz/services/novel_service.dart';
import 'package:liaz/services/user_service.dart';

class NovelDetailController extends BaseController {
  final NovelDetailModel novelDetail;

  final detail = Rx<NovelDetailModel>(NovelDetailModel.empty());

  var recommends = RxList<RecommendModel>([]);

  var isExpandDescription = RxBool(false);
  var isRelateRecommend = RxBool(false);
  var isSubscribe = RxBool(false);
  var isExpandPreview = RxBool(false);
  var chapterIndex = RxInt(0);
  var content = RxString(StrUtil.empty);

  var browseChapterId = RxInt(0);

  var recommendRequest = RecommendRequest();

  NovelDetailController({required this.novelDetail}) {
    detail.value = novelDetail;
  }

  void initDetail() {
    recommends.clear();
    isSubscribe.value = detail.value.isSubscribe;
    browseChapterId.value = detail.value.browseChapterId;
    isExpandDescription.value = false;
    isRelateRecommend.value = false;
    isExpandPreview.value = false;
    chapterIndex.value = 0;
    content.value = StrUtil.empty;
    initRelateRecommend();
  }

  @override
  void onInit() async {
    initRelateRecommend();
    EventBus.instance.subscribe(
      AppEvent.kUploadNovelHistoryTopic,
      NovelHistoryListener(
        (history) {
          browseChapterId.value = history.chapterId;
          detail.value.currentIndex = history.currentIndex;
          EventBus.instance.publish(AppEvent.kSubscribeNovelTopic);
        },
      ),
    );
    super.onInit();
  }

  void initRelateRecommend() async {
    var relateRecommends = await recommendRequest
        .recommendByPosition(RecommendPositionEnum.relate.index);
    var novelRecommends =
        await recommendRequest.recommendNovel(detail.value.novelId);
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
        detail.value.novelId, isSubscribe.value ? YesOrNo.no : YesOrNo.yes);
    isSubscribe.value = !isSubscribe.value;
    EventBus.instance.publish(AppEvent.kSubscribeNovelTopic);
  }

  void onReadChapter(NovelVolumeModel volume, {isReplace = true}) {
    var chapters = volume.chapters;
    if (isReplace) {
      browseChapterId.value = chapters[chapterIndex.value].novelChapterId;
    }
    if (chapters[chapterIndex.value].paths.isEmpty) {
      SmartDialog.showToast(AppString.resourceError);
      return;
    }
    var volumes = detail.value.volumes;
    if (volumes.isEmpty) {
      return;
    }
    var novelChapters = <NovelChapterModel>[];
    for (int i = volumes.length - 1; i >= 0; i--) {
      var value = volumes[i];
      for (var chapter in value.chapters) {
        if (chapter.novelChapterId == browseChapterId.value) {
          chapter.currentIndex = detail.value.currentIndex;
        }
        novelChapters.add(NovelChapterModel.fromJson(chapter.toJson()));
      }
    }
    AppNavigator.toNovelReader(
      novelChapterId: chapters[chapterIndex.value].novelChapterId,
      chapters: novelChapters,
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
    path = await FileItemService.instance.getObject(path);
    content.value = await DioRequest.instance.getResource(path);
  }

  void share() {
    if (detail.value.novelId == 0) {
      return;
    }
    var shareUrl = Global.appConfig.shareUrl;
    ShareUtil.share(
      '$shareUrl?objId=${detail.value.novelId}&assetType=${AssetTypeEnum.novel.index}',
      content: detail.value.title,
    );
  }

  void startReading() {
    isRelateRecommend.value = false;
    if (browseChapterId.value != 0) {
      for (var volume in detail.value.volumes) {
        for (var chapter in volume.chapters) {
          if (chapter.novelChapterId == browseChapterId.value) {
            onReadChapter(
              volume,
              isReplace: false,
            );
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
    detail.value = await NovelService.instance.getNovelDetail(item.objId!);
    initDetail();
  }

  @override
  void onClose() {
    EventBus.instance.unSubscribe(AppEvent.kUploadNovelHistoryTopic);
    super.onClose();
  }

  void onDownload() {
    AppNavigator.toNovelDownload(detail.value.toJson());
  }
}
