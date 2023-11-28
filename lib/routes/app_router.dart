import 'package:get/get.dart';
import 'package:liaz/modules/bookshelf/home/bookshelf_home_controller.dart';
import 'package:liaz/modules/category/home/category_home_controller.dart';
import 'package:liaz/modules/comic/search/comic_search_page.dart';
import 'package:liaz/modules/common/empty_page.dart';
import 'package:liaz/modules/index/home/index_home_controller.dart';
import 'package:liaz/modules/index/index_controller.dart';
import 'package:liaz/modules/index/index_page.dart';
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
      name: AppRoute.kComicSearch,
      page: () => const ComicSearchPage(),
    ),
  ];
}
