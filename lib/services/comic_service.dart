import 'package:get/get.dart';
import 'package:liaz/app/global/global.dart';
import 'package:liaz/app/logger/log.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/requests/browse_request.dart';
import 'package:liaz/requests/comic_request.dart';
import 'package:liaz/routes/app_navigator.dart';

class ComicService {
  static ComicService get instance => Get.find<ComicService>();

  final _comicRequest = ComicRequest();

  final _browseRequest = BrowseRequest();

  void toComicDetail(int comicId) async {
    _comicRequest
        .comicDetail(comicId)
        .then((value) => {AppNavigator.toComicDetail(value.toJson())});
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
      });
    } catch (error, stackTrace) {
      Log.e(error.toString(), stackTrace);
    }
  }
}
