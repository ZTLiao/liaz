import 'package:liaz/app/utils/str_util.dart';

class ComicChapterDetailModel {
  int chapterId;
  int comicId;
  int chapterOrder;
  int direction;
  String chapterTitle;
  List<String> pageUrls;
  int picNum;
  int commentCount;
  bool isLocal;

  ComicChapterDetailModel({
    required this.chapterId,
    required this.comicId,
    required this.chapterOrder,
    required this.direction,
    required this.chapterTitle,
    required this.pageUrls,
    required this.picNum,
    required this.commentCount,
    this.isLocal = false,
  });

  factory ComicChapterDetailModel.empty() => ComicChapterDetailModel(
        chapterId: 0,
        comicId: 0,
        chapterOrder: 0,
        direction: 0,
        chapterTitle: StrUtil.empty,
        pageUrls: [],
        picNum: 0,
        commentCount: 0,
      );
}
