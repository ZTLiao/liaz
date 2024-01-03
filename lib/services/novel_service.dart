import 'package:get/get.dart';
import 'package:liaz/app/constants/app_event.dart';
import 'package:liaz/app/events/event_bus.dart';
import 'package:liaz/app/global/global.dart';
import 'package:liaz/app/logger/log.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/requests/browse_request.dart';
import 'package:liaz/requests/novel_request.dart';
import 'package:liaz/routes/app_navigator.dart';

class NovelService {
  static NovelService get instance => Get.find<NovelService>();

  final _novelRequest = NovelRequest();

  final _browseRequest = BrowseRequest();

  void toNovelDetail(int novelId) async {
    _novelRequest
        .novelDetail(novelId)
        .then((value) => {AppNavigator.toNovelDetail(value.toJson())});
  }

  void uploadHistory(int objId, int assetType, int chapterId,
      String chapterName, String path, int stopIndex) {
    try {
      _novelRequest.getNovel(objId).then((value) {
        var cover = value.cover;
        if (cover.contains(StrUtil.question)) {
          cover = cover
              .split(StrUtil.question)[0]
              .replaceAll(Global.appConfig.fileUrl, StrUtil.empty);
        }
        if (path.contains(StrUtil.question)) {
          path = path
              .split(StrUtil.question)[0]
              .replaceAll(Global.appConfig.fileUrl, StrUtil.empty);
        }
        _browseRequest.uploadHistory(
          objId,
          assetType,
          value.title,
          cover,
          chapterId,
          chapterName,
          path,
          stopIndex,
        );
      });
      EventBus.instance.publish(AppEvent.kUploadNovelHistory, chapterId);
    } catch (error, stackTrace) {
      Log.e(error.toString(), stackTrace);
    }
  }

  void onReadChapter(int novelChapterId) async {
    var chapters = await _novelRequest.getNovelCatalogue(novelChapterId);
    AppNavigator.toNovelReader(
      novelChapterId: novelChapterId,
      chapters: chapters,
    );
  }
}
