import 'package:get/get.dart';
import 'package:liaz/app/controller/base_controller.dart';
import 'package:liaz/models/comic/comic_chapter_item_model.dart';
import 'package:liaz/models/comic/comic_chapter_model.dart';
import 'package:liaz/models/comic/comic_detail_model.dart';
import 'package:liaz/routes/app_navigator.dart';

class ComicDetailController extends BaseController {
  final ComicDetailModel detail;

  var isExpandDescription = RxBool(false);
  var isRelateRecommend = RxBool(false);

  ComicDetailController({required this.detail});

  void onReadChapter(ComicChapterModel chapter) {
    var chapterItem = ComicChapterItemModel(
      comicChapterId: chapter.comicChapterId,
      comicId: chapter.comicId,
      flag: chapter.flag,
      chapterName: chapter.chapterName,
      seqNo: chapter.seqNo,
      paths: chapter.paths,
      direction: chapter.direction,
      isLocal: false,
    );
    var chapterTypes = detail.chapterTypes;
    if (chapterTypes == null) {
      return;
    }
    var chapterType = chapterTypes
        .firstWhere((element) => element.chapterType == chapter.chapterType);
    AppNavigator.toComicReader(
      comicChapterId: chapter.comicChapterId,
      comicId: chapter.comicId,
      comicTitle: detail.title,
      comicCover: detail.cover,
      isLong: detail.isLong,
      chapter: chapterItem,
      chapters: chapterType.chapters,
    );
  }
}
