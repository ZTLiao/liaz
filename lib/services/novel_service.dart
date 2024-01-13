import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:liaz/app/constants/app_event.dart';
import 'package:liaz/app/constants/db.dart';
import 'package:liaz/app/events/event_bus.dart';
import 'package:liaz/app/global/global.dart';
import 'package:liaz/app/logger/log.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/models/db/novel.dart';
import 'package:liaz/models/novel/novel_detail_model.dart';
import 'package:liaz/requests/browse_request.dart';
import 'package:liaz/requests/novel_request.dart';
import 'package:liaz/routes/app_navigator.dart';
import 'package:path_provider/path_provider.dart';

class NovelService {
  static NovelService get instance => Get.find<NovelService>();

  late Box<Novel> box;

  Future<void> init() async {
    var appDir = await getApplicationSupportDirectory();
    box = await Hive.openBox(
      Db.novel,
      path: appDir.path,
    );
  }

  final _novelRequest = NovelRequest();

  final _browseRequest = BrowseRequest();

  void toNovelDetail(int novelId, {replace = false}) {
    _novelRequest.novelDetail(novelId).then((value) => {
          AppNavigator.toNovelDetail(
            value.toJson(),
            replace: replace,
          )
        });
  }

  Future<NovelDetailModel> getNovelDetail(int novelId) async {
    return await _novelRequest.novelDetail(novelId);
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
        EventBus.instance.publish(AppEvent.kUploadNovelHistoryTopic, chapterId);
      });
    } catch (error, stackTrace) {
      Log.e(error.toString(), stackTrace);
    }
  }

  void toReadChapter(int novelChapterId) async {
    var chapters = await _novelRequest.getNovelCatalogue(novelChapterId);
    if (chapters.isEmpty) {
      return;
    }
    AppNavigator.toNovelReader(
      novelChapterId: novelChapterId,
      chapters: chapters,
    );
  }
}
