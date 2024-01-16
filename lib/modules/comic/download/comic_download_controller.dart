import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/controller/base_controller.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/models/comic/comic_chapter_model.dart';
import 'package:liaz/models/comic/comic_detail_model.dart';
import 'package:liaz/services/comic_chapter_service.dart';
import 'package:liaz/services/comic_download_service.dart';

class ComicDownloadController extends BaseController {
  final RxSet<int> chapterIds = RxSet();

  final ComicDetailModel comicDetail;

  ComicDownloadController({
    required this.comicDetail,
  });

  @override
  void onInit() {
    chapterIds.addAll(ComicChapterService.instance.getChapterIds(comicDetail.comicId));
    super.onInit();
  }

  void selectAll() {
    var chapterTypes = comicDetail.chapterTypes;
    if (chapterTypes.isEmpty) {
      return;
    }
    for (var chapterType in chapterTypes) {
      for (var chapter in chapterType.chapters) {
        chapterIds.add(chapter.comicChapterId);
      }
    }
  }

  void onSelect(int chapterId) {
    if (chapterIds.contains(chapterId)) {
      chapterIds.remove(chapterId);
    } else {
      chapterIds.add(chapterId);
    }
  }

  void uncheck() {
    chapterIds.clear();
  }

  void onDownload() async {
    Map<int, ComicChapterModel> comicChapterMap = {};
    for (var chapterType in comicDetail.chapterTypes) {
      for (var chapter in chapterType.chapters) {
        comicChapterMap[chapter.comicChapterId] = chapter;
      }
    }
    for (var chapterId in chapterIds) {
      if (!comicChapterMap.containsKey(chapterId)) {
        continue;
      }
      var comicChapter = comicChapterMap[chapterId];
      ComicDownloadService.instance.addTask(
        comicId: comicDetail.comicId,
        title: comicDetail.title,
        cover: comicDetail.cover,
        categories: StrUtil.listToStr(comicDetail.categories, StrUtil.comma),
        authors: StrUtil.listToStr(comicDetail.authors, StrUtil.comma),
        flag: comicDetail.flag,
        browseChapterId: comicDetail.browseChapterId,
        chapterId: chapterId,
        chapterName: comicChapter!.chapterName,
        seqNo: comicChapter.seqNo,
        currentIndex: comicChapter.currentIndex,
        urls: comicChapter.paths,
      );
    }
    SmartDialog.showToast(AppString.startDownload);
  }
}
