import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/controller/base_controller.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/models/novel/novel_chapter_model.dart';
import 'package:liaz/models/novel/novel_detail_model.dart';
import 'package:liaz/services/novel_download_service.dart';

class NovelDownloadController extends BaseController {
  final RxSet<int> chapterIds = RxSet();

  final NovelDetailModel novelDetail;

  NovelDownloadController({
    required this.novelDetail,
  });

  void selectAll() {
    var volumes = novelDetail.volumes;
    if (volumes.isEmpty) {
      return;
    }
    for (var volume in volumes) {
      for (var chapter in volume.chapters) {
        chapterIds.add(chapter.novelChapterId);
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

  void onDownload() {
    Map<int, NovelChapterModel> novelChapterMap = {};
    for (var volume in novelDetail.volumes) {
      for (var chapter in volume.chapters) {
        novelChapterMap[chapter.novelChapterId] = chapter;
      }
    }
    for (var chapterId in chapterIds) {
      if (!novelChapterMap.containsKey(chapterId)) {
        continue;
      }
      var novelChapter = novelChapterMap[chapterId];
      NovelDownloadService.instance.addTask(
        novelId: novelDetail.novelId,
        title: novelDetail.title,
        cover: novelDetail.cover,
        categories: StrUtil.listToStr(novelDetail.categories, StrUtil.comma),
        authors: StrUtil.listToStr(novelDetail.authors, StrUtil.comma),
        flag: novelDetail.flag,
        browseChapterId: novelDetail.browseChapterId,
        chapterId: chapterId,
        chapterName: novelChapter!.chapterName,
        seqNo: novelChapter.seqNo,
        currentIndex: novelChapter.currentIndex,
        urls: novelChapter.paths,
      );
    }
    SmartDialog.showToast(AppString.startDownload);
  }
}
