import 'dart:io';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:liaz/app/constants/app_cache.dart';
import 'package:liaz/app/constants/app_event.dart';
import 'package:liaz/app/constants/db.dart';
import 'package:liaz/app/events/event_bus.dart';
import 'package:liaz/app/global/global.dart';
import 'package:liaz/app/http/dio_request.dart';
import 'package:liaz/app/logger/log.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/models/db/novel.dart';
import 'package:liaz/models/novel/novel_detail_model.dart';
import 'package:liaz/requests/browse_request.dart';
import 'package:liaz/requests/novel_request.dart';
import 'package:liaz/routes/app_navigator.dart';
import 'package:liaz/services/file_item_service.dart';
import 'package:path_provider/path_provider.dart';

import 'package:path/path.dart' as path;

class NovelService {
  static NovelService get instance {
    if (Get.isRegistered<NovelService>()) {
      return Get.find<NovelService>();
    }
    return Get.put(NovelService());
  }

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
      });
      EventBus.instance.publish(AppEvent.kUploadNovelHistoryTopic, chapterId);
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

  void put(Novel novel) {
    box.put(novel.novelId, novel);
  }

  bool exist(int key) {
    return box.values.any((e) => e.novelId == key);
  }

  List<Novel> list() {
    return box.values.toList();
  }

  void delete(int key) {
    box.delete(key);
  }

  Novel get(int novelId) {
    return box.values.where((element) => element.novelId == novelId).first;
  }

  Future<String> getContent(String uniqueId) async {
    var content = await getNovelContent(uniqueId);
    if (content.isNotEmpty) {
      return content;
    }
    content = await DioRequest.instance
        .getResource(await FileItemService.instance.getObject(uniqueId));
    if (content.isNotEmpty) {
      saveNovelContent(uniqueId: uniqueId, content: content);
    }
    return content;
  }

  Future<void> saveNovelContent({
    required String uniqueId,
    required String content,
  }) async {
    try {
      uniqueId = uniqueId.replaceAll(StrUtil.slash, StrUtil.underline);
      var novelDir = await getNovelCacheDirectory();
      var fileName = path.join(novelDir.path, uniqueId);
      var file = File(fileName);
      await file.writeAsString(content);
    } catch (e) {
      Log.logPrint(e);
    }
  }

  Future<Directory> getNovelCacheDirectory() async {
    var dir = await getApplicationSupportDirectory();
    var novelDir = Directory(path.join(dir.path, AppCache.novelCache));
    if (!await novelDir.exists()) {
      novelDir = await novelDir.create();
    }
    return novelDir;
  }

  Future<String> getNovelContent(String uniqueId) async {
    try {
      uniqueId = uniqueId.replaceAll(StrUtil.slash, StrUtil.underline);
      var novelDir = await getNovelCacheDirectory();
      var fileName = path.join(novelDir.path, uniqueId);
      var file = File(fileName);
      if (await file.exists()) {
        var content = await file.readAsString();
        return content;
      }
      return StrUtil.empty;
    } catch (e) {
      Log.logPrint(e);
      return StrUtil.empty;
    }
  }

  Future<int> getCachedSizeBytes() async {
    var novelDir = await getNovelCacheDirectory();
    var size = 0;
    await for (var item in novelDir.list()) {
      size += item.statSync().size;
    }
    return size;
  }

  Future<bool> clearDiskCachedNovels() async {
    try {
      var novelDir = await getNovelCacheDirectory();
      await novelDir.delete(recursive: true);
      return true;
    } catch (e) {
      Log.logPrint(e);
      return false;
    }
  }
}
