import 'package:flutter/widgets.dart';
import 'package:liaz/app/controller/base_controller.dart';
import 'package:liaz/models/comic/comic_chapter_model.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ComicReaderController extends BaseController {
  final int comicChapterId;
  final int comicId;
  final String comicTitle;
  final String comicCover;
  final bool isLong;
  final ComicChapterModel chapter;
  final FocusNode focusNode = FocusNode();

  /// 预加载控制器
  final PreloadPageController preloadPageController = PreloadPageController();

  /// 上下模式控制器
  final ItemScrollController itemScrollController = ItemScrollController();

  /// 监听上下滚动
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  ComicReaderController({
    required this.comicChapterId,
    required this.comicId,
    required this.comicTitle,
    required this.comicCover,
    required this.isLong,
    required this.chapter,
  });
}
