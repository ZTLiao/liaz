import 'package:liaz/app/enums/asset_type_enum.dart';
import 'package:liaz/app/events/event.dart';
import 'package:liaz/app/events/event_listener.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/routes/app_navigator.dart';
import 'package:liaz/services/comic_chapter_service.dart';
import 'package:liaz/services/comic_service.dart';
import 'package:liaz/services/novel_chapter_service.dart';

class DownloadDeleteListener extends EventListener {
  @override
  void onListen(Event event) {
    var source = event.source;
    if (source == null) {
      return;
    }
    String taskId = source as String;
    var taskIdArray = taskId.split(StrUtil.underline);
    if (taskIdArray.isEmpty) {
      return;
    }
    var objId = int.parse(taskIdArray[0]);
    var chapterId = int.parse(taskIdArray[1]);
    var assetType = int.parse(taskIdArray[2]);
    if (assetType == AssetTypeEnum.comic.index) {
      ComicChapterService.instance.delete(chapterId);
      var chapterIds = ComicChapterService.instance.getChapterIds(objId);
      if (chapterIds.isEmpty) {
        ComicService.instance.delete(objId);
        AppNavigator.closePage();
      }
    } else if (assetType == AssetTypeEnum.novel.index) {
      NovelChapterService.instance.delete(chapterId);
      var chapterIds = NovelChapterService.instance.getChapterIds(objId);
      if (chapterIds.isEmpty) {
        NovelChapterService.instance.delete(objId);
        AppNavigator.closePage();
      }
    }
  }
}
