import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:liaz/app/constants/app_event.dart';
import 'package:liaz/app/constants/db.dart';
import 'package:liaz/app/events/event_bus.dart';
import 'package:liaz/app/global/global.dart';
import 'package:liaz/app/logger/log.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/models/comic/comic_detail_model.dart';
import 'package:liaz/models/db/comic.dart';
import 'package:liaz/requests/browse_request.dart';
import 'package:liaz/requests/comic_request.dart';
import 'package:liaz/routes/app_navigator.dart';
import 'package:path_provider/path_provider.dart';

class ComicService {
  static ComicService get instance {
    if (Get.isRegistered<ComicService>()) {
      return Get.find<ComicService>();
    }
    return Get.put(ComicService());
  }

  late Box<Comic> box;

  Future<void> init() async {
    var appDir = await getApplicationSupportDirectory();
    box = await Hive.openBox(
      Db.comic,
      path: appDir.path,
    );
  }

  final _comicRequest = ComicRequest();

  final _browseRequest = BrowseRequest();

  void toComicDetail(int comicId, {replace = false}) {
    _comicRequest.comicDetail(comicId).then((value) => {
          AppNavigator.toComicDetail(
            value.toJson(),
            replace: replace,
          )
        });
  }

  Future<ComicDetailModel> getComicDetail(int comicId) async {
    return await _comicRequest.comicDetail(comicId);
  }

  void uploadHistory(int objId, int assetType, int chapterId,
      String chapterName, String path, int stopIndex) {
    try {
      _comicRequest.getComic(objId).then((value) {
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
        EventBus.instance.publish(AppEvent.kUploadComicHistoryTopic, chapterId);
      });
    } catch (error, stackTrace) {
      Log.e(error.toString(), stackTrace);
    }
  }

  void toReadChapter(int comicChapterId) async {
    var chapters = await _comicRequest.getComicCatalogue(comicChapterId);
    if (chapters.isEmpty) {
      return;
    }
    AppNavigator.toComicReader(
      comicChapterId: comicChapterId,
      chapters: chapters,
    );
  }

  void put(Comic comic) {
    box.put(comic.comicId, comic);
  }

  Comic get(int comicId) {
    return box.values.where((element) => element.comicId == comicId).first;
  }

  bool exist(int key) {
    return box.values.any((e) => e.comicId == key);
  }

  List<Comic> list() {
    return box.values.toList();
  }

  void delete(int key) {
    box.delete(key);
  }
}
