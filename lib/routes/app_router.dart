import 'package:get/get.dart';
import 'package:liaz/modules/bookshelf/home/bookshelf_home_controller.dart';
import 'package:liaz/modules/category/home/category_home_controller.dart';
import 'package:liaz/modules/comic/detail/comic_detail_controller.dart';
import 'package:liaz/modules/comic/detail/comic_detail_page.dart';
import 'package:liaz/modules/comic/reader/comic_reader_controller.dart';
import 'package:liaz/modules/comic/reader/comic_reader_page.dart';
import 'package:liaz/modules/common/empty_page.dart';
import 'package:liaz/modules/common/h5/h5_web_view_page.dart';
import 'package:liaz/modules/index/home/index_home_controller.dart';
import 'package:liaz/modules/index/index_controller.dart';
import 'package:liaz/modules/index/index_page.dart';
import 'package:liaz/modules/novel/detail/novel_detail_controller.dart';
import 'package:liaz/modules/novel/detail/novel_detail_page.dart';
import 'package:liaz/modules/search/home/search_home_page.dart';
import 'package:liaz/modules/user/home/user_home_controller.dart';
import 'package:liaz/routes/app_route.dart';

class AppRouter {
  AppRouter._();

  static final routes = [
    GetPage(
      name: AppRoute.kRoot,
      page: () => const EmptyPage(),
    ),
    GetPage(
      name: AppRoute.kIndex,
      page: () => const IndexPage(),
      bindings: [
        BindingsBuilder.put(() => IndexController()),
        BindingsBuilder.put(() => IndexHomeController()),
        BindingsBuilder.put(() => CategoryHomeController()),
        BindingsBuilder.put(() => BookshelfHomeController()),
        BindingsBuilder.put(() => UserHomeController()),
      ],
    ),
    GetPage(
      name: AppRoute.kComicReader,
      page: () => const ComicReaderPage(),
      binding: BindingsBuilder.put(
        () => ComicReaderController(
          comicChapterId: Get.arguments['comicChapterId'],
          comicId: Get.arguments['comicId'],
          comicTitle: Get.arguments['comicTitle'],
          comicCover: Get.arguments['comicCover'],
          chapter: Get.arguments['chapter'],
          chapters: Get.arguments['chapters'],
          isLong: Get.arguments['isLong'] ?? false,
        ),
      ),
    ),
    GetPage(
      name: AppRoute.kSearch,
      page: () => SearchHomePage(),
    ),
    GetPage(
      name: AppRoute.kWebView,
      page: () => H5WebViewPage(
        url: Get.arguments['url'],
      ),
    ),
    GetPage(
      name: AppRoute.kComicDetail,
      page: () => const ComicDetailPage(),
      binding: BindingsBuilder.put(
        () => ComicDetailController(
          id: Get.arguments['id'],
        ),
      ),
    ),
    GetPage(
      name: AppRoute.kNovelDetail,
      page: () => const NovelDetailPage(),
      binding: BindingsBuilder.put(
        () => NovelDetailController(
          id: Get.arguments['id'],
        ),
      ),
    ),
  ];
}
